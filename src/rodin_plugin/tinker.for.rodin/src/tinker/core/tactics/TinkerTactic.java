package tinker.core.tactics;

import javax.swing.JFileChooser;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.FileDialog;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PlatformUI;
import org.eventb.core.seqprover.IProofMonitor;
import org.eventb.core.seqprover.IProofTreeNode;
import org.eventb.core.seqprover.ITactic;

import tinker.core.execute.Command;
import tinker.core.execute.CommandExecutor;
import tinker.core.execute.CommandParser;
import tinker.core.execute.TinkerSession;
import tinker.core.socket.TinkerConnector;
import tinker.core.socket.TinkerConnector.RodinCancelInteruption;
import tinker.core.socket.TinkerConnector.TinkerSessionEnd;
import tinker.core.states.PluginStates;
import tinker.core.states.SocketStates;
import tinker.core.states.TacticStates;

public class TinkerTactic implements ITactic {

	private TinkerSession session;

	public TinkerTactic() {

	}

	private IWorkbenchWindow getThisWorkBench() {
		// It is assumed that there is only one Rodin Instance
		// .getWorkbenchWindows()[0]);

		IWorkbenchWindow[] windows = PlatformUI.getWorkbench().getWorkbenchWindows();
		return windows[0];
	}

	Shell shell;
	Display disp;

	public String open_psgraph() {
		disp=new Display();
		shell=new Shell(disp);
		
		FileDialog dialog = new FileDialog(shell, SWT.OPEN);
		dialog.setFilterExtensions(new String[] { "*.psgraph" });
		dialog.setFilterPath("c:\\temp");
		String result = dialog.open().replace("\\", "/");
		return result;
	}

	@Override
	public Object apply(IProofTreeNode ptNode, IProofMonitor pm) {

		this.session = new TinkerSession(this.getThisWorkBench(), pm);

		String ps = open_psgraph();
		session.setPsgraph(ps);
		pm.setTask("Wait for Tinker..");

		TinkerConnector tinker = new TinkerConnector(pm, session);
		String reply_command = null;
		String exception_info = null;

		try {
			// Plugin Listening
			if (session.getPluginSate() == PluginStates.READY) {
				session.setPluginSate(PluginStates.CONNECTING);
				session.setSocketState(SocketStates.LISTENING);

				System.out.println("Waiting for Tinker to connect");
				tinker.listen();
			}
			// Plugin Applying
			session.setPluginSate(PluginStates.WAITING);
			while (session.getTacticState() == TacticStates.APPLYING) {
				String read;
				System.out.println("Waiting for command");
				// Read socket, if cancelled, tinker connector will throw an
				// RodinCancelInteruption. If tinker requested a stop, then it
				// throws an TinkerSessionEnd
				read = tinker.fromTinker();
				session.setPluginSate(PluginStates.APPLYING);
				Command cmd = CommandParser.parseCommand(read);

				if (cmd.getCommand().equals("SESSION_END")) {
					throw new TinkerSessionEnd();

				}
				// Set state to RP_STATE_EXECUTING so the command executor can
				// execute
				// Execute the command from tinker
				reply_command = CommandExecutor.execute(cmd, ptNode, pm, tinker, session);

				// after execution, check if user has clicked Cancel. If so then
				// throw exception
				if (pm == null || pm.isCanceled()) {

					throw new RodinCancelInteruption(PluginStates.CANCELLATION_IN_PROGRESS);

				}

				if (session.getTacticState() == TacticStates.APPLYING) {
					session.setSocketState(SocketStates.SENDING_CMD);
					tinker.toTinker(reply_command);

				} else {
					throw new Exception("Executing while not in EXECUTION STATE");
				}

				// After sending command to Tinker, Rodin Plugin state is set
				// back to WAITING
				// session.setPluginSate(PluginStates.WAITING);

			}
		} catch (TinkerSessionEnd e1) {
			// Tinker stops the session
			if (session.getPluginSate() == PluginStates.WAITING) {
				// Tinker send SESSION_END while Rodin plugin is reading
				session.setTacticState(TacticStates.CANCELLING);
			} else if (session.getPluginSate() == PluginStates.CANCELLATION_ORDERED) {

			}
			session.setPluginSate(PluginStates.DISCONNECTING);
		} catch (RodinCancelInteruption e1) {
			// When Cancel Button is clicked
			if (session.getSocketState() == SocketStates.LISTENING
					&& session.getPluginSate() == PluginStates.CONNECTING) {
				session.setTacticState(TacticStates.DONE);
			} else {
				session.setTacticState(TacticStates.CANCELLING);
			}
			System.out.println("Clicked Cancel in Rodin. Set Plugin State=" + e1.GetState());
			session.setPluginSate(e1.GetState());

		} catch (Exception e) {
			e.printStackTrace();
			exception_info = e.getMessage();

		}

		try {
			if (session.getPluginSate() == PluginStates.CANCELLATION_ORDERED) {
				// Being cancelled while waiting command will result plugin
				// getting into CANCELLATION_ORDERED STATE
				// This means we expect Tinker to send at least one command
				// before we can tell Tinker to disconnect

				// Receive and ignore

				String dummy = tinker.fromTinker();

				session.setSocketState(SocketStates.SENDING_CANCELLATION);
				session.setPluginSate(PluginStates.CANCELLATION_IN_PROGRESS);
			}

			if (session.getPluginSate() == PluginStates.CANCELLATION_IN_PROGRESS) {
				if (session.getTacticState() == TacticStates.CANCELLING) {

					// Tell tinker to disconnect
					tinker.toTinker("RODIN_CANCEL");
					session.setPluginSate(PluginStates.DISCONNECTING);
				} else
					throw new Exception("Tactic CANCELLING state expected. But current Tactic state is : "
							+ session.getTacticState());

			}

			if (session.getPluginSate() == PluginStates.DISCONNECTING) {
				tinker.close();
				session.setTacticState(TacticStates.DONE);
				session.setPluginSate(PluginStates.READY);
			}

		} catch (Exception e) {
			e.printStackTrace();
			exception_info = e.getMessage();
		}

		if (session.getTacticState() == TacticStates.DONE) {
			// handle finishing after possible cancellation
			System.out.println("Disconnected. Tinker Tactics complete.");
			// pm.setCanceled(true);
			return null;
		} else {
			exception_info = "Tactic finished with error state";
		}
		return exception_info;
	}

}
