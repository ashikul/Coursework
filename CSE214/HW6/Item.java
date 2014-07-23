/**
 *This class holds an Item object. It holds
 *4 values and has the regular constructors, setters
 *and getters.
 *
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #6 for CSE 214, Fall 2013
 * November 19, 2013
 */

import java.io.Serializable;

@SuppressWarnings("serial")
public class Item implements Serializable {

	private String name;
	// 25 char
	private String rfidNumber;
	// exactly 9 hex, 0-9, A-F
	private int quantity;
	// no negatives
	private double price;
	// no negatives

	/**
	 * Default Constructor
	 */
	public Item() {

	}


	/**
	 * Accessor for name
	 * 
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Accessor for rfidNumber
	 * 
	 * @return the rfidNumber
	 */
	public String getRfidNumber() {
		return rfidNumber;
	}

	/**
	 * Accessor for quantity
	 * 
	 * @return the quantity
	 */
	public int getQuantity() {
		return quantity;
	}

	/**
	 * Accessor for price
	 * 
	 * @return the price
	 */
	public double getPrice() {
		return price;
	}

	/**
	 * Mutator for name
	 * 
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Mutator for rfid number
	 * 
	 * @param rfidNumber
	 *            the rfidNumber to set
	 */
	public void setRfidNumber(String rfidNumber) {
		this.rfidNumber = rfidNumber;
	}

	/**
	 * Mutator for quantity
	 * 
	 * @param quantity
	 *            the quantity to set
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	/**
	 * Mutator for price
	 * 
	 * @param price
	 *            the price to set
	 */
	public void setPrice(double price) {
		this.price = price;
	}

}
