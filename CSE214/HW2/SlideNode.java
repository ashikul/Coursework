/**
 * This class creates doubly linked nodes that contains information about the
 * slide.
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #2 for CSE 214,
 *         Fall 2013 September 21, 2013
 */
public class SlideNode {
	private Slide slide;
	private SlideNode prev;
	private SlideNode next;

	/**
	 * Constructor for SlideNode
	 */
	public SlideNode() {
		slide = null;
		prev = null;
		next = null;
	}

	/**
	 * Constructor that takes the object Slide input
	 * 
	 * @param intialSlide
	 *            stores that slide's data in the node.
	 */
	public SlideNode(Slide intialSlide) {
		slide = intialSlide;
		prev = null;
		next = null;
	}

	/**
	 * Mutator for the node's Slide data.
	 * 
	 * @param slide
	 *            Changes the node to inputted slide.
	 */
	public void setSlide(Slide slide) {
		this.slide = slide;
	}

	/**
	 * Mutator for the node's next link.
	 * 
	 * @param node
	 *            Changes the node's next node to the inputted node.
	 */
	public void setNext(SlideNode node) {
		this.next = node;
	}

	/**
	 * Mutator for the node's previous link.
	 * 
	 * @param node
	 *            Changes the node's previous node to inputted node.
	 */
	public void setPrev(SlideNode node) {
		this.prev = node;
	}

	/**
	 * Accessor for the node's slide data.
	 * 
	 * @return Returns the object slide.
	 */
	public Slide getSlide() {
		return slide;
	}

	/**
	 * Accessor for the node's next link.
	 * 
	 * @return Returns the next node link.
	 */
	public SlideNode getNext() {
		return next;
	}

	/**
	 * Acessor for the node's previous link.
	 * 
	 * @return Returns the previous node link.
	 */
	public SlideNode getPrev() {
		return prev;
	}
}
