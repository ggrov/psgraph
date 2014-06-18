/**
  * This file is a copy of the mouse state file from Quantomatic
  * changes as been made to be standalone from classes from quantomatic
  */
package tinkerGUI.controllers

import java.awt.Point
import java.awt.geom.Rectangle2D
import math.{min,abs}

/** 
 * Simple abstract class used to identify the current mouse state
 * (e.g. the "Add Vertex" tool has been selected, a selection box
 * is drawn etc.)
 */
sealed abstract class MouseState

class InvalidMouseStateException(val when: String, val state: MouseState)
extends Exception("Got unexpected mouse state: " + state + ", when: " + when)

/** The selection tool from the main toolbar is selected */
case class SelectTool() extends MouseState

/** A selection box is being drawn in the pane */
case class SelectionBox(start: Point, end: Point) extends MouseState {
  def rect = {
    new Rectangle2D.Double(
      min(start.getX, end.getX),
      min(start.getY, end.getY),
      abs(end.getX - start.getX),
      abs(end.getY - start.getY)
    )
  }
}

// /** A Bang selection box is being drawn in the pane */
// case class BangSelectionBox(start: Point, end: Point) extends MouseState {
//   def rect = {
//     new Rectangle2D.Double(
//       min(start.getX, end.getX),
//       min(start.getY, end.getY),
//       abs(end.getX - start.getX),
//       abs(end.getY - start.getY)
//     )
//   }
// }

/** Vertex is being dragged in the pane */
case class DragVertex(start: Point, end: Point) extends MouseState

/** The AddVertex tool has been selected from the main toolbar */
case class AddVertexTool() extends MouseState

// /** The AddBoundary tool has been selected from the main toolbar */
// case class AddBoundaryTool() extends MouseState

/** The Add Edge tool has been selected from the main toolbar */
case class AddEdgeTool() extends MouseState

/** An edge is being dragged in the pane*/
case class DragEdge(startVertex: String) extends MouseState

// /** The Add BangBox tool has been selected from the main toolbar */
// case class AddBangBoxTool() extends MouseState

// /** A nesting edge is being dragged from the bang box corner */
// case class DragBangBoxNesting(startBBox: String) extends MouseState