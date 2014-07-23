/**
 * 
 * This class stores a Song Object
 * 
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #7 for CSE 214,
 *         Fall 2013 December, 3, 2013
 */
@SuppressWarnings("rawtypes")
public class Song implements Comparable {

	private String songName, artistName, fileName;
	private int length, numPlays;

	// Constructor
	public Song(String name, String artist, int length, String filename) {

		this.songName = name;
		this.artistName = artist;
		this.fileName = filename;
		this.length = length;
		this.numPlays = 0;

	}

	public Song() {
		this.songName = null;
		this.artistName = null;
		this.fileName = null;
		this.length = 0;
		this.numPlays = 0;
	}

	/**
	 * @return the songName
	 */
	public String getSongName() {
		return songName;
	}

	/**
	 * @return the artistName
	 */
	public String getArtistName() {
		return artistName;
	}

	/**
	 * @return the fileName
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * @return the length
	 */
	public int getLength() {
		return length;
	}

	/**
	 * @return the numPlays
	 */
	public int getNumPlays() {
		return numPlays;
	}

	/**
	 * @param songName
	 *            the songName to set
	 */
	public void setSongName(String songName) {
		this.songName = songName;
	}

	/**
	 * @param artistName
	 *            the artistName to set
	 */
	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	/**
	 * @param fileName
	 *            the fileName to set
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * @param length
	 *            the length to set
	 */
	public void setLength(int length) {
		this.length = length;
	}

	/**
	 * @param numPlays
	 *            the numPlays to set
	 */
	public void incrementNumPlays() {
		this.numPlays++;
	}

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		return 0;
	}

}
