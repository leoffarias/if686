public class nthreadsmod implements Runnable {

	private long fim;
	private long nt;
	static long contador = 0;

	public nthreadsmod(long nt, long fim) {
		this.fim = fim;
		this.nt = nt;
	}


	public void run() {

		for (long i = nthreadsmod.contador; i <= this.fim; i++) {
			System.out.println("Thread n "+this.nt+" - contador: "+i);
			nthreadsmod.contador = i;

		}
	}

	public static void main(String args[]) throws InterruptedException {

		nthreadsmod.contador = 0;
		long n = 10;
		long x = 1000;

		for (int i = 0; i < n; i++) {
			Thread a = new Thread (new nthreads(i, x));
			a.start();
		}


	}
}




