/**
 * This class connects, edits, and changes slidesnodes and keeps track of the
 * head, tail, and cursor nodes.
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #2 for CSE 214,
 *         Fall 2013 September 21, 2013
 */
public class SlideList {
	private SlideNode head;
	private SlideNode tail;
	private SlideNode cursor;

	/**
	 * Constructor for SlideList
	 */
	public SlideList() {
		head = null;
		tail = null;
		cursor = null;
	}

	/**
	 * Adds the inputted slide to the end of the list. Also sets the inputted
	 * slide to head, tail, and cursor if the list is empty.
	 * 
	 * @param newSlide
	 *            The inputted slide to add.
	 */
	public void addToEnd(Slide newSlide) {
		SlideNode newNode = new SlideNode(newSlide);

		if ((head == null) && (tail == null) && (cursor == null)) {

			newNode.setPrev(null);
			newNode.setNext(null);
			head = newNode;
			tail = newNode;
			cursor = newNode;

			return;
		}

		newNode.setPrev(tail);
		newNode.setNext(null);
		tail.setNext(newNode);
		tail = newNode;
		cursor = newNode;

	}

	/**
	 * Adds the inputted slide after the cursor node. Also checks if the cursor
	 * node is null and if the slide is the new tail.
	 * 
	 * @param newSlide
	 */
	public void addAfterCurrent(Slide newSlide) {
		SlideNode newNode = new SlideNode(newSlide);
		if (cursor == null) {

			
			if ((tail==null)||(head==null)){
				System.out.println("");
				System.out.println("There is no defined head or tail!");
				System.out.println("Start with option (A)!");
				return;
			}
			
			newNode.setPrev(tail);
			newNode.setNext(null);
			tail.setNext(newNode);
			tail = newNode;
			cursor = newNode;
			return;

		}

		newNode.setPrev(cursor);

		if (cursor.getNext() != null) {
			cursor.getNext().setPrev(newNode);
			newNode.setNext(cursor.getNext());
			cursor.setNext(newNode);
		}
		if (tail == cursor) {
			cursor.setNext(newNode);
			tail = newNode;
			newNode.setNext(null);
		}

		cursor = newNode;
	}

	/**
	 * Removes the current slide by checking if the cursor is null and then four
	 * special cases where the cursor's next and previous links might be null.
	 * Also sets the cursor to a new slide depending on the special cases.
	 * 
	 * @return Returns true if a slide was removed.
	 */

	public boolean removeCurrentSlide() {
		if (cursor == null) {
			return false;
		}

		SlideNode cursorPrev = cursor.getPrev();
		SlideNode cursorNext = cursor.getNext();

		if ((cursorPrev != null) && (cursorNext != null)) {
			cursorPrev.setNext(cursorNext);
			cursorNext.setPrev(cursorPrev);
			cursor = null;
			cursor = cursorNext;
			return true;

		}
		if ((cursorPrev != null) && (cursorNext == null)) {
			if (cursor == tail) {
				tail = cursorPrev;
			}
			cursorPrev.setNext(null);
			cursor = cursorPrev;
			return true;

		}
		if ((cursorPrev == null) && (cursorNext != null)) {
			if (cursor == head) {
				head = cursorNext;
			}
			cursorNext.setPrev(null);
			cursor = cursorNext;
			return true;
		}
		if ((cursorPrev == null) && (cursorNext == null)) {
			cursor = null;
			return true;
		}
		return false;

	}

	/**
	 * Displays the list based on the inputted range.
	 * 
	 * @param start
	 *            The starting position.
	 * @param end
	 *            The ending positon.
	 * @throws NullPointerException
	 *             Thrown if the list is empty.
	 */
	public void displaySlides(int start, int end) throws NullPointerException {

		int counter = 1;
		if (start < 1) {
			start = 1;
		}
		if ((head == null) || (tail == null)) {
			throw new NullPointerException("Head or tail is null. "
					+ "Slidelist is empty.");
		}
		SlideNode tempNode = head;
		System.out.println("");

		while ((tempNode != null) && (counter <= end)) {

			System.out.println("*************" + counter + "*************");
			System.out.println(tempNode.getSlide().toString());
			System.out.println("*************" + counter + "*************");
			System.out.println("");
			tempNode = tempNode.getNext();
			counter++;

		}
		cursor = tail;
	}

	/**
	 * Displays the current slide.
	 * 
	 * @throws NullCursorException
	 *             Thrown if the cursor is null.
	 */
	public void displayCurrentSlide() throws NullCursorException {
		SlideNode tempNode = head;
		int counter = 1;

		if (cursor == null) {
			throw new NullCursorException(
					"Cursor is Null. Can not display current slide.");
		}

		while (tempNode != cursor) {

			tempNode = tempNode.getNext();
			counter++;
		}

		if (tempNode == cursor) {
			System.out.println("*************" + counter + "*************");
			System.out.println(tempNode.getSlide().toString());
			System.out.println("*************" + counter + "*************");
		}

	}

	/**
	 * Shifts the cursor one node forward.
	 * 
	 * @return Returns true if successful.
	 * @throws NullCursorException
	 *             Thrown if the cursor is null.
	 */
	public boolean moveForward() throws NullCursorException {
		if (cursor == null) {
			throw new NullCursorException(
					"Cursor is Null. Can not move cursor forward.");
		}

		if (cursor.getNext() == null) {
			System.out.println("There is no next available slide!");
			return false;
		}

		cursor = cursor.getNext();
		return true;

	}

	/**
	 * Shifts the cursor one node backward.
	 * 
	 * @return Returns true if successful.
	 * @throws NullCursorException
	 *             Thrown if the cursor is null.
	 */
	public boolean moveBack() throws NullCursorException {
		if (cursor == null) {
			throw new NullCursorException(
					"Cursor is Null. Can not move cursor backward.");
		}

		if (cursor.getPrev() == null) {
			System.out.println("There is no previous available slide!");
			return false;
		}

		cursor = cursor.getPrev();
		return true;

	}

	/**
	 * Changes the cursor the specified position.
	 * 
	 * @param position
	 *            The specified integer that is the position.
	 * @return Returns true if successful.
	 */
	public boolean jumpToPosition(int position) {
		int counter = 1;
		SlideNode tempNode = head;
		System.out.println("");
		while ((tempNode != null) && (counter <= position)) {
			if (counter == position) {
				cursor = tempNode;
				return true;
			}

			tempNode = tempNode.getNext();
			counter++;

		}
		return false;

	}

	/**
	 * Modifies the cursor's slide data.
	 * 
	 * @param text
	 *            The new text to replace the old text.
	 * @param lineNum
	 *            The specific line to change.
	 */
	public void editCurrentSlide(String text, int lineNum) throws NullCursorException {
		if (cursor == null) {
			throw new NullCursorException(
					"Cursor is Null. Nothing to edit.");
		}

		cursor.getSlide().setSlideLine(text, lineNum);

	}

}
