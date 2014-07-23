 /**
 * This class provides a menu to take user commands and manipulate a
 * <CODE>FastPassHandler</CODE> object.
 * 
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */

import java.util.Scanner;
public class ThemePark
{
   @SuppressWarnings("resource")
public static void main(String[] args)
    {
	   Scanner input = new Scanner(System.in);
       FastPassHandler fph = new FastPassHandler();
       
       char option = ' ';
       String rideName;
       String visitorName;
       int rideCapacity = 0;
       
       
       while(true)
       {
           printMenu();
           System.out.print("\nChoice>: ");
           option = input.next().trim().charAt(0);
  
           switch(option)
           {
               // A - Add a ride
           	case 'a':
   			case 'A':
   					Scanner input1 = new Scanner(System.in);
            	   System.out.print("What's the ride name?> ");
            	   rideName = input1.nextLine();
            	   System.out.print("What's the capacity?> ");
            	   rideCapacity = input1.nextInt();
            	   fph.createRide(rideName, rideCapacity);
            	   System.out.println("Ride added! ");
                   break;
               // F - Get a fast-pass    
           	case 'f':
   			case 'F':
   					Scanner input2 = new Scanner(System.in);
            	   System.out.println("What's the visitor's name?> ");
            	   visitorName = input2.nextLine();
            	   System.out.println("What ride?> ");
            	   rideName = input2.nextLine(); 
			try {
				fph.getFastPass(visitorName, rideName);
				System.out.println("Fast-pass given!");
			} catch (IllegalArgumentException e) {
				System.out.println("Ride does not exist");
			} catch (AlreadyHasFastPassException e) {
				System.out.println(visitorName + " already has a ticket!");
			} catch (FullQueueException e) {
				System.out.println("Ride full!");
				fph.getVisitorInfo(visitorName).setStatus(0);
			}
                   break;
               
               // L - Print the list of visitors    
           	case 'l':
   			case 'L':
 
   				fph.printVisitors();
                    break;
                    
              // P - Print the list of rides  
           	case 'p':
   			case 'P':
   			 
   				fph.printRides();
                    break;
               
               // R - Regular Ride
           	case 'r':
   			case 'R':
   				Scanner input3 = new Scanner(System.in);
            	   System.out.print("What's the visitor's name?> ");
            	   visitorName = input3.nextLine();
            	   System.out.print("What ride?> ");
            	   rideName = input3.nextLine(); 
			try {
				fph.getRegularTicket(visitorName, rideName);
				System.out.println("Regular Ticket given!");
			} catch (IllegalArgumentException e) {
				System.out.println("Ride does not exist");
			} catch (AlreadyHasTicketException e) {
				System.out.println(visitorName + " already has a ticket!");
			} catch (FullQueueException e) {
				System.out.println("Ride full!");
				fph.getVisitorInfo(visitorName).setStatus(0);
			}
                     
                    break;
               //T - Take ride  
           	case 't':
   			case 'T':
   				Scanner input4 = new Scanner(System.in);
            	   System.out.print("What's the ride name?> ");
            	   rideName = input4.nextLine();
            	   fph.getRideQueue(rideName).getCapacity();
            	   int number = (int) (Math.random() * fph.getRideQueue(rideName).getCapacity()+1);
			try {
				fph.allowVisitorsToTakeRide(rideName, number);
			} catch (IllegalArgumentException e) {
				System.out.println("Ride does not exist");
			} catch (EmptyQueueException e) {
				System.out.println("Ride empty!");
			} catch (ArithmeticException e) {
				System.out.println("Not enough visitors to take a ride!");
			}
                   
                    break;
               
               // V - Print the list of visitors for given ride 
           	case 'v':
   			case 'V':
   				Scanner input5 = new Scanner(System.in);
            	   System.out.print("What's the ride name?> ");
            	   rideName = input5.nextLine();
            	   System.out.print(fph.getRideQueue(rideName).getVisitorWaiting());
            	   System.out.println("");
            	   break;
             
           	case 'q':
   			case 'Q':
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
    
    
    /**
     * Menu for the user interface. 
     */
    public static void printMenu()
       {           
           // 8 menu items
    	   System.out.println("");
           System.out.println("A) Add a ride.");
           System.out.println("F) Get a fast-pass.");
           System.out.println("L) Print the list of visitors.");
           System.out.println("P) Print the list of rides.");
           System.out.println("R) Regular Ride.");
           System.out.println("T) Take ride.");
           System.out.println("V) Print the list of visitors for given ride.");
           System.out.println("Q) Quit program.");
           
        }
    
 
           
           
        
}

