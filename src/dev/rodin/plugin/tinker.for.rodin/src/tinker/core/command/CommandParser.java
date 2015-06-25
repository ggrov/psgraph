package tinker.core.command;

import java.util.HashMap;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class CommandParser {

	public CommandParser() {
		// TODO Auto-generated constructor stub
	}

	public Command parseCommand(String commandstr) {

		Command result = new Command();
		try {
			//System.out.println("parsing "+commandstr);
			JSONObject jObject = (JSONObject) JSONValue.parse(commandstr);
			//System.out.println("done "+commandstr);
			
			result.setCommand((String) jObject.get("CMD"));
			//System.out.println("CMD="+jObject.get("CMD"));
			JSONObject params = (JSONObject) jObject.get("PARAMS");
			//System.out.println("PARAMS="+params.toJSONString());
			if (params != null) {
				result.setParameters(params);
			} else {
				result.setParameters(null);
			}
			return result;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.setCommand("ERROR");
			result.setParameters(new HashMap<String,Object>());
			return result;
		}

	}
}
