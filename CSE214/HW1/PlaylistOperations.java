/**
 * @author Ashikul Alam 
 * CSE 214 HW 1
 * 108221262 
 * 
 *
 */

import java.util.Scanner;


public class PlaylistOperations {
	final static int MAX_PLAYLIST = 5;
	static int currentPlaylistTrack = 1;	
	static Playlist[] playlistArray = new Playlist[MAX_PLAYLIST+1];

//Intialize Playlist Array
	public static void intializePlaylistArray(){
	
	for(int j = 1; j <= MAX_PLAYLIST; j++){
		playlistArray[j] = new Playlist();
		playlistArray[j].setPlaylistName("");
		
			}
		playlistArray[1].setPlaylistName("Default");
		}	
	
//Menu
	public static void displayMenu(){
				System.out.println();
				System.out.printf("%-20s%15s%n", "Add Song", "(A)");
				System.out.printf("%-20s%15s%n", "Get Song", "(G)");
				System.out.printf("%-20s%15s%n", "Remove Song", "(R)");
				System.out.printf("%-20s%15s%n", "Print All Songs", "(P)");
				System.out.printf("%-20s%14s%n", "Print Songs By Artist", "(B)");
				System.out.printf("%-20s%15s%n", "Size", "(S)");
				System.out.printf("%-20s%15s%n", "Quit", "(Q)");
				System.out.printf("%-20s%15s%n", "New Playlist", "(N)");
				System.out.printf("%-20s%15s%n", "Change Playlist", "(V)");
				System.out.printf("%-20s%15s%n", "Copy Playlist ", "(C)");
				System.out.printf("%-20s%15s%n", "Compare Playlist", "(E)");
				System.out.printf("%-20s%15s%n", "Display Playlists", "(D)");
				System.out.println();
				@SuppressWarnings("resource")
				Scanner input = new Scanner(System.in);
		  		System.out.print("Select a menu option: ");	 
		  		char c =input.next().trim().charAt(0);
		  	    switch (c) {
		  	    
		  	    case 'a':
		  	    case 'A':	
		  	    	PlaylistOperations.playlistAddSong();
		  	    	break;
		  	    case 'g':
		  	    case 'G':
		  	    	PlaylistOperations.playlistGetSong();
		  	    	break;
		  	    case 'r':
		  	    case 'R':
		  	    	PlaylistOperations.playlistRemoveSong();
		  	    	break;
		  	    case 'p':
		  	    case 'P':
		  	    	PlaylistOperations.playlistPrintAllSongs();
		  	    	break;
		  	    case 'b':
		  	    case 'B':
		  	    	PlaylistOperations.playlistPrintSongsArtist();
		  	    	break;
		  	    case 's':
		  	    case 'S':
		  	    	PlaylistOperations.playlistSize();
		  	    	break;
		  	    case 'q':
		  	    case 'Q':
		  	    	PlaylistOperations.playlistQuit();
		  	    	break;
		  	    case 'n':
		  	    case 'N':
		  	    	PlaylistOperations.playlistNew();
		  	    	break;
		  	 	case 'v':
		  	    case 'V':
		  	    	PlaylistOperations.playlistChange();
		  	    	break;
		  	    case 'c':
		  	    case 'C':
		  	    	PlaylistOperations.playlistCopy();
		  	    	break;
		  	    case 'e':
		  	    case 'E':
		  	    	PlaylistOperations.playlistCompare();
		  	    	break;
		  	    case 'd':
		  	    case 'D':
		  	    	PlaylistOperations.playlistDisplayAll();
		  	    	break;
		  	    default:
		  	      System.out.println("Invalid menu option!");
		  	      break;
		  	    }
		  		

	}
	
//Add Song

	public static void playlistAddSong(){
		
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		int tempPosition = 0;
		
		SongRecord tempSongRecord = new SongRecord();
  		System.out.print("Enter the song title: ");
		tempSongRecord.setTitle(input.nextLine());
  		System.out.print("Enter the song artist: ");
  		tempSongRecord.setArtist(input.nextLine());
  		System.out.print("Enter the song length (minutes): ");
  		tempSongRecord.setMinutes(input.nextInt());
  		System.out.print("Enter the song length (seconds): ");
  		tempSongRecord.setSeconds(input.nextInt());
  		System.out.print("Enter the position: ");
  		tempPosition = input.nextInt();

  		playlistArray[currentPlaylistTrack].addSong(tempSongRecord, tempPosition);
  		System.out.println();
  		System.out.println("Song Added: " + tempSongRecord.getTitle() + " By " +
  		tempSongRecord.getArtist()); //no output
  		
	}
//GetSong
	public static void playlistGetSong(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		int tempPosition = 0;
		System.out.print("Enter the position: ");
  		tempPosition = input.nextInt();
  		System.out.println(String.format("%n%-10s%-20s%-18s%-7s", "Song#", "Title",
  				"Artist", "Length" ));
		System.out.println("----------------------------------------------------"
				+ "----");
		System.out.printf("%-10d%-30s%n", tempPosition ,
				playlistArray[currentPlaylistTrack].getSong(tempPosition).toString() );	
	}
//RemoveSong
	public static void playlistRemoveSong(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		int tempPosition = 0;
		System.out.print("Enter the position: ");
  		tempPosition = input.nextInt();
  		playlistArray[currentPlaylistTrack].removeSong(tempPosition);
  		System.out.println("Song Removed at position " + tempPosition);
	}
//Print All Songs
	public static void playlistPrintAllSongs(){
		playlistArray[currentPlaylistTrack].printAllSongs();
	}
//Print Songs By Artist
	public static void playlistPrintSongsArtist(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the artist: ");
		Playlist.getSongsByArtist(playlistArray[currentPlaylistTrack], 
				input.nextLine()).printAllSongs();
	}
//Size
	public static void playlistSize(){
		
		System.out.println("There are " + playlistArray[currentPlaylistTrack].size()
				+ " song(s) in the current playlist");	
	}
//Quit
	public static void playlistQuit(){
		System.out.println("Program terminating normally...");
		System.exit(1); 
	}
//New Playlist
	public static void playlistNew(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the new playlist name: ");
		for ( int i = 1; i<MAX_PLAYLIST+1; i++){
			if (playlistArray[i].getPlaylistName().equals("")){
					currentPlaylistTrack=i;
			break;
			}
		}
		playlistArray[currentPlaylistTrack].setPlaylistName(input.nextLine());	
		System.out.print("Your current playlist is now " + playlistArray[currentPlaylistTrack].getPlaylistName());
		
	}
//Change Playlist
	public static void playlistChange(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the playlist name to switch to: ");
		String tempString = input.nextLine();
		for ( int i = 1; i<MAX_PLAYLIST+1; i++){
			if (playlistArray[i].getPlaylistName().equals(tempString)){
				currentPlaylistTrack = i;
				System.out.println("Playlist switched!");
				System.out.println("Your current playlist is now " + 
				playlistArray[currentPlaylistTrack].getPlaylistName());
				return;
			}
		}
		System.out.print("Playlist name not found!");
		
		
	}
//Copy Playlist
	public static void playlistCopy(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Enter new playlist name: ");
		String tempString = input.nextLine();
		int tempCurrentPlaylistTrack = currentPlaylistTrack;
		for ( int i = 1; i<MAX_PLAYLIST+1; i++){
			if (playlistArray[i].getPlaylistName().equals("")){
					currentPlaylistTrack=i;
			break;
			}
		}
		playlistArray[currentPlaylistTrack] = (Playlist) playlistArray[tempCurrentPlaylistTrack].clone();
		playlistArray[currentPlaylistTrack].setPlaylistName(tempString);
		System.out.println("Your current playlist is now : " +
		playlistArray[currentPlaylistTrack].getPlaylistName()); 
		System.out.println();
	}
//Compare Playlist
	public static void playlistCompare(){
		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the playlist name to compare to: ");
		String tempString = input.nextLine();
		for ( int i = 1; i<MAX_PLAYLIST+1; i++){
			if (playlistArray[i].getPlaylistName().equals(tempString)){
				
				System.out.println("Playlist found! Comparing to current playlist...");
				System.out.println("Are they equal? " +
				playlistArray[currentPlaylistTrack].equals(playlistArray[i]));
				return;
			}
		}
		System.out.print("Playlist name not found!");
		
		
	}
//Display All Playlists
	public static void playlistDisplayAll(){
		System.out.printf("%n%-10s%-20s", "Playlist#", "Name");
		System.out.println();
		System.out.println("-----------------------------------");
		for ( int i = 1; i<MAX_PLAYLIST+1; i++){
			System.out.printf("%-10d%-30s%n", i , playlistArray[i].getPlaylistName());
		}
		
	}
	
//Main	
	public static void main(String[] args) {

	intializePlaylistArray();
	while (true)
		PlaylistOperations.displayMenu();

	}

}
