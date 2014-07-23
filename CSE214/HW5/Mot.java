/**
 * This class plays the game of "MOT"
 * The user is played agaisnt a computer. The user is asked 2 input choices,
 * the number pennies that can be removed, and the number of pennies to start with.
 * Afterwards, the user is asked to choose a mode for the computer, random or expert
 * mode.
 * 
 * EXTRA CREDIT
 * 	I tried optimizing the game tree contruction,
 *  please see the method private void createTree(GameNode node){
 * 
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #5 for CSE 214, Fall 2013
 * November 4, 2013
 */

import java.io.Reader;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Mot {
	static GameTree tree;
	static int max;
	
	
	
	
	
	
	/**
	 * Main method, asks for inputs and then loops the computer's turn and then
	 * the player's turn. If a game lose condition is met within this loop, the
	 * game stops.
	 * 
	 * @param args
	 */
	@SuppressWarnings("unused")
	public static void main(String[] args) {
		System.out.println("Welcome to the game of MOT!");
		tree = new GameTree(Mot.askInput(), max);
		System.out.println("GAME TREE CONSTRUCTED.");
		System.out.println("Total number of possible ways to play this game: "
				+ tree.numWays());

		boolean expertMode = Mot.computerMode(); // false is random, true is
													// expert
		System.out.println("Ok! Let's play!");
		System.out.print("\n");

		do {
			Mot.turnComputer(expertMode);

			Mot.turnPlayer();

		} while (true);

	}

	/**
	 * Asks the user to remove a valid number of pennies.
	 * 
	 */
	private static void turnPlayer() {

		System.out.println("Total number of pennies: "
				+ tree.getGamePosition().getData());

		Scanner input = new Scanner(System.in);
		int pennies;
		do {

			System.out.print("Human: How many pennies do you want to remove? ");

			try {
				pennies = input.nextInt();
				if ((pennies >= 1) && (pennies <= max)) {
					break;
				}
				System.out.println("SORRY. INVALID PLAY.");
			} catch (IllegalArgumentException e) {
				System.out.println("SORRY. INVALID PLAY.");

			} catch (InputMismatchException e) {
				input = new Scanner(System.in);
				System.out.println("SORRY. INVALID PLAY.");
			}

		} while (true);

		if (tree.getGamePosition().getData() - pennies <= 0) {
			System.out.print("\n");
			System.out.println("HA HA! You removed the last penny!  I win!");
			System.exit(1);
		}
		tree.change(pennies);
		System.out.print("\n");
	}

	/**
	 * Dictates the computer's way in removing pennies. Has an expert mode
	 * algorithm and a random mode option.
	 * 
	 * @param expertMode
	 *            is used to keep track of the computer mode
	 */
	public static void turnComputer(boolean expertMode) {

		// ////EXPERT COMPUTER///////////////////////////////////////
		if (expertMode == true) {

			for (int i = 1; i <= max; i++) {
				if (Mot.checkNode((tree.getGamePosition().getLink(i)))) {
					Mot.computerPrint(i);
					tree.change(i);
					return;
				}
			}

			// check if nearby node 0
			for (int i = 1; i <= max; i++) {
				if (Mot.checkZeroNode((tree.getGamePosition().getLink(i)))) {
					Mot.computerPrint(i);
					tree.change(i);
					return;
				}
			}

			// take minimum amount or 1
			Mot.computerPrint(1);
			tree.change(1);
			if (tree.getGamePosition().getData() == 0) {
				System.out.println("NO! I removed the last penny, you win!");
				System.exit(1);
			}
			return;

		}

		// COMPUTER RANDOM///////////
		else {
			int random = (int) ((Math.random() * max) + 1); // 1,2,3
			// System.out.println(random); ///DEBUG
			int pennies = tree.getGamePosition().getData();
			if (pennies - random <= 0) {
				Mot.computerPrint(random);
				System.out.println("NO! I removed the last penny, you win!");
				System.exit(1);
			}
			Mot.computerPrint(random);
			tree.change(random);

		}

	}

	// check if this node has a single 0 .
	/**
	 * Check if the designated node has a child that is 0.
	 * 
	 * @param node
	 * @return boolean
	 */
	private static boolean checkZeroNode(GameNode node) {
		if (node == null) {
			return false;
		}
		int count = 0;

		for (int i = 1; i <= max; i++) {
			if (node.getLink(i) == null) {
				count++;
			}
		}
		if (count == (max - 1)) {
			return true;
		}
		return false;

	}

	/**
	 * Method to ask the user for the computer mode.
	 * 
	 * @return True for expert, false for random.
	 */
	public static boolean computerMode() {

		Scanner inputMode = new Scanner(System.in);
		String mode;

		do {
			System.out.print("\n");
			System.out
					.print("What mode do you want the computer to play in: (r)andom or (e)xpert? [r/e]");
			mode = inputMode.nextLine();
			char c = mode.trim().charAt(0);
			switch (c) {
			case 'r':
			case 'R':
				return false;
			case 'e':
			case 'E':
				return true;
			default:
				System.out.println("Please enter (r) or (e)!");
				break;
			}

		} while (true);

	}

	/**
	 * Method to ask the user for the number of pennies that can be removed and
	 * the number of pennies to start with.
	 * 
	 * @return the number of pennies to start with
	 */
	@SuppressWarnings({ "resource", "unused" })
	public static int askInput() {
		int inMax = 0;
		Scanner inputMax = new Scanner(System.in);

		do {
			System.out.print("\n");
			System.out
					.print("How many pennies can be removed? (Must be between 2 and 5)?");

			try {
				inMax = inputMax.nextInt();

			} catch (InputMismatchException e) {
				inputMax = new Scanner(System.in);
			}

			if ((inMax >= 2) && (inMax <= 5)) {
				break;
			}

			System.out.println("Must be between 2 and 5");

		} while (true);

		max = inMax;

		int pennies = 0;
		Scanner inputPennies = new Scanner(System.in);

		do {
			System.out.print("\n");
			System.out
					.print("How many pennies should we start with (must be at least 5)?");

			try {
				pennies = inputPennies.nextInt();
			} catch (InputMismatchException e) {
				inputPennies = new Scanner(System.in);
			}

			if (pennies >= 5) {
				break;
			}

			System.out.println("Must be at least 5");

		} while (true);
		return pennies;

	}

	// check if node is multiple to 4N + 5 for a 3-ary tree
	/**
	 * This method is used for the expert mode. Checks if this node is a
	 * multiple of 4N + 5.
	 * 
	 * @param node
	 * @return
	 */
	public static boolean checkNode(GameNode node) {
		if (node == null) {
			return false;
		}
		int check = node.getData();
		return ((check >= (max + 2) && ((((check - (max + 2)) % (max + 1)) == 0))));
	}

	/**
	 * Method to display the computer's actions.
	 * 
	 * @param value
	 */
	public static void computerPrint(int value) {
		System.out.println("Total number of pennies: "
				+ tree.getGamePosition().getData());
		System.out.println("(Computer) I will remove " + value + " pennies");
		System.out.println("");
	}

}
