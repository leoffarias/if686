import java.util.ArrayList; 


	public class ex1 implements Runnable {
		

		private long fim;
		private long inicio;
		private static ArrayList<Long> resposta = new ArrayList<Long>();
	
		
		   public ex1(long inicio, long fim) {
			   this.fim = fim;
			   this.inicio = inicio;
		       }
		       
				 
		   public void run() {

			  for (long i = this.inicio; i < this.fim; i++) {

				  boolean primo = true;
				  
				  for(long o = 1; o < i; o++){
			            if((i % o==0) && (o != 1) && (i != o)){
			                primo = false;
			            }
			        }
				  
				  if (primo) {
					  
					  resposta.add(i);
					  
					
				  }
				  
			  }
		   }
		   
			 public static void main(String args[]) throws InterruptedException {
				 
				 /*
				  Thread a = new Thread (new ex2());
					 a.start();
					 a.join();
				  */
				 
				 long x = 3;
				 long n = 1000;
				 long fin = (n/x);
				 long fin2 = (n/x);
				 long ini = 1;
				 
				 for (long i = 0; i < x; i++) {
					 Thread a = new Thread (new ex1(ini, fin));
					 a.start();
					 a.join();
					 long aux = fin;
					 fin+=fin2;
					 ini = aux;
				 }
				 
				
				 
				 for (int i = 0; i < resposta.size(); i++) {
				     System.out.println(resposta.get(i));
				}

							 

				 }
		}
	
	


