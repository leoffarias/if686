public class nthreadsmod2 implements Runnable {

	private long fim;
	private long nt;
	static long contador = 0;

	public nthreadsmod2(long nt, long fim) {
		this.fim = fim;
		this.nt = nt;
	}


	public void run() {

		for (long i = nthreadsmod2.contador; i <= this.fim; i++) {
			System.out.println("Thread n "+this.nt+" - contador: "+i);
			nthreadsmod2.contador = i;
		}
	}

	public static void main(String args[]) throws InterruptedException {

		nthreadsmod2.contador = 0;
		int n = 10;
		long x = 1000;
		
		Thread[] threads = new Thread[n];

		for (int i = 0; i < n; i++) {
			threads[i] = new Thread (new nthreads(i, x));
			threads[i].start();
			Thread.sleep(1);
		}
		
		for (int i = 0; i < n; i++) { 
			threads[i].join();
		}


	}
}