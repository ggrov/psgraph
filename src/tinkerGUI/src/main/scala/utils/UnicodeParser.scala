package tinkerGUI.utils

import java.io.File

import quanto.util.json.{JsonObject, Json}

import scala.swing.{TextArea, TextField}
import scala.swing.event.{Key, KeyReleased}

/** Object providing methods to parse certain character sequences into unicode characters and the other way around.
	*
	*/
object UnicodeParser {

	/** The parsing collection.
		* Should be set on application initialisation.
		* Associates a character sequence to a unicode character.
		*/
	var unicodeMap = Map[String,String](
		"\\not " -> "\u00AC ", // ¬,
		"\\Gamma " -> "\u0393 ", // Γ,
		"\\Theta " -> "\u0398 ", // Θ,
		"\\Lambda " -> "\u039B ", // Λ,
		"\\Xi " -> "\u039E ", // Ξ,
		"\\Pi " -> "\u03A0 ", // Π,
		"\\Sigma " -> "\u03A3 ", // Σ,
		"\\Upsilon " -> "\u03A5 ", // Υ,
		"\\Phi " -> "\u03A6 ", // Φ,
		"\\Psi " -> "\u03A8 ", // Ψ,
		"\\Omega " -> "\u03A9 ", // Ω,
		"\\alpha " -> "\u03B1 ", // α,
		"\\beta " -> "\u03B2 ", // β,
		"\\gamma " -> "\u03B3 ", // γ,
		"\\delta " -> "\u03B4 ", // δ,
		"\\zeta " -> "\u03B6 ", //  ζ
		"\\eta " -> "\u03B7 ", // η,
		"\\theta " -> "\u03B8 ", // θ,
		"\\lambda " -> "\u03BB ", // λ,
		"\\mu " -> "\u03BC ", // μ,
		"\\nu " -> "\u03BD ", // ν,
		"\\xi " -> "\u03BE ", // ξ,
		"\\pi " -> "\u03C0 ", // π,
		"\\rho " -> "\u03C1 ", // ρ,
		"\\sigma " -> "\u03C3 ", // σ,
		"\\tau " -> "\u03C4 ", // τ,
		"\\upsilon " -> "\u03C5 ", // υ,
		"\\phi " -> "\u03C6 ", // ϕ,
		"\\chi " -> "\u03C7 ", // χ,
		"\\psi " -> "\u03C8 ", // φ,
		"\\omega " -> "\u03C9 ", // ω,
		"\\cat " -> "\u2040 ", // ⁀,
		"\\complex " -> "\u2102 ", // ℂ,
		"\\nat " -> "\u2115 ", // ℕ,
		"\\pset " -> "\u2119 ", // ℙ,
		"\\rat " -> "\u211A ", // ℚ,
		"\\real " -> "\u211D ", // ℝ,
		"\\int " -> "\u2124 ", // ℤ,
		"\\fun " -> "\u2192 ", // →,
		"\\rel " -> "\u2194 ", // ↔,
		"\\cantext " -> "\u2195 ", // ↕,
		"\\surj " -> "\u21A0 ", // ↠,
		"\\inj " -> "\u21A3 ", // ↣,
		"\\map " -> "\u21A6 ", // ↦,
		"\\filter " -> "\u21BE ", // ↾,
		"\\extract " -> "\u21BF ", // ↿,
		"\\Leftarrow " -> "\u21D0 ", // ⇐,
		"\\implies " -> "\u21D2 ", // ⇒,
		"\\equiv " -> "\u21D4 ", // ⇔,
		"\\pfun " -> "\u21F8 ", // ⇸,
		"\\ffun " -> "\u21FB ", // ⇻,
		"\\forall " -> "\u2200 ", // ∀,
		"\\exists " -> "\u2203 ", // ∃,
		"\\emptyset " -> "\u2205 ", // ∅,
		"\\mem " -> "\u2208 ", // ∈,
		"\\notmem " -> "\u2209 ", // ∉,
		"\\select " -> "\u220A ", // ϵ,
		"\\uminus " -> "\u2212 ", // ﹣,
		"\\fcomp " -> "\u2218 ", // ∘,
		"\\and " -> "\u2227 ", // ∧,
		"\\or " -> "\u2228 ", // ∨,
		"\\intersect " -> "\u2229 ", // ∩,
		"\\union " -> "\u222A ", // ∪,
		"\\def " -> "\u225C ", // ≜,
		"\\neq " -> "\u2260 ", // ≠,
		"\\replacedby " -> "\u2261 ", // ≡,
		"\\leq " -> "\u2264 ", // ≤,
		"\\geq " -> "\u2265 ", // ≥,
		"\\psubset " -> "\u2282 ", // ⊂,
		"\\psupset " -> "\u2283 ", // ⊃,
		"\\subset " -> "\u2286 ", // ⊆,
		"\\supset " -> "\u2287 ", // ⊇,
		"\\refinedby " -> "\u2291 ", // ⊑,
		"\\overwrite " -> "\u2295 ", // ⊕,
		"\\symdiff " -> "\u2296 ", // ⊖,
		"\\thm " -> "\u22A2 ", // ⊢,
		"\\bottom " -> "\u22A5 ", // ⊥,
		"\\dres " -> "\u22B2 ", // ◁,
		"\\rres " -> "\u22B3 ", // ▷,
		"\\dintersect " -> "\u22C2 ", // ⋂,
		"\\dunion " -> "\u22C3 ", // ⋃,
		"\\up " -> "\u22CE ", // ⋏,
		"\\lbag " -> "\u27E6 ", // ⟦,
		"\\rbag " -> "\u27E7 ", // ⟧,
		"\\lseq " -> "\u27E8 ", // 〈,
		"\\rseq " -> "\u27E9 ", // 〉,
		"\\psurj " -> "\u2900 ", // ⤀,
		"\\pinj " -> "\u2914 ", // ⤔,
		"\\finj " -> "\u2915 ", // ⤕,
		"\\bij " -> "\u2916 ", // ⤖,
		"\\spot " -> "\u2981 ", // ⦁,
		"\\bigcolon " -> "\u2982 ", // ⦂,
		"\\lrelimg " -> "\u2987 ", // ⦇,
		"\\rrelimg " -> "\u2988 ", // ⦈,
		"\\bagunion " -> "\u2A04 ", // ⨄,
		"\\x " -> "\u2A2F ", // ×,
		"\\dsub " -> "\u2A64 ", // ⩤,
		"\\rsub " -> "\u2A65 ", // ⩥,
		"\\rcomp " -> "\u2A3E ", // ⨾,
		"\\ulbegin " -> "\uFE59 ", // ₍,
		"\\ulend " -> "\uFE5A ", // ₎,
		"\\boolean " -> "\uD835\uDD39 ", // 𝔹,
		"\\fset " -> "\uD835\uDD3D ", // 𝔽,
		"\\symbol " -> "\uD835\uDD4A ", // 𝕊,
		"\\bbU " -> "\uD835\uDD4C " // 𝕌,
	)

	/** Method loading the unicode map from a file.
		* Load the default map if it fails.
		*
		* @param f File to read.
		*/
	def loadMap(f:File) {
		try {
			unicodeMap = Json.parse(f).asObject.mapValue.mapValues(v => v.stringValue)
		} catch {
			case e:Exception =>
				TinkerDialog.openErrorDialog("Error while parsing .unicodeConfig<br>"+e.getMessage+"<br>Default settings will be used.")
		}
	}

	/** Method replacing a character sequence into a unicode character in a string.
		*
		* @param s Input string.
		* @return String with some character sequences replaced into unicode characters.
		*/
	def stringToUnicode(s:String):String = {
		unicodeMap.foldLeft(s){(s,p)=>s.replace(p._1,p._2)}
	}

	/** Method replacing a unicode character into a character sequence in a string.
		*
		* @param s Input string.
		* @return String with some unicode characters replaced into character sequences.
		*/
	def unicodeToString(s:String):String = {
		unicodeMap.foldLeft(s){(s,p)=>s.replace(p._2,p._1)}
	}
}

/** Class implementing a textfield which prints unicode characters according to the dictionary.
	*
	* @param t : Initial text value.
	* @param length : Size (columns) of the text field.
	*/
class UnicodeTextField(t:String,length:Int) extends TextField(t,length) {
	listenTo(keys)
	reactions += {
		case KeyReleased(src,key,_,_) =>
			if(src == this && key == Key.Space){
				val c = text.length-caret.position
				text = UnicodeParser.stringToUnicode(text)
				caret.position = text.length-c
			}
	}
}

/** Class implementing a textarea which prints unicode characters according to the dictionary.
	*
	* @param t : Initial text value.
	*/
class UnicodeTextArea(t:String) extends TextArea(t) {
	def this(t:String,height:Int,length:Int){
		this(t)
		rows = height
		columns = length
	}
	tabSize = 4
	listenTo(keys)
	reactions += {
		case KeyReleased(src,key,_,_) =>
			if(src == this && key == Key.Space){
				val c = text.length-caret.position
				text = UnicodeParser.stringToUnicode(text)
				caret.position = text.length-c
			}
	}
}