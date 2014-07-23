/**
 * This class manipulates an arraylist of 
 * <CODE>RideQueues</CODE> and <CODE>VisitorInfos</CODE>.
 * 
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */


import java.util.ArrayList;

public class FastPassHandler {
	static ArrayList<VisitorInfo> visitorList = new ArrayList<VisitorInfo>();
	static ArrayList<RideQueue> rideList = new ArrayList<RideQueue>();

	/**Create a new RideQueue with input parameters and put it into rideList
	 * @param rideName
	 * @param rideCapacity
	 */
	public void createRide(String rideName, int rideCapacity) {
		RideQueue tempRide = new RideQueue(rideName, rideCapacity);
		rideList.add(tempRide);

	}

	/**Create a new VisitorInfo with input parameter and put it into visitorList
	 * @param visitorName
	 */
	public void createVisitor(String visitorName) {
		VisitorInfo tempVisitor = new VisitorInfo(visitorName, 0);
		visitorList.add(tempVisitor);
	}

	/**Take input parameters to determine if a visitor can be given
	 * a fast-pass ticket. 
	 * @param visitorName
	 * @param rideName
	 * @throws AlreadyHasFastPassException
	 * @throws FullQueueException
	 * @throws IllegalArgumentException input Ride Name doesn't exist
	 */
	public void getFastPass(String visitorName, String rideName)
			throws AlreadyHasFastPassException, FullQueueException,
			IllegalArgumentException {

		int rideLocation = -1;

		for (RideQueue d : rideList) {

			if (d.getName() != null && d.getName().contains(rideName)) {
				rideLocation = rideList.indexOf(d);
				break;
			}

		}

		if (rideLocation == -1) {
			throw new IllegalArgumentException("Ride name does not exist!");
		}

		for (VisitorInfo d : visitorList) {

			if (d.getName() != null && d.getName().contains(visitorName)) {

				if (d.getStatus() == 2) {
					throw new AlreadyHasFastPassException(
							"Already has fast pass!");
				} else if (d.getStatus() == 1) {
					d.setStatus(2);
					return;
				} else {
					d.setStatus(2);
					rideList.get(rideLocation).enqueue(d);
					return;
				}
			}

		}

		VisitorInfo tempVisitor = new VisitorInfo(visitorName, 2);
		visitorList.add(tempVisitor);
		rideList.get(rideLocation).enqueue(tempVisitor);

	}

	 
	/**Take input parameters to determine if a visitor can be given
	 * a regular ticket. 
	 * @param visitorName
	 * @param rideName
	 * @throws AlreadyHasTicketException
	 * @throws FullQueueException
	 * @throws IllegalArgumentException input Ride Name doesn't exist
	 */
	public void getRegularTicket(String visitorName, String rideName)
			throws AlreadyHasTicketException, FullQueueException,
			IllegalArgumentException {

		int rideLocation = -1;

		for (RideQueue d : rideList) {

			if (d.getName() != null && d.getName().contains(rideName)) {
				rideLocation = rideList.indexOf(d);
				break;
			}

		}

		if (rideLocation == -1) {
			throw new IllegalArgumentException("Ride name does not exist!");
		}

		for (VisitorInfo d : visitorList) {

			if (d.getName() != null && d.getName().contains(visitorName)) {

				if (d.getStatus() != 0) {
					throw new AlreadyHasTicketException(
							"Visitor already has a ticket!");
				} else {
					d.setStatus(1);
					rideList.get(rideLocation).enqueue(d);
					return;
				}
			}

		}

		VisitorInfo tempVisitor = new VisitorInfo(visitorName, 1);
		visitorList.add(tempVisitor);
		rideList.get(rideLocation).enqueue(tempVisitor);

	}

	// ///////////////////////////////////////////////////////////////////////////////////////

	/**Take input parameters to determine if desired RideQueue can be
	 * dequeue various times.
	 * @param rideName
	 * @param numVisitors
	 * @throws IllegalArgumentException input Ride Name doesn't exist
	 * @throws EmptyQueueException
	 * @throws ArithmeticException Illegal number of visitors to take ride
	 */
	public void allowVisitorsToTakeRide(String rideName, int numVisitors)
			throws IllegalArgumentException, EmptyQueueException,
			ArithmeticException {

		@SuppressWarnings("unused")
		boolean rideExists = false;
		int rideLocation = -1;
		@SuppressWarnings("unused")
		int visitorLocation = 0;
		@SuppressWarnings("unused")
		int counter = 0;
		VisitorInfo temp;
		// Check if Ride Name exists

		for (RideQueue d : rideList) {

			if (d.getName() != null && d.getName().contains(rideName)) {
				rideLocation = rideList.indexOf(d);
				break;
			}

		}

		if (rideLocation == -1) {
			throw new IllegalArgumentException("Ride name does not exist!");
		}

		if ((numVisitors < 1)
				|| (numVisitors > rideList.get(rideLocation).size())) {

			throw new ArithmeticException(
					"Invalid number of visitors to take a ride!");
		}

		System.out.println("The following people have taken the ride "
				+ rideList.get(rideLocation).getName());
	 
		for (int i = 1; i <= numVisitors; i++) {

			counter++;
			temp = rideList.get(rideLocation).dequeue();

			System.out.println(i + "- " + temp.getName() + " ("
					+ temp.getStatusText() + ")");

			for (VisitorInfo d : visitorList) {

				if (d.getName() != null && d.getName().contains(temp.getName())) {
					d.setStatus(0);

				}

			}

		}

	}
 
	/**
	 * Prints a list of visitors and their ticket status
	 */
	public void printVisitors() {

		System.out.println("Park Visitors: ");
		int counter = 0;
		for (VisitorInfo d : visitorList) {

			if (d.getName() != null) {
				counter++;
				System.out.println("");  
				System.out.printf("%d-%-10s%-10s", counter, d.getName(),
						d.getStatusText());

			}
		}
		System.out.println("");

	}

	/**
	 * Prints a list of rides, their size, and how many visitors are waiting.
	 */
	public void printRides() {

		System.out.println("Rides: ");
		for (RideQueue d : rideList) {

			if (d != null) {
				System.out.println(d.getName() + "- Capacity: "
						+ d.getCapacity() + " -" + "- Visitors Waiting: "
						+ d.size() + d.getVisitorStatus());

			}
		}

	}

	/**Check if a rideName exists within rideList
	 * @param rideName
	 * @return RideQueue
	 */
	public RideQueue getRideQueue(String rideName) {
		for (RideQueue d : rideList) {

			if (d.getName() != null && d.getName().contains(rideName)) {
				return d;

			}

		}
		return null;
	}

	/**Check if a visitorName exists within visitorList
	 * @param visitorName
	 * @return VisitorInfo
	 */
	public VisitorInfo getVisitorInfo(String visitorName) {
		for (VisitorInfo d : visitorList) {

			if (d.getName() != null && d.getName().contains(visitorName)) {
				return d;

			}

		}
		return null;
	}

}
