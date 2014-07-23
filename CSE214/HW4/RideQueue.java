/**
 * This class is priority queue for an
 * array of visitor objects. The name of the ride,
 * its capacity, and front and rear pointers are
 * stored.
 * 
 * 
 * @author Ashikul Alam
 * ID: 108221262
 * Recitation: 03
 * Homework #4 for CSE 214, Fall 2013
 * October 20, 2013
 */




import java.util.Arrays;

 
public class RideQueue{
	private String name;
	private int capacity;
	private VisitorInfo[] data;
	private int front;
	private int rear;
	
	
	/**
	 * Default Constructor for RideQueue 
	 */
	public RideQueue(){
		front = -1;
		rear = -1;
		capacity = 10;  //DEFAULT 10 CAPACITY
		data = new VisitorInfo[10];
		name = "";
	}
	
	
	/**Constructor for RideQueue with input parameters
	 * @param name
	 * @param capacity
	 */
	public RideQueue(String name, int capacity) {
		front = -1;
		rear = -1;
		this.capacity = capacity;
		data = new VisitorInfo[capacity];
		this.name = name;
	}
	
	/**Pops the front the queue
	 * @return VisitorInfo
	 * @throws EmptyQueueException
	 */
	public VisitorInfo dequeue() throws EmptyQueueException{
		VisitorInfo answer;
		if (front == -1) // isEmpty()
			throw new EmptyQueueException("Ride is empty.");

		answer = data[front];
		data[front] = null;
		if (front == rear) {
		front = -1; rear = -1;
			}
		
		else front = (front+1)%capacity;
		return answer;
	}
 
	/**Pushes a visitorInfo object and sorts them
	 * @param enqueueMe visitorInfo object
	 * @throws FullQueueException If RideQueue is full
	 */
	public void enqueue(VisitorInfo enqueueMe) throws FullQueueException{
		
		if ((rear+1)%capacity == front)
			throw new FullQueueException("Ride is full.");
		
		if (front == -1) { // isEmpty()
			front = 0; rear = 0;
		}
		else rear = (rear+1)%capacity;
				data[rear] = enqueueMe;
				
		
		//sorting algorithm		
		int i = rear;
		int j = 0;
		VisitorInfo temp;
		while (i!=front){
			j = (i+(capacity-1))%capacity;
			if( data[i].getStatus()>data[j].getStatus() ){
				temp = data[j];
				data[j] = data[i];
				data [i] = temp;
			} 
			else {
				break;}
			i = j;
		}
			

	}
 
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString(){
		if (front == -1)
			try {
				throw new EmptyQueueException("Ride " + this.name +" is empty.");
			} catch (EmptyQueueException e) {
				 
				return "null";
			}
		

		String output = name + ": ";
		int i = front;
		while (true){
			output += data[i].getName() + "; ";
			if(i==rear){
				break;
			}
			i=(++i)%(capacity);
		}
		return output;
	}


	/**Check if the queue is empty
	 * @return boolean
	 */
	public boolean isEmpty(){
		return (front == -1);
	}
	
	 
	/**Access the size of the queue
	 * @return int size
	 */
	public int size(){
	 
		int counter = 0;
		for(int i = 0; i < capacity; i++){
 			
	        if(data[i] != null){
	        	counter++;
	        }
		}
		return counter;
	}
	
	
	/**Accessor for the RideQueue name
	 * @return String name
	 */
	public String getName(){
		 return this.name;
	 }
	
	/**Accessor for the RideQueue capacity
	 * @return int capacity
	 */
	public int getCapacity(){
		 return this.capacity;
	 }
	
	/**Get a one line string representation of all the vistor's
	 * status' in string
	 * @return String
	 */
	public String getVisitorStatus(){
		
		int numFastPasses= 0;
		int numRegularTickets = 0;
		for(int i = 0; i < capacity; i++){
 			
	        if(data[i] != null){
	        	if (data[i].getStatus()==1)
	        		numRegularTickets++;
	        	if (data[i].getStatus()==2)
	        		numFastPasses++;
	        }	 
	   }
		return " (" + numRegularTickets + " regular, " +
					numFastPasses + " fast-pass)";
	
	}
	
/**Get a one line string representation of all the vistors
 * and how many have fast-passes and regular tickets
 * @return String
 */
public String getVisitorWaiting(){
		
	
	 	@SuppressWarnings("unused")
		int counter = 0;
	 	String output = "";
	 	output += "Visitors waiting on " + this.name + ":" + "\n";
		for(int i = 0; i < capacity; i++){
 			
	        if(data[i] != null){
	        	counter++;
	        	output += i+1 + "-" + data[i].getName() + " (" +
	        			data[i].getStatusText() + ") ";
	        }	 
	   }
		return output;
	 }
	
	
	
	
	/**Mutator for RideQueue's name
	 * @param name
	 */
	public void setName(String name) {
		 this.name = name;
	}

	//equals methods checks name and data inside array
	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RideQueue other = (RideQueue) obj;
		if (!Arrays.equals(data, other.data))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	
}
