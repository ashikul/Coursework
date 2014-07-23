/**
 * This class is implements a tree of GameNode nodes. It holds references to the
 * root and current gameposition. It also holds the n-ary link value and an
 * array for optimization purposes.
 * 
 * 
 * EXTRA CREDIT I tried optimizing the game tree contruction, please see the
 * method private void createTree(GameNode node){
 * 
 * 
 * @author Ashikul Alam ID: 108221262 Recitation: 03 Homework #5 for CSE 214,
 *         Fall 2013 November 4, 2013
 */

public class GameTree {

	private GameNode root;
	private GameNode gamePosition;
	private int maxLink;
	private GameNode[] nodeArray;

	/**
	 * Default Constructor
	 * 
	 */
	public GameTree() {
		root = null;
		gamePosition = null;
	}

	/**
	 * Constructor with input paramaters
	 * 
	 * @param N
	 *            Number of pennies
	 * @param max
	 *            "n" of the n-ary tree
	 */
	public GameTree(int N, int max) {

		if (N < 5) {
			throw new IllegalArgumentException(
					"Number of pennies is less than 5");
		}
		maxLink = max;
		root = new GameNode(N, maxLink);
		gamePosition = root;

		nodeArray = new GameNode[N + 1];
		createTree(root);

	}

	/**
	 * Gives the number of leaves of the root of this Gametree
	 * 
	 * @return total number of leaves
	 */
	public int numWays() {
		return root.numLeaves(0);
	}

	/**
	 * Method to change the gamePosition, "removing pennies".
	 * 
	 * @param num
	 *            , which child node to go to, "1" is leftmost child "maxLink"
	 *            for n-ary tree is rightmost child
	 */
	public void change(int num) {

		if ((num >= 1) && (num <= maxLink)) {
			if (gamePosition.getLink(num) != null) {
				gamePosition = gamePosition.getLink(num);
				return;
			}

		}

	}

	/**
	 * Creates the GameTree by first creating the leftmost nodes first, so the
	 * number of nodes is equal to the root.
	 * 
	 * EXAMPLE: If the root is 5, only 5 GameNodes are created.
	 * 
	 * Then, the remaining child nodes are referenced to the leftmost nodes
	 * recursively. As a result, the GameTree works as intended but with less
	 * nodes required.
	 * 
	 * @param node
	 *            , the root
	 */
	private void createTree(GameNode node) {
		int nodeValue = node.getData(); // The root's value

		if ((nodeValue - 1 >= 0) && (node.getLink(1) == null)) {

			nodeArray[nodeValue - 1] = new GameNode(nodeValue - 1, maxLink); // Create
																				// unique
																				// node

			node.setLink(1, nodeArray[nodeValue - 1]); // Link in order

			createTree(nodeArray[nodeValue - 1]); // Recursive Call
		}

		for (int i = 2; i <= maxLink; i++) {

			if ((nodeValue - i >= 0)) {

				node.setLink(i, nodeArray[nodeValue - i]); // Sets the
															// references

			}

		}
	}

	/**
	 * Accessor for the GameTree's root
	 * 
	 * @return root
	 */
	public GameNode getRoot() {
		return root;
	}

	/**
	 * Accessor for the GameTree's gamePosition
	 * 
	 * @return gamePosition
	 */
	public GameNode getGamePosition() {
		return gamePosition;
	}

	/**
	 * Accessor for the GameTree's n-children
	 * 
	 * @return maxLink
	 */
	public int getMaxLink() {
		return maxLink;
	}

}
