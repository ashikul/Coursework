/**
 * This class creates doubly linked nodes that
 * contains information about the slide.
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #2 for CSE 214, Fall 2013
 * September 21, 2013
 */

import java.util.Scanner;

public class SlideShow {
	/**
	 * Creates a new SlideList class.
	 * 
	 */

	static SlideList show = new SlideList();

	/**
	 * The main program that loops the menu and asks for an input to operate the
	 * </CODE>SlideList</CODE>.
	 * 
	 */
	public static void displayMenu() {
		System.out.println();
		System.out
				.println("...............................................................");
		System.out.printf("%-40s%15s%n", "Add a new slide to end of list",
				"(A)");
		System.out.printf("%-40s%15s%n",
				"Insert a new slide after current slide", "(I)");
		System.out.printf("%-40s%15s%n", "Remove current slide", "(R)");
		System.out.printf("%-40s%15s%n", "Display a range of slides", "(D)");
		System.out.printf("%-40s%15s%n", "Display current slide", "(C)");
		System.out.printf("%-40s%15s%n", "Move current slide forward", "(F)");
		System.out.printf("%-40s%15s%n", "Move current slide backwards", "(B)");
		System.out.printf("%-40s%15s%n", "Jump to a given position", "(J)");
		System.out.printf("%-40s%15s%n", "Edit current slide", "(E)");
		System.out.printf("%-40s%15s%n", "Exit the program", "(Q)");
		System.out
				.println("...............................................................");
		System.out.println();
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Select a menu option: ");
		char c = input.next().trim().charAt(0);
		switch (c) {

		case 'a':
		case 'A':
			SlideShow.addSlideToEnd();
			break;
		case 'i':
		case 'I':
			SlideShow.insertSlideAfterCurrent();
			break;
		case 'r':
		case 'R':
			SlideShow.removeCurrentSlide();
			break;
		case 'd':
		case 'D':
			SlideShow.displaySlides();
			break;
		case 'c':
		case 'C':
			SlideShow.displayCurrentSlide();
			break;
		case 'f':
		case 'F':
			SlideShow.moveForward();
			break;
		case 'b':
		case 'B':
			SlideShow.moveBackward();
			break;
		case 'j':
		case 'J':
			SlideShow.jumptoPosition();
			break;
		case 'e':
		case 'E':
			SlideShow.editCurrentSlide();
			break;
		case 'q':
		case 'Q':
			System.out.println("Program terminating normally...");
			System.exit(1);
			break;

		default:
			System.out.println("Invalid menu option!");
			break;
		}

	}

	/**
	 * Method to ask for the Slide's text lines and add the Slide object it to
	 * the end.
	 */
	public static void addSlideToEnd() {
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		Slide tempSlide = new Slide();
		System.out.print("1) ");
		tempSlide.setSlideLine(input.nextLine(), 1);
		System.out.print("2) ");
		tempSlide.setSlideLine(input.nextLine(), 2);
		System.out.print("3) ");
		tempSlide.setSlideLine(input.nextLine(), 3);
		System.out.print("4) ");
		tempSlide.setSlideLine(input.nextLine(), 4);
		System.out.print("5) ");
		tempSlide.setSlideLine(input.nextLine(), 5);

		show.addToEnd(tempSlide);
	}

	/**
	 * Method to ask for the new Slide's text lines and insert after the current
	 * slide.
	 */
	public static void insertSlideAfterCurrent() {
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		Slide tempSlide = new Slide();
		System.out.print("1) ");
		tempSlide.setSlideLine(input.nextLine(), 1);
		System.out.print("2) ");
		tempSlide.setSlideLine(input.nextLine(), 2);
		System.out.print("3) ");
		tempSlide.setSlideLine(input.nextLine(), 3);
		System.out.print("4) ");
		tempSlide.setSlideLine(input.nextLine(), 4);
		System.out.print("5) ");
		tempSlide.setSlideLine(input.nextLine(), 5);

		show.addAfterCurrent(tempSlide);
	}

	/**
	 * Removes the current slide.
	 */
	public static void removeCurrentSlide() {

		if (show.removeCurrentSlide() == false) {
			System.out.print("There is no current slide to be removed.");
		}
	}

	/**
	 * Asks for two inputs and displays the slides in that range. Checks if the
	 * start is greater than the end.
	 */
	public static void displaySlides() {

		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		int tempStart;
		int tempEnd;

		System.out.print("Enter starting position: ");
		tempStart = input.nextInt();
		System.out.print("Enter ending position: ");
		tempEnd = input.nextInt();

		if (tempStart > tempEnd) {
			System.out
					.print("Starting position can not be greater than ending position!");
			return;
		}
		show.displaySlides(tempStart, tempEnd);
	}

	/**
	 * Displays the current slide and catches any NullCursorExceptions.
	 */
	public static void displayCurrentSlide() {
		try {
			show.displayCurrentSlide();
		} catch (NullCursorException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Moves the cursor forward and catches any NullCursorExceptions.
	 */
	public static void moveForward() {
		try {
			if (show.moveForward() == false) {
				System.out.println("Can not move cursor forward.");
			}
		} catch (NullCursorException e) {
			e.printStackTrace();
			return;
		}
	}

	/**
	 * Moves the cursor backward and catches any NullCursorExceptions.
	 */
	public static void moveBackward() {
		try {
			if (show.moveBack() == false) {
				System.out.println("Can not move cursor backwards.");
			}
		} catch (NullCursorException e) {
			e.printStackTrace();
			return;
		}
	}

	/**
	 * Asks for a position and moves the cursor to it.
	 */
	public static void jumptoPosition() {
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		int tempPosition;
		System.out.print("Enter position to jump to: ");
		tempPosition = input.nextInt();
		if (show.jumpToPosition(tempPosition) == false) {
			System.out.println("Can not move cursor to that position.");
		}
	}

	/**
	 * Asks for the current's slide line number and the new text to replace the
	 * old one with.
	 */
	public static void editCurrentSlide() {
		@SuppressWarnings("resource")
		Scanner inputInt = new Scanner(System.in);
		@SuppressWarnings("resource")
		Scanner inputString = new Scanner(System.in);

		System.out.print("Enter line number: ");
		int tempLine = inputInt.nextInt();

		if ((tempLine < 1) || (tempLine > 5)) {
			System.out.print("Line must be between 1 and 5");
			return;
		}

		System.out.print("Enter text: ");
		String tempString = inputString.nextLine();

		try {
			show.editCurrentSlide(tempString, tempLine);
		} catch (NullCursorException e) {
			e.printStackTrace();
		}

	}

	/**
	 * The main method that will loop the menu.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		while (true) {
			SlideShow.displayMenu();
		}
	}

}
