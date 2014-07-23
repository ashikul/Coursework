/**
 * @author Ashikul Alam 
 * CSE 214 HW 1
 * 108221262 
 * 
 *
 */

import java.util.Arrays;


public class Playlist{
	final int MAX_SONGS = 50;
	private String playlistName;
	private SongRecord[] songRecordArray = new SongRecord[MAX_SONGS + 1];

//Constructor
	public Playlist() {
		playlistName ="";
		for (int i = 1; i <= MAX_SONGS; i++){
			songRecordArray[i] = null;
		}
			
		}
	
//Clone	
	public Object clone(){
		
			Playlist s = new Playlist();
			System.arraycopy(this.songRecordArray, 1, s.songRecordArray, 1, 
					this.size());
			return (Playlist) s;
	}
		
//Equals

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Playlist other = (Playlist) obj;
		if (!Arrays.equals(songRecordArray, other.songRecordArray))
			return false;
		return true;
	}
	
	

	
//Size
	public int size(){
		int numberOfSongs = 0;
		for (int i=1; i<MAX_SONGS+1; i++){
			if (this.songRecordArray[i] != null){
				numberOfSongs+=1;
			}
		
		}
		return numberOfSongs;		
	}


//addSong
	public void addSong(SongRecord song, int position){
		if (song == null)
			return;
		if(!(position>=1 && position<=this.size()+1)) 
	        throw new IllegalArgumentException(
	        			"AddSong Position not within valid range");
		try{
			if(!(this.size()<MAX_SONGS)) 
					throw new FullPlaylistException(
							" There is no more room inside of "
									+ "the Playlist to store the new SongRecord "
									+ "object");
			}
			catch(FullPlaylistException ex){}
		
		System.arraycopy(this.songRecordArray, position, this.songRecordArray,
				position+1, this.size()+1-position);
		this.songRecordArray[position]= song;
	
	}
	
//removeSong	
	public void removeSong(int position){
		if (this.songRecordArray[position] == null)
			return;
		if(!(position>=1 && position<=this.size()+1)) 
	        throw new IllegalArgumentException(
	        			"Position is not within the valid range");
		
		System.arraycopy(this.songRecordArray, position+1, this.songRecordArray,
				position, this.size()-position);
		this.songRecordArray[this.size()] = null;
	}
//getSong
	public SongRecord getSong(int position){
		if (this.songRecordArray[position] == null)
			return null;
		if(!(position>=1 && position<=this.size()+1)) 
	        throw new IllegalArgumentException(
	        			"getSong Position not within valid range");
		return this.songRecordArray[position];
	}
	
//printAllSongs
	public void printAllSongs(){
		System.out.println(String.format("%n%-10s%-20s%-18s%-7s", "Song#",
				"Title", "Artist", "Length" ));
		System.out.println("-----------------------------------------------------"
				+ "---");
		System.out.println(this.toString());
	}
	
//getSongsByArtist
	public static Playlist getSongsByArtist(Playlist originalList, String artist){
		if (originalList == null || artist == null)
			return null;
		Playlist newList = new Playlist();
		int artistCount = 1;
		for (int i = 1; i <= originalList.size(); i++){
			if (originalList.songRecordArray[i].getArtist().equals(artist)){
				newList.songRecordArray[artistCount] = originalList.songRecordArray[i];
				artistCount++;
			}
		}
		return (Playlist) newList;
	}
//Get Playlist Name
	public String getPlaylistName(){
		return playlistName;
	}
//Change Playlist Name
	public void setPlaylistName(String name){
		this.playlistName = name;
	}
		

//toString
	public String toString(){
		String playlistTable = "";
		for (int i = 1; i <= this.size(); i++){
	
		playlistTable += String.format("%-10d%-30s%n", i , 
				this.songRecordArray[i].toString() );
		}
	return playlistTable;
	}
}//end
