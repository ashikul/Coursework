/**
 * This class is a <CODE>Throwable</CODE> that is thrown when
 * a <CODE>cursor</CODE> is null.
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #2 for CSE 214, Fall 2013
 * September 21, 2013
 */


@SuppressWarnings("serial")
public class NullCursorException extends Exception {
    public NullCursorException()
    {  //Default message
        super("Cursor is null!");
    }
    public NullCursorException(String message)
    {   //Passed message
        super(message);
    }

}