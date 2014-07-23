/**
 * This class holds the values for a visitor object.
 * A visitor's name and ticket status is stored.
 * The ticket status is 0 for no ticket,
 * 1 for regular ticket, and 2 for fast-pass.
 * 
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */
 
public class VisitorInfo {
	private String name;
	private int status;
	
	/**
	 * Default Constructor
	 */
	public VisitorInfo(){
		name = "";
		status = 0;
	}
 
	 
	/**Constructor with input parameters
	 * @param name Name of the visitor
	 * @param status	Ticket Status
	 */
	public VisitorInfo(String name, int status){
		this.name = name;
		this.status = status;   
	}
	
	 
	/**Accessor for visitor name
	 * @return string name
	 */
	public String getName(){
		return name;
	}
	/**Accessor for visitor's ticket status
	 * @return int status
	 */
	public int getStatus(){
		return status;
	}
	/**Mutator for visitor's name
	 * @param String name
	 */
	public void setName(String name){
		this.name = name;
	}
	/***Mutator for visitor's ticket status
	 * @param int status
	 */
	public void setStatus(int status){
		this.status = status;
	}
	
	/***Accessor for a string status representation
	 * @return string status
	 */
	public String getStatusText(){
		switch(status){
		case 0:
			return "no ticket";
		case 1:
			return "regular ticket";
		case 2:
			return "fast-pass";
		}
		return null;
 
	}
	

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		VisitorInfo other = (VisitorInfo) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (status != other.status)
			return false;
		return true;
	}
	
}
