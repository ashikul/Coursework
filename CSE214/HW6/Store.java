/**
 *This class sets up the hash table loading, saving, and 
 *manipulation of the item objects inside. It simulates
 *adding items to a store and modifying them.
 *
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #6 for CSE 214, Fall 2013
 * November 19, 2013
 */

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.InputMismatchException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.Set;

public class Store {

	final static int CHARACTER_LIMIT = 25; // Item char Limit
	final static int RFID_LIMIT = 9; // RFID char limit

	/**
	 * @param args
	 */
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		@SuppressWarnings("rawtypes")
		Hashtable<String, Item> itemTable = null; // MyClass implements
													// Serializable

		try {
			// If file is found, open it
			FileInputStream file = new FileInputStream("items.obj");
			ObjectInputStream fin = new ObjectInputStream(file);
			itemTable = (Hashtable<String, Item>) fin.readObject();
			file.close();
		} catch (IOException a) {
		} catch (ClassNotFoundException c) {
		} // Bottoms up!
			// Note that myObject may still be null

		if (itemTable == null) {
			itemTable = new Hashtable<String, Item>();
		} else {
			// Successfully loaded the Items...
			// Display hashtable

			System.out.println("Successfully loaded the Items: ");
			Store.displayTable(itemTable);

		}

		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		char option = ' ';

		while (true) {
			printMenu();
			System.out.print("\nPlease select a menu option: ");
			option = input.next().trim().charAt(0);
			System.out.println();

			switch (option) {
			// I Insert an Item into the Store.
			case 'i':
			case 'I':

				String rfidInsert;
				Item itemTemp = new Item();
				System.out.println("Inserting an Item into the Store...");
				itemTemp.setName(Store.askName("Enter Name of the Item: "));
				rfidInsert = Store.askRfid("RFID Number: ");
				itemTemp.setRfidNumber(rfidInsert);
				itemTemp.setPrice(Store.askPrice("Price: "));
				itemTemp.setQuantity(Store.askQuantity("Quantity: "));

				itemTable.put(rfidInsert, itemTemp);
				System.out.println();
				System.out.println(itemTemp.getQuantity() + " "
						+ itemTemp.getName()
						+ " have been added to the inventory with"
						+ " RFID Number " + itemTemp.getRfidNumber()
						+ " and at a price" + " of $" + itemTemp.getPrice());

				break;

			// A Add inventory
			case 'a':
			case 'A':

				String rfidEntry;

				Item itemTemp1 = new Item();
				System.out.println("Adding to the Inventory");
				rfidEntry = Store.askRfid("RFID Number: ");

				if (itemTable.containsKey(rfidEntry) == false) {
					System.out.println("Item not found!");
					break;
				}

				itemTemp1.setRfidNumber(rfidEntry);
				itemTemp1.setPrice(Store.askPrice(" New Price: "));
				itemTemp1.setQuantity(itemTable.get(rfidEntry).getQuantity()
						+ Store.askQuantity("Additional Quantity: "));

				itemTemp1.setName(itemTable.get(rfidEntry).getName());

				itemTable.put(rfidEntry, itemTemp1);

				System.out.println("There are now " + itemTemp1.getQuantity()
						+ " " + itemTemp1.getName() + " in the Store with a"
						+ " price of $" + itemTemp1.getPrice());

				break;

			// R Remove Item
			case 'r':
			case 'R':

				String rfidRemove;

				System.out.println("Removing an Item from inventory...");
				rfidRemove = Store
						.askRfid("Select the RFID Number of the Item to be removed: ");

				if (itemTable.containsKey(rfidRemove) == false) {
					System.out.println("Item with this RFID number not found!");
					break;
				}

				System.out.println("Successfully removed all "
						+ itemTable.remove(rfidRemove).getName()
						+ " from the store.");

				break;

			// S Search Inventory
			case 's':
			case 'S':

				String rfidSearch;

				System.out
						.println("Searching for Information about an Item...");
				rfidSearch = Store.askRfid("Enter it's RFID: ");

				if (itemTable.containsKey(rfidSearch) == false) {
					System.out
							.println("There are currently no Items in the Store with the given RFID Number.");
					break;
				}

				Item itemTemp2 = itemTable.get(rfidSearch);
				System.out.println();
				System.out.println(itemTemp2.getQuantity() + " "
						+ itemTemp2.getName()
						+ " in the Store, currently at a price of $"
						+ itemTemp2.getPrice() + ".");

				break;

			// G Go Shopping
			case 'g':
			case 'G':

				System.out.println("List of Items in the Store: ");
				Store.displayTable(itemTable);

				double total = 0;
				int quantityShop;
				boolean keepShopping = true;
				String rfidShop;

				while (keepShopping == true) {

					System.out.println();
					rfidShop = Store.askRfidShopping();

					// Finish Case
					if (rfidShop.equals("0")) {
						System.out
								.println("Finished Shopping! Please pay the cashier $"
										+ total);
						keepShopping = false;
						break;
					}

					if (itemTable.containsKey(rfidShop) == false) {
						System.out
								.println("Item with this RFID number not found!");
						continue; // Skip iteration
					}

					quantityShop = Store.askQuantity("Enter quantity: ");

					int itemQuantity = ((Item) itemTable.get(rfidShop))
							.getQuantity();

					if (quantityShop > itemQuantity) {
						System.out
								.println("Error: There are not enough of that Item in the Store");
						continue; // Skip Iteration
					}

					double itemPrice = quantityShop
							* ((Item) itemTable.get(rfidShop)).getPrice();

					System.out.println("You have selected " + quantityShop
							+ " " + ((Item) itemTable.get(rfidShop)).getName()
							+ " which totals to $" + itemPrice);

					total = total + itemPrice;

					System.out.println("Your total so far is: $" + total);

				}

				break;

			// Q Quit
			case 'q':
			case 'Q':

				try {
					FileOutputStream file = new FileOutputStream("items.obj");
					ObjectOutputStream fout = new ObjectOutputStream(file);
					fout.writeObject(itemTable);
					fout.close();
				} catch (IOException a) {
				}

				System.out.println("Program terminating normally...");
				System.exit(1);
				break;

			default:
				System.out.println("Invalid menu option!");
				System.out.println();
				break;

			}

		}

	}

	/**
	 * Ask the user for a valid name
	 * 
	 * @param message
	 * @return
	 */
	public static String askName(String message) {

		String name = "";
		@SuppressWarnings("resource")
		Scanner inputName = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				name = inputName.nextLine();
			} catch (InputMismatchException e) {
				inputName = new Scanner(System.in);
			}

			// Break case: less than 25 chars
			if (name.length() <= CHARACTER_LIMIT) {
				break;
			}

			System.out.println("Invalid name! Must be under 25 chars.");

		} while (true);

		return name;

	}

	/**
	 * Ask the user for a valid rfidNumber
	 * 
	 * @param message
	 * @return
	 */
	@SuppressWarnings("resource")
	public static String askRfid(String message) {

		String rfid = "";
		Scanner inputRfid = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				rfid = inputRfid.nextLine();
			} catch (InputMismatchException e) {
				inputRfid = new Scanner(System.in);
			}

			// Break case: 9 chars and hex digits
			if ((rfid.length() == 9) && (rfid.matches("\\p{XDigit}+"))) {
				break;
			}

			System.out
					.println("Invalid RFID! Must be 9 chars and contain 0-9 or A-F.");

		} while (true);

		return rfid;

	}

	/**
	 * Ask the user for a valid price
	 * 
	 * @param message
	 * @return
	 */
	public static double askPrice(String message) {

		double price = -1;
		@SuppressWarnings("resource")
		Scanner inputPrice = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				price = inputPrice.nextDouble();
			} catch (InputMismatchException e) {
				inputPrice = new Scanner(System.in);
			}

			// Break case: 0 or greater
			if (price >= 0) {
				break;
			}

			System.out.println("Invalid price! Must be greater than 0.");

		} while (true);

		return price;

	}

	/**
	 * Ask the user for a valid item quantity
	 * 
	 * @param message
	 * @return
	 */
	public static int askQuantity(String message) {

		int quantity = -1;
		@SuppressWarnings("resource")
		Scanner inputQuantity = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				quantity = inputQuantity.nextInt();
			} catch (InputMismatchException e) {
				inputQuantity = new Scanner(System.in);
			}

			// Break case: 0 or greater
			if (quantity >= 0) {
				break;
			}

			System.out.println("Invalid quantity! Must be atleast 0.");

		} while (true);

		return quantity;

	}

	/**
	 * displays the table formatted
	 * 
	 * @param itemTable
	 */
	public static void displayTable(Hashtable<String, Item> itemTable) {
		@SuppressWarnings("rawtypes")
		Enumeration<String> names = null;
		String str = null;

		try {
			names = itemTable.keys();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("RFID           Name           Quantity     Price");
		System.out
				.println("-----------------------------------------------------");
		Item itemTemp3 = null;

		Set set = itemTable.keySet();
		Iterator itr = set.iterator();

		while (itr.hasNext()) {
			str = (String) itr.next();

			itemTemp3 = itemTable.get(str);

			System.out.printf("%4s %15s        %4d       $%7.2f", str,
					itemTemp3.getName(), itemTemp3.getQuantity(),
					itemTemp3.getPrice());
			System.out.println();

		}

	}

	/**
	 * Asks for a valid shoppinh rfidNumber
	 * 
	 * @return rfidNumber
	 */
	@SuppressWarnings("resource")
	public static String askRfidShopping() {

		String rfid = "";
		Scanner inputRfid = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print("Enter a RFID Number to purchase (0 to Finish): ");

			try {
				rfid = inputRfid.nextLine();
			} catch (InputMismatchException e) {
				inputRfid = new Scanner(System.in);
			}

			if (rfid.equals("0")) {
				break;
			}

			// Break case: 9 chars and hex digits
			if ((rfid.length() == RFID_LIMIT) && (rfid.matches("\\p{XDigit}+"))) {
				break;
			}

			System.out
					.println("Invalid RFID! Must be 9 chars and contain 0-9 or A-F.");

		} while (true);

		return rfid;

	}

	/**
	 * Displays the menu commands
	 */
	public static void printMenu()

	{
		// 8 menu items
		System.out.println("");
		System.out.println("I) Insert an Item into the Store.");
		System.out.println("A) Add to the inventory for a given Item.");
		System.out.println("R) Remove an Item from the Store.");
		System.out.println("S) Search for Information about an Item.");
		System.out.println("G) Go Shopping.");
		System.out.println("Q) Quit and Save.");

	}

}