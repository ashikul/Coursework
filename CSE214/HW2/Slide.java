/**
 * This class contains stores data for a single slide with acessor, mutator,
 * toString methods.
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #2 for CSE 214,
 *         Fall 2013 September 21, 2013
 */

public class Slide {

	/**
	 * Each slide will have this many lines.
	 * 
	 */
	final static int LINES_PER_SLIDE = 5;
	/**
	 * Each slide has an array that holds the text for each line.
	 * 
	 */
	String[] SlideLine = new String[LINES_PER_SLIDE + 1];

	/**
	 * Constructor, intilizes each line as blank.
	 */
	public Slide() {
		for (int i = 1; i < LINES_PER_SLIDE + 1; i++) {
			SlideLine[i] = "";
		}
	}

	/**
	 * Accessor to get a specific line from a slide.
	 * 
	 * @param line
	 *            Specificy which line to retrieve.
	 * @return returns the string of that line
	 * 
	 */

	public String getSlideLine(int line) {
		return SlideLine[line];
	}

	/**
	 * Mutator for Slide class.
	 * 
	 * @param text
	 *            The text that will replace the old text.
	 * @param line
	 *            Specifiy which line to change.
	 * 
	 */
	public void setSlideLine(String text, int line) {
		SlideLine[line] = text;
	}

	/**
	 * toString Method that outputs line by line the slide.
	 * 
	 * @see java.lang.Object#toString()
	 */
	public String toString() {

		String tempSlide = "";
		for (int i = 1; i < LINES_PER_SLIDE; i++) {
			tempSlide += this.getSlideLine(i) + "\n";
		}
		tempSlide += this.getSlideLine(LINES_PER_SLIDE);
		return tempSlide;

	}

}
