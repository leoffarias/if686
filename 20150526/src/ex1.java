
	public class ex1 implements Runnable {
		
		private long init;
		private long final2;
		
		   public ex1(long in, long fim) {
			   
			   this.init = in;
			   this.final2 = fim;
		       }
		       
				 
		   public void run() {
			  for (long i = this.init; i < this.final2; i++) {
				  System.out.println(i);
			  }
		   }
		   
			 public static void main(String args[]) {

				 
				 Thread a = new Thread (new ex1(0, 500000000));
				 a.start();
				 try {
					a.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread b = new Thread (new ex1(0, 500000000));
				 b.start();
				 try {
					b.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread c = new Thread (new ex1(0, 500000000));
				 c.start();
				 try {
					c.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread d = new Thread (new ex1(0, 500000000));
				 d.start();
				 try {
					d.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
							 

				 }
		}
	
	


