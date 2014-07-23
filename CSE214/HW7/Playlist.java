/**
 *
 *This class stores a Playlist object
 *
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #7 for CSE 214, Fall 2013
 * December, 3, 2013
 */

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;

public class Playlist {
	// inal int MAX_SONGS = 50;
	private String playlistName;
	@SuppressWarnings("rawtypes")
	private ArrayList songList = new ArrayList();

	public Playlist(String name) {
		this.playlistName = name;
		this.songList.clear();

	}

	// This is the constructor for the Playlist class. The Playlist should
	// ALWAYS be constructed with a name for reference purposes therefore
	// whenever a Playlist is created, it must have a name.

	@SuppressWarnings("unchecked")
	public void addSong(Song s) {
		songList.add(s);
	}

	// This method adds the Song in the parameters to the end of the Playlist.
	// If the Playlist does not have a currently defined nextSong, this Song
	// should also be set to as the nextSong in the list. (However, this case
	// should only happen for the first Song being added to the Playlist.)

	public void removeSong(Song s) {
		songList.remove(s);
	}

	// This method removes the given Song s from the Playlist. If this song is
	// the next song in the list, the song following the song to be removed
	// should be set to the next song. If the song was not found, just do
	// nothing.

	public Song getSong(String name, String artist) throws NotFoundException {
		@SuppressWarnings("unchecked")
		Iterator<Song> it = songList.iterator();
		while (it.hasNext()) {
			Song obj = it.next();
			if ((obj.getSongName().equals(name) && (obj.getArtistName()
					.equals(artist)))) {

				return obj;
			}
		}

		throw new NotFoundException("Song was not found!");
	}

	// This method returns the first song found in the Playlist that has the
	// same name and artist. If no song was found with the same name and artist,
	// the method should throw some kind of exception that denotes that the song
	// was not found (the exception name doesn’t have to be NotFoundException).

	// Hint: Use this method in conjunction with methods like removeSong to find
	// and remove songs or do similar tasks. The purpose of this ‘layering’ is
	// to protect methods like removeSong from getting input that is not in the
	// data structure.

	public Song getNextSong() {
		return (Song) songList.get(0);
	}

	// This method returns the song that is marked as the next song in the
	// playlist (and will inherently be played when playSong is called). It is
	// merely an accessor method.

	@SuppressWarnings("unchecked")
	public void setNextSong(Song s) {
		songList.add(0, s);
	}

	// This method is the mutator method that allows a method to change the next
	// Song to any given Song s. The implementation of this method will vary
	// depending on your data structure and how you allow a method to change the
	// next Song to any given Song s.

	public void playSong() throws NotFoundException {
		// OPTIONAL - NOT REQUIRED

	}

	// This method causes the program to begin playing the specified song using
	// the method of your choice and sets the nextSong to the following Song and
	// puts the song that is being currently played at the end of the playlist.
	// If there is a problem playing the song; i.e. the specified file could not
	// be found or the file could not be played, throw a SongPlayException (or
	// equivalent).

	@SuppressWarnings("unchecked")
	public void sortBySongName() {

		// C:\input.txt
		Collections.sort(songList, new Comparator<Song>() {
			@Override
			public int compare(Song o1, Song o2) {

				return o1.getSongName().trim()
						.compareTo(o2.getSongName().trim());
			}
		});

	}

	// This method should sort the playlist in alphabetical order by song name.
	// This MUST be done using the compareTo/compare method as shown in the
	// sample program below. This method should also NOT change the current
	// song.

	@SuppressWarnings("unchecked")
	public void sortBySongArtist() {
		Collections.sort(songList, new Comparator<Song>() {
			@Override
			public int compare(Song o1, Song o2) {
				return o1.getArtistName().trim()
						.compareTo(o2.getArtistName().trim());

			}
		});

	}

	// This method should sort the playlist in alphabetical order by artist
	// name. This MUST be done using the compareTo/compare method as shown in
	// the sample program below. This method should also NOT change the current
	// song.

	@SuppressWarnings("unchecked")
	public void sortBySongPlays() {
		Collections.sort(songList, new Comparator<Song>() {
			@Override
			public int compare(Song o1, Song o2) {
				return o1.getNumPlays() - o2.getNumPlays();
			}
		});
	}

	// This method should sort the playlist in decreasing numerical order by
	// number of plays. This MUST be done using the compareTo/compare method as
	// shown in the sample program below. This method should also NOT change the
	// current song.

	@SuppressWarnings("unchecked")
	public void sortBySongLength() {
		Collections.sort(songList, new Comparator<Song>() {
			@Override
			public int compare(Song o1, Song o2) {
				return o1.getLength() - o2.getLength();
			}
		});
	}

	// This method should sort the playlist in decreasing numerical order by
	// song length. This MUST be done using the compareTo/compare method as
	// shown in the sample program below. This method should also NOT change the
	// current song.

	public String getPlaylistName() {
		return this.playlistName;
	}

	// This method is simply an accessor method for the Playlist’s name.

	public void setPlaylistName(String name) {
		this.playlistName = name;
	}

	/**
	 * @return the songList
	 */

	public ArrayList<Song> getSongList() {
		// TODO Auto-generated method stub
		return songList;
	}

}// end
