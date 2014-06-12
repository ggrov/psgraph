package quanto.data

import quanto.util.json._

/**
 * An abstract class which provides a general interface for accessing
 * vertex data 
 *
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 * @author Aleks Kissinger
 */
abstract class VData extends GraphElementData {
  /**
   * Get coordinates of vertex
   * @throws JsonAccessException
   * @return actual coordinates of vertex or (0,0) if none are specified
   */
  def coord: (Double, Double) = annotation.get("coord") match {
    case Some(JsonArray(Vector(x,y))) => (x.doubleValue, y.doubleValue)
    case Some(otherJson) => throw new JsonAccessException("Expected: array with 2 elements", otherJson)
    case None => (0,0)
  }

  /** Create a copy of the current vertex with the new coordinates  */
  def withCoord(c: (Double,Double)): VData

  def isWireVertex: Boolean
  def isBoundary : Boolean
}

/**
 * Companion object for the VData class. Contains a method getCoord which has
 * the same behaviour as VData.coord, but is static.
 * 
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 * @author Aleks Kissinger
 */
object VData {
  def getCoord(annotation: Json): (Double,Double) = annotation.get("coord") match {
    case Some(JsonArray(Vector(x,y))) => (x.doubleValue, y.doubleValue)
    case Some(otherJson) => throw new JsonAccessException("Expected: array with 2 elements", otherJson)
    case None => (0,0)
  }
}

/**
 * A class which represents node vertex data. 
 * 
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 */
case class NodeV(
  data: JsonObject = Theory.DefaultTheory.defaultVertexData,
  annotation: JsonObject = JsonObject(),
  theory: Theory = Theory.DefaultTheory) extends VData
{
  /** Type of the vertex */
  def typ = (data / "type").stringValue

  def value = (data.getPath(theory.vertexTypes(typ).value.path)).stringValue
  def label = data.getOrElse("label",value).stringValue
 // def value = data ? "value"

  def typeInfo = theory.vertexTypes(typ)

  def withCoord(c: (Double,Double)) =
    copy(annotation = annotation + ("coord" -> JsonArray(c._1, c._2)))
  
  /** Create a copy of the current vertex with the new value */
  def withValue(s: String) =
    copy(data = data.setPath(theory.vertexTypes(typ).value.path, s).setPath("$.label", s).asObject)

  def isWireVertex = false
  def isBoundary = false

  override def toJson = JsonObject(
    //"data" -> (if (data == theory.vertexTypes(typ).defaultData) JsonNull() else data),
    "data" -> (data),   /* by LYH, save the default type for isabelle parsing */
    "annotation" -> annotation).noEmpty
}

/**
 * Companion object for the NodeV class. Contains methods to convert to/from 
 * JSON and a factory method to create instances of NodeV from a pair of 
 * coordinates.
 *
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 * @author Aleks Kissinger
 */
object NodeV {
  def apply(coord: (Double,Double)): NodeV = NodeV(annotation = JsonObject("coord" -> JsonArray(coord._1,coord._2)))

  def toJson(d: NodeV, theory: Theory) = JsonObject(
    //"data" -> (if (d.data == theory.vertexTypes(d.typ).defaultData) JsonNull() else d.data),
    "data" -> (d.data),   /* by LYH, save the default type for isabelle parsing */
    "annotation" -> d.annotation).noEmpty
  def fromJson(json: Json, thy: Theory = Theory.DefaultTheory): NodeV = {
    val data = json.getOrElse("data", thy.defaultVertexData).asObject
    val annotation = (json ? "annotation").asObject

    val n = NodeV(data, annotation, thy)

    // if any of these throw an exception, they should do it here
    n.coord
    n.value
    n.label
    val typ = n.typ
    if (!thy.vertexTypes.keySet.contains(typ)) throw new GraphLoadException("Unrecognized vertex type: " + typ)

    n
  }
}

/**
 * A class which represents wire vertex data
 *
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 */
case class WireV(
  data: JsonObject = JsonObject(),
  annotation: JsonObject = JsonObject(),
  theory: Theory = Theory.DefaultTheory) extends VData
{
  def isWireVertex = true
  def isBoundary = annotation.get("boundary") match { case Some(JsonBool(b)) => b; case None => false }
  def withCoord(c: (Double,Double)) =
    copy(annotation = annotation + ("coord" -> JsonArray(c._1, c._2)))
}

/**
 * A companion object for the WireV class. Contains methods to convert to/from
 * JSON and a factory method to create instances of WireV from a pair of 
 * coordinates
 * 
 * @see [[https://github.com/Quantomatic/quantomatic/blob/scala-frontend/scala/src/main/scala/quanto/data/VData.scala Source code]]
 * @see [[https://github.com/Quantomatic/quantomatic/blob/integration/docs/json_formats.txt json_formats.txt]]
 */
object WireV {
  def apply(c: (Double,Double)): WireV = WireV(annotation = JsonObject("coord" -> JsonArray(c._1,c._2)))

  def toJson(d: NodeV, theory: Theory) = JsonObject(
    "data" -> d.data, "annotation" -> d.annotation).noEmpty
  def fromJson(json: Json, thy: Theory = Theory.DefaultTheory): WireV =
    WireV((json ? "data").asObject, (json ? "annotation").asObject, thy)
}
