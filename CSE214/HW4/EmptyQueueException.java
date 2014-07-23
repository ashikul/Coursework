/**
 * This class is a <CODE>Throwable</CODE> that is thrown when
 * a <CODE>RideQueue</CODE> has no visitors.
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */
 
@SuppressWarnings("serial")
public class EmptyQueueException extends Exception {
	public EmptyQueueException(String string) 
	   {
	       super(string);
	   }
	}

