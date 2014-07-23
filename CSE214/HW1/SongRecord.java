/**
 * @author Ashikul Alam 
 * CSE 214 HW 1
 * 108221262 
 * 
 *
 */

public class SongRecord {
	private String title, artist;
	private int minutes, seconds;
	
//Constructor
	public SongRecord (){
		this.title = "";
		this.artist = "";
		this.minutes = 0;
		this.seconds = 0;
	}
//Accesors
	public String getTitle(){
		return title;
	}
	public String getArtist(){
		return artist;
	}
	public int getMinutes(){
		return minutes;
	}
	public int getSeconds(){
		return seconds;
	}
//Mutators
	/**
	 * @param title
	 */
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * @param artist
	 */
	public void setArtist(String artist){
		this.artist = artist;
	}
	/**
	 * @param minutes
	 */
	public void setMinutes(int minutes ){
		
	if (minutes >= 0)
			this.minutes = minutes;
	else
			throw new IllegalArgumentException(
				"Minutes can not be negative" );
	}
	/**
	 * @param seconds
	 */
	public void setSeconds(int seconds ){
		
	if (seconds >= 0 && seconds <= 59)
			this.seconds = seconds;
	else
			throw new IllegalArgumentException(
					"Seconds must be between 0 and 59" );
	
	}
	
//Clone
	/* (non-Javadoc)
	 * @see java.lang.Object#clone()
	 */
	public Object clone(){
		
		SongRecord clone = new SongRecord();
		clone.title = this.title;
		clone.artist = this.artist;
		clone.minutes = this.minutes;
		clone.seconds = this.seconds;
		return (SongRecord) clone;
		
		}
	
//Equals
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
		SongRecord other = (SongRecord) obj;
		if (artist == null) {
			if (other.artist != null)
				return false;
		} else if (!artist.equals(other.artist))
			return false;
		if (minutes != other.minutes)
			return false;
		if (seconds != other.seconds)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
		
	}
//toString
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString(){
		return String.format("%-20s%-18s%d:%02d", getTitle(), getArtist(), 
				getMinutes(), getSeconds());
	}
}

