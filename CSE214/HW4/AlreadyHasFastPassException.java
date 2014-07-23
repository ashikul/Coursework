/**
 * This class is a <CODE>Throwable</CODE> that is thrown when
 * a <CODE>VisitorInfo</CODE> has a fast-pass ticket.
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */
 
@SuppressWarnings("serial")
public class AlreadyHasFastPassException extends Exception {

public AlreadyHasFastPassException(String string) 
   {
       super(string);
   }
}
