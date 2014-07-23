/**
 * This program reads in a C++ text file and
 * prints out integer variables and select comment operations such
 * as print LOCAL or a specific integer. 
 * Java's <CODE>Stack</CODE> Class is untilized.
 * 
 * @author Ashikul Alam
 *  ID: 108221262
 *  Recitation: 03
 *  Homework #3 for CSE 214,
 *  Fall 2013 October 6, 2013
 */

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;
import java.util.Stack;
import java.util.StringTokenizer;

public class BlockTracer {

	/**
	 * Starts off with asking for a input file location and then check each
	 * line, putting specific strings in <CODE>mainStack</CODE>. When a comment
	 * instruction is read, <CODE>mainStack</CODE> is cloned and a specific
	 * operation is performed. Program ends when there is no more valid input
	 * lines.
	 * 
	 * @param args
	 * @throws IOException
	 *             If the file path is invalid.
	 */
	@SuppressWarnings({ "resource" })
	public static void main(String[] args) throws IOException {

		Stack<String> mainStack = new Stack<String>(); // Main Stack to hold
														// strings

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

			// STACK PUSH "{"
			if (data.contains("{") == true) {
				mainStack.push("{");
			}

			// STACK PUSH IF IT IS A VIABLE INT STRING
			boolean dataBoolean = true; // Check if "int " is not apart of
										// "print "
			try {
				if ((data.charAt(data.indexOf("int ") - 1)) == ('r')) {
					dataBoolean = false;
				}

			} catch (StringIndexOutOfBoundsException e) {

			}

			if (data.contains("int ") && dataBoolean == true) {

				String dataSubstring = "";

				dataSubstring = data.substring(data.indexOf("int ") + 3,
						data.indexOf(";"));

				dataSubstring = dataSubstring.replaceAll("\\s=", "");
				dataSubstring = dataSubstring.replaceAll("=", " ");

				StringTokenizer variables = new StringTokenizer(dataSubstring,
						",");

				String token = "";
				while (variables.hasMoreTokens()) {
					token = variables.nextToken();
					if (Character.isDigit(token.charAt(token.length() - 1)) == false) {
						token = (token + " 0").trim();
					}
					token = token.trim();
					StringTokenizer tokenSplit = new StringTokenizer(token, " ");
					token = String.format("%-15s %s", tokenSplit.nextToken(),
							tokenSplit.nextToken());

					mainStack.push(token);
				}

			}

			// CLONE STACK AND PERFROM INPUTTED OPERATION
			if (data.contains("/*$print") == true) {
				String operation = new String();
				int operationsCount = 0;
				String latestOperationString = "";
				operation = data.substring(data.lastIndexOf("/*$print ") + 9,
						data.lastIndexOf("*"));

				Stack tempStack = (Stack) mainStack.clone();

				if (operation.equals("LOCAL")) { // OPERATION IS LOCAL

					while (!tempStack.empty()) {

						if (tempStack.peek().equals("{")) {
							if (operationsCount == 0) {
								System.out.println("");
								System.out
										.println("No local variables to print.");
								break;
							}
							System.out.println("");
							System.out.println("Variable Name	Initial Value");
							System.out.print(latestOperationString);
							break;
						}

						latestOperationString = (String) tempStack.pop() + "\n"
								+ latestOperationString;
						operationsCount++;

					}
					;

				}

				else { // OPERATION IS A VARIABLE

					while (!tempStack.empty()) {

						if (tempStack.peek().equals("}")) {

							tempStack.pop();
							tempStack = removeBlock(tempStack);

						}

						if (tempStack.peek().equals("{")) {
							if (operationsCount != 0) {
								break;
							}
						}

						if ((((String) tempStack.peek()).startsWith(operation)) == true) {
							latestOperationString = (String) tempStack.peek();
							operationsCount++;
						}
						tempStack.pop();

					}
					if (operationsCount == 0) {
						System.out.println("");
						System.out.println("Variable not found: " + operation);
					} else {
						System.out.println("");
						System.out.println("Variable Name	Initial Value");
						System.out.println(latestOperationString);

					}

				}

			}
			// STACK PUSH "}"
			if (data.contains("}") == true) {
				mainStack.push("}");
			}

			data = stdin.readLine();

		}

	}

	/**
	 * Recursive Method to remove inner blocks
	 * 
	 * @param tempStack
	 *            Takes in the cloned stack to manipulate
	 * @return Returns the manipulated Stack with inner blocks removed
	 */
	public static Stack<String> removeBlock(Stack<String> tempStack) {

		while (!(tempStack.peek().equals("{"))) {

			if (tempStack.peek().equals("}")) {
				tempStack.pop();
				tempStack = removeBlock(tempStack);
			}
			tempStack.pop();

		}

		return tempStack;

	}

}
