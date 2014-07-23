/**
 * This class is a <CODE>Throwable</CODE> that is thrown when
 * a <CODE>RideQueue</CODE> is full.
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */
 
@SuppressWarnings("serial")
public class FullQueueException extends Exception {

	public FullQueueException(String string) 
	   {
	       super(string);
	   }
	}
