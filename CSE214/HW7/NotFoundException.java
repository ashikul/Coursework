/**
 * 
 * An exception thrown when something is not found
 * 
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #7 for CSE 214,
 *         Fall 2013 December, 3, 2013
 */
public class NotFoundException extends Exception {

	public NotFoundException() { // Default message
		super("Playlist is full!");
	}

	public NotFoundException(String message) { // Passed message
		super(message);
	}

}