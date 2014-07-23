/**
 *
 *This class stores a Player Object
 *
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #7 for CSE 214, Fall 2013
 * December, 3, 2013
 */

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;

@SuppressWarnings("serial")
public class Player implements Serializable {

	@SuppressWarnings("rawtypes")
	private ArrayList playlistList = new ArrayList();
	private Playlist currentPlaylist;
	private Song currentSong;
	
	
	public Player() {
		this.playlistList.clear();
		this.currentPlaylist = null;
		this.currentSong = null;
		
	}
	
	
	

	@SuppressWarnings("unchecked")
	public void addPlaylist(Playlist list) {
		playlistList.add(list);
		if (currentPlaylist == null) {
			currentPlaylist = list;
			try {
				currentSong = list.getNextSong();
			} catch (Exception e) {

				currentSong = null;
			}

		}
	}

	// This method should add the specified Playlist to the Player. The added
	// Playlist should not displace the current Playlist unless there is no
	// current Playlist.

	public void removePlaylist(Playlist list) {
		if (playlistList.remove(list)) {
			if (currentPlaylist == list) {
				currentPlaylist = (Playlist) playlistList.get(0);
				try {
					currentSong = currentPlaylist.getNextSong();
				} catch (Exception e) {

					currentSong = null;
				}
			}
		}

	}

	// method should remsove the specified Playlist from the Player. If the
	// removed Playlist was the current Playlist, pick any other existing
	// playlist (if any) and make it the current Playlist. If the given Playlist
	// is not in the Player, do nothing.

	public Playlist getCurrentPlaylist() {
		return this.currentPlaylist;
	}

	// This method is a simple accessor method for the current Playlist field.

	public Playlist getPlaylistByName(String name) throws NotFoundException {
		@SuppressWarnings("unchecked")
		Iterator<Playlist> it = playlistList.iterator();
		while (it.hasNext()) {
			Playlist obj = it.next();
			if ((obj.getPlaylistName().equals(name))) {

				return obj;
			}
		}

		throw new NotFoundException("Song was not found!");

	}

	// This method should return the given Playlist in Player with the given
	// name. If no Playlist with the given name exists, throw a
	// NotFoundException or any exception that serves as a marker analogous to a
	// NotFoundException.

	// Hint: This method should be used similarly to the “getSong” method
	// described earlier. They both serve to make sure that methods get passed
	// arguments that should exist in the data structure so that all the
	// exception handling can be done by a single method.

	public void setCurrentPlaylist(Playlist list) {
		this.currentPlaylist = list;
	}

	// This method is a simple mutator method for the currentPlaylist field.
	// Implementation will vary depending on how your data structures are
	// defined.

	public Song getCurrentSong() {
		return currentSong;
	}

	// This method should return the song that is currently being played.

	/**
	 * @return the playlistList
	 */

	@SuppressWarnings("rawtypes")
	public ArrayList getPlaylistList() {
		return playlistList;
	}

}
