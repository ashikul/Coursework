/**
 * @author Ashikul Alam 
 * CSE 214 HW 1
 * 108221262 
 * 
 *
 */

@SuppressWarnings("serial")
public class FullPlaylistException extends Exception {
    public FullPlaylistException()
    {  //Default message
        super("Playlist is full!");
    }
    public FullPlaylistException(String message)
    {   //Passed message
        super(message);
    }

}
