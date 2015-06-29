public class nthreads implements Runnable {

	private long fim;
	private long nt;

	public nthreads(long nt, long fim) {
		this.fim = fim;
		this.nt = nt;
	}


	public void run() {

		for (long i = 0; i <= this.fim; i++) {
			System.out.println("Thread n "+this.nt+" - contador: "+i);

		}
	}

	public static void main(String args[]) throws InterruptedException {

		long n = 10;
		long x = 10;

		for (int i = 0; i < n; i++) {
			Thread a = new Thread (new nthreads(i, x));
			a.start();
		}


	}
}




