/**
 * This class is a node that contains an int representing the number of pennies
 * on the table. It also references to three children (left, middle, right).
 * 
 * EXTRA CREDIT The node references n-children with an n-array of GameNode
 * references through <CODE>link</CODE>and holds n, the number of children,
 * CODE>maxLink</CODE>.
 * 
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #5 for CSE 214,
 *         Fall 2013 November 4, 2013
 */

public class GameNode {
	private int data;
	private GameNode[] link;
	private int maxLink;

	/**
	 * Constructor with 2 input parameters
	 * 
	 * @param initData
	 *            Number of pennies
	 * @param max
	 *            Number of children
	 */
	public GameNode(int initData, int max) {
		data = initData;
		setMaxLink(max);

		link = new GameNode[maxLink + 1];
		for (int i = 1; i <= maxLink; i++) {
			link[i] = null;
		}

	}

	/**
	 * Accessor for Data
	 * 
	 * @return the data
	 */
	public int getData() {
		return data;
	}

	/**
	 * Mutator for data
	 * 
	 * @param data
	 *            the data to set
	 */
	public void setData(int data) {
		this.data = data;
	}

	/**
	 * Acessor for the number of children
	 * 
	 * @return the maxLink
	 */
	public int getMaxLink() {
		return maxLink;
	}

	/**
	 * Mutator for the number of children
	 * 
	 * @param maxLink
	 *            the maxLink to set
	 */
	public void setMaxLink(int maxLink) {
		this.maxLink = maxLink;
	}

	/**
	 * Acessor for the node's children
	 * 
	 * @return the link
	 */
	public GameNode getLink(int element) {
		return link[element];
	}

	/**
	 * Mutator for the node's children
	 * 
	 * @param link
	 *            the link to set
	 */
	public void setLink(int element, GameNode node) {
		this.link[element] = node;
	}

	/**
	 * Counts the number of leaves below this node. It is recursive and requires
	 * to be called with 0 to function.
	 * 
	 * @param recursive
	 *            leaves, call this method with 0
	 * @return total number of leaves
	 */
	public int numLeaves(int leaves) {

		for (int i = 1; i <= maxLink; i++) {
			if (link[i] != null)
				leaves = link[i].numLeaves(leaves);
		}

		for (int i = 1; i <= maxLink; i++) {
			if (link[i] != null) {
				return leaves;
			}
		}
		leaves++;
		return leaves;

	}

}
