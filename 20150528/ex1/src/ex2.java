	public class ex2 implements Runnable {
		
		public void run() {
		 long x = 3;
		 long n = 1000;
		 long fin = (n/x);
		 long fin2 = (n/x);
		 long ini = 1;
		 
		 for (long i = 0; i < x; i++) {
			 Thread a = new Thread (new ex1(ini, fin));
			 a.start();
			 long aux = fin;
			 fin+=fin2;
			 ini = aux;
		 }
		}
		
	}