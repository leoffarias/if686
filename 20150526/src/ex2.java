
	public class ex2 implements Runnable {
		
		private long init;
		private long final2;
		
		   public ex2(long in, long fim) {
			   
			   this.init = in;
			   this.final2 = fim;
		       }
		       
				 
		   public void run() {
			  for (long i = this.init; i < this.final2; i++) {
				  //System.out.println(i);
			  }
		   }
		   
			 public static void main(String args[]) {

				 long time1 = System.currentTimeMillis();
				 
				 Thread a = new Thread (new ex2(0, 500000000));
				 a.start();
				 try {
					a.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread b = new Thread (new ex2(500000000, 1000000000));
				 b.start();
				 try {
					b.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread c = new Thread (new ex2(1000000000, 1500000000));
				 c.start();
				 try {
					c.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				} 
				 
				 Thread d = new Thread (new ex2(1500000000, 2000000001));
				 d.start();
				 try {
					d.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				 
				 long time2 = System.currentTimeMillis();
				 System.out.println("tempo total: "+(time2-time1)+" ms");
						 

				 }
		}
	
	


