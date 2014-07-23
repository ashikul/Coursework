/**
 *
 *This class operates with user input
 *through text menu. It mimics an mp3 player.
 *
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #7 for CSE 214, Fall 2013
 * December, 3, 2013
 */

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.InputMismatchException;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;
import java.util.StringTokenizer;

public class MyTunes {

	static Player player = new Player();

	public static void mainMenu() throws NotFoundException, IOException {

		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		char option = ' ';

		while (true) {
			printMainMenu();
			System.out.print("\nPlease Choose a Menu Option: ");
			option = input.next().trim().charAt(0);
			System.out.println();

			switch (option) {

			case 'a':
			case 'A':

				do {

					String testPlaylist = askString("Please input playlist name: ");

					try {

						player.getPlaylistByName(testPlaylist);

						System.out
								.println("Error, a playlist with that name already exists.");

					} catch (NotFoundException e) {

						Playlist tempPlaylist = new Playlist(testPlaylist);
						player.addPlaylist(tempPlaylist);
						System.out.println("Playlist ‘" + testPlaylist
								+ "’ successfully created.");
						break;
					}

				} while (true);

				break;
			case 'r':
			case 'R':

				String testPlaylist = askString("Please input playlist name to remove:");

				try {

					player.removePlaylist(player
							.getPlaylistByName(testPlaylist));
					System.out.println("Playlist ‘" + testPlaylist
							+ "’ successfully removed.");

				} catch (NotFoundException e) {
					System.out
							.println("Error, no playlist could be found with that name.");
					break;
				}

				break;
			case 's':
			case 'S':

				String testPlaylist1 = askString("Please input playlist name: ");

				try {

					player.getPlaylistByName(testPlaylist1);

					Playlist tempPlaylist = new Playlist(testPlaylist1);
					player.setCurrentPlaylist(tempPlaylist);
					System.out.println("Current Playlist ‘" + testPlaylist1
							+ "’ is successful");

				} catch (NotFoundException e) {
					System.out.println("Error, not found.");
					break;
				}

				break;
			case 'c':
			case 'C':
				secondMenu();

				break;
			case 'p':
			case 'P':
				System.out.println();

				if (player.getCurrentSong() == null) {
					System.out
							.println("Error, there is no current playlist to play from.");

				} else {

					System.out.println("Playing Next Song: "
							+ player.getCurrentSong().getSongName() + " - "
							+ player.getCurrentSong().getArtistName()

					);
					player.getCurrentSong().incrementNumPlays();
				}
				break;
			case 'g':
			case 'G':
				System.out.println();
				try {
					System.out.println("Current Song: "
							+ player.getCurrentSong().getSongName() + " - "
							+ player.getCurrentSong().getArtistName()

					);
				} catch (NullPointerException e) {

					System.out.println("No song is currently being played.");
				}

				break;
			case 'l':
			case 'L':

				@SuppressWarnings("unchecked")
				ArrayList<Playlist> playlistList3 = player.getPlaylistList();

				Iterator<Playlist> it = playlistList3.iterator();
				while (it.hasNext()) {
					Playlist obj = it.next();

					if (player.getCurrentPlaylist() == obj) {
						System.out.println("Playlist: " + obj.getPlaylistName()
								+ " *Current Playlist*");
					} else {
						System.out
								.println("Playlist: " + obj.getPlaylistName());
					}

				}

				break;
			case 'f':
			case 'F':

				fileLoad();

				break;
			case 'q':
			case 'Q':

				try {
					FileOutputStream file = new FileOutputStream("player.obj");
					ObjectOutputStream fout = new ObjectOutputStream(file);
					fout.writeObject(player);
					fout.close();
				} catch (IOException a) {
				}

				System.out.println("Program terminating normally...");
				System.exit(1);

				break;

			default:
				System.out.println("Invalid menu option!");
				System.out.println();
				break;

			}
		}

	}

	private static void fileLoad() throws IOException {

		int playlistCount = 0;
		int songCount = 0;
		Boolean invalidFileLocation = true;
		String fileLocation = ""; // String to store file location
									// example: C:/Test.txt
		Scanner input = new Scanner(System.in);

		FileInputStream fis = null;

		do {

			System.out.print("\n");
			System.out.print("Enter text file location: ");
			fileLocation = input.nextLine();

			try {

				FileInputStream fisTry = new FileInputStream(fileLocation);
				fis = fisTry;
				invalidFileLocation = false;

			} catch (java.io.FileNotFoundException e) {
				System.out.println("Invalid text file location!");

			}

		} while (invalidFileLocation);

		InputStreamReader inStream = new InputStreamReader(fis);
		BufferedReader stdin = new BufferedReader(inStream);

		String data = stdin.readLine(); // Stores the line in a String to
										// manipulate

		while ((data != null)) {

			String token = "";
			StringTokenizer tokenSplit = new StringTokenizer(data, ",");
			token = tokenSplit.nextToken();

			String savedToken = token;

			try {
				player.getPlaylistByName(token);

			} catch (NotFoundException e) {
				// newplaylist
				Playlist tempTokenPlaylist = new Playlist(token);
				player.addPlaylist(tempTokenPlaylist);
				playlistCount++;

			}

			Song tempSong = new Song();

			tempSong.setSongName(tokenSplit.nextToken());
			tempSong.setArtistName(tokenSplit.nextToken());
			tempSong.setLength(Integer.parseInt(tokenSplit.nextToken().trim()));
			tokenSplit.nextToken();
			tempSong.setFileName(tokenSplit.nextToken());

			try {
				player.getPlaylistByName(savedToken).addSong(tempSong);
				songCount++;
			} catch (NotFoundException e) {

				e.printStackTrace();
			}

			data = stdin.readLine();

		}

		System.out.println("Successfully imported " + playlistCount
				+ " playlists and " + songCount + " songs.");

	}

	public static void secondMenu() throws NotFoundException, IOException {

		@SuppressWarnings("resource")
		Scanner input = new Scanner(System.in);
		char option = ' ';

		while (true) {
			System.out.println();
			printSecondMenu();
			System.out.println();
			try {
				System.out.println("Playlist Being Modified: "
						+ player.getCurrentPlaylist().getPlaylistName());
			} catch (Exception e1) {
				System.out.println("Current Playlist is empty, returning...");
				mainMenu();
			}
			System.out.println();
			System.out.print("\nPlease Choose a Menu Option: ");
			option = input.next().trim().charAt(0);
			System.out.println();

			switch (option) {

			case 'a':
			case 'A':

				String tempSongName = askString("Please input song name: ");
				String tempSongArtist = askString("Please input song  artist: ");
				int tempSongLength = askInt("Please input song length: ");
				String tempSongFile = askString("Please input song filename: ");

				Song tempSong = new Song(tempSongName, tempSongArtist,
						tempSongLength, tempSongFile);

				player.getCurrentPlaylist().addSong(tempSong);

				System.out.println("Song successfully added to Playlist.");

				break;
			case 'r':
			case 'R':

				String tempSongName1 = askString("Please input song name: ");
				String tempSongArtist1 = askString("Please input song artist: ");

				try {
					player.getCurrentPlaylist().getSong(tempSongName1,
							tempSongArtist1);
					System.out.println("Song removed!");
				} catch (NotFoundException e) {
					System.out.println("Song not found!");
					break;
				}

				break;
			case 'n':
			case 'N':

				player.getCurrentPlaylist().sortBySongName();
				System.out
						.println("Playlist successfully sorted by song name.");

				break;
			case 'm':
			case 'M':

				String tempPlaylistName = askString("Please enter a playlist name to rename: ");

				try {
					player.getPlaylistByName(tempPlaylistName).setPlaylistName(
							askString("Enter new playlist name: "));
					System.out.println("Succesfully renamed to "
							+ tempPlaylistName);

				} catch (NotFoundException e) {

					System.out.println("Playlist name was not found...");

				}

				break;
			case 't':
			case 'T':

				player.getCurrentPlaylist().sortBySongArtist();
				System.out
						.println("Playlist successfully sorted by song artist.");

				break;
			case 'p':
			case 'P':

				player.getCurrentPlaylist().sortBySongPlays();
				System.out
						.println("Playlist successfully sorted by song plays.");

				break;
			case 'g':
			case 'G':

				player.getCurrentPlaylist().sortBySongLength();
				System.out
						.println("Playlist successfully sorted by song length.");

				break;
			case 'l':
			case 'L':

				// format print

				System.out.println(player.getCurrentPlaylist()
						.getPlaylistName() + " contents:");
				System.out.println();
				System.out
						.println("Name       Artist              Plays     Length");
				System.out
						.println("-----------------------------------------------------");

				ArrayList<Song> playlistList2 = player.getCurrentPlaylist()
						.getSongList();

				Iterator<Song> it = playlistList2.iterator();
				while (it.hasNext()) {

					Song obj = it.next();
					System.out.printf("%-10s %-15s        %-3d       %-4d",
							obj.getSongName(), obj.getArtistName(),
							obj.getNumPlays(), obj.getLength());
					System.out.println();

				}

				break;
			case 'q':
			case 'Q':
				mainMenu();
				break;

			default:
				System.out.println("Invalid menu option!");
				System.out.println();
				break;

			}
		}

	}

	public static String askString(String message) {

		String inputString = "";
		@SuppressWarnings("resource")
		Scanner inputName = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				inputString = inputName.nextLine();
				break;
			} catch (InputMismatchException e) {
				inputName = new Scanner(System.in);
			}

			System.out.println("Invalid string!");

		} while (true);

		return inputString;

	}

	public static int askInt(String message) {

		int quantity = -1;
		@SuppressWarnings("resource")
		Scanner inputQuantity = new Scanner(System.in);

		do {
			System.out.print("");
			System.out.print(message);

			try {
				quantity = inputQuantity.nextInt();
				break;
			} catch (InputMismatchException e) {
				inputQuantity = new Scanner(System.in);
			}

			System.out.println("Invalid int!");

		} while (true);

		return quantity;

	}

	public static void printMainMenu()

	{

		System.out.println("");
		System.out.println(" A - Add Playlist");
		System.out.println(" R - Remove Playlist");
		System.out.println(" S - Set Current Playlist");
		System.out.println(" C - Change Current Playlist");
		System.out.println(" P - Play Next Song");
		System.out.println(" G - Get Current Song");
		System.out.println(" L - Print All Playlists");
		System.out.println(" F - Read from Text File");
		System.out.println(" Q - Quit MyTunes");
		System.out.println("");

	}

	public static void printSecondMenu()

	{

		System.out.println("");
		System.out.println(" Playlist Modification Menu:");
		System.out.println("");
		System.out.println(" A - Add Song");
		System.out.println(" R - Remove Song");
		System.out.println(" N - Sort Playlist By Name");
		System.out.println(" T - Sort Playlist By Artist");
		System.out.println(" P - Sort Playlist By Plays");
		System.out.println(" G - Sort Playlist By Length");
		System.out.println(" M - Rename Playlist");
		System.out.println(" L - Print Playlist Contents");
		System.out.println(" Q - Exit to Main Menu");

		System.out.println("");

	}

	public static void main(String[] args) throws NotFoundException,
			IOException {

		try {
			// If file is found, open it
			FileInputStream file = new FileInputStream("player.obj");
			ObjectInputStream fin = new ObjectInputStream(file);
			player = (Player) fin.readObject();
			file.close();
		} catch (IOException a) {
		} catch (ClassNotFoundException c) {
		} // Bottoms up!
			// Note that myObject may still be null

		if (player == null) {
			player = new Player();
		}

		// start program
		System.out.println("");
		System.out.println("Welcome to MyTunes!");
		mainMenu();

	}

}
