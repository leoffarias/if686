package trabalho12;

public class Trabalho12 implements Runnable {
	
	private int x1, x2, y, z;
	private int[][] matriz1, matriz2;	
	private static int[][] resultado;
	
	public Trabalho12(int x1, int x2, int y, int z, 
			int[][] matriz1, int[][] matriz2) {
		this.x1 = x1;
		this.x2 = x2;
		this.y = y;
		this.z = z;
		this.matriz1 = matriz1;
		this.matriz2 = matriz2;
	}
	
	
	public void run() {	
		
		int aux;
		
	    for (int i = this.x1; i < this.x2; i++){  
	        for (int j = 0; j < this.z; j++){  
	            aux = 0;  
	            for (int h = 0; h < this.y; h++) {  
	                aux = aux + (this.matriz1[i][h] * this.matriz2[h][j]);  
	            }  
	            Trabalho12.resultado[i][j] = aux; 
	        }
	    } 
		
	}
	
	public static void main(String args[]) {
		
		long tStart = System.currentTimeMillis();
	
		int x = 100000; // x pode ser 10, 100, 1000, 10000 e 100000

		int y = 2, z = 3; // valores de y e z aleatorios
		
		// matriz1 de teste criada aleatoriamente (somando i com j) de tamanho x por y
		int[][] matriz1 = new int[x][y];
		for (int i = 0; i < x; i++){
			for (int j = 0; j < y; j++){
				matriz1[i][j] = i+j;
			}
		}
		
		int[][] matriz2 = {{1,2,3}, {4,5,6}}; // escolhida aleatoriamente de acordo com y e z
				
		int n = 16; // n pode ser 1, 2, 3, 4, 8 e 16.

		resultado = new int[x][z];
		
		Thread[] threads = new Thread[n]; 

		for (double i = 0; i < n; i ++){
			int x1 = (int) ((i/n)*x);
			int x2 =  (int) (((i+1)/n)*x);
			
			threads[(int) i] = (new Thread(new Trabalho12(x1, x2, y, z, matriz1, matriz2)));
			
			threads[(int) i].start();	
		}
		
		for (int i = 0; i < n; i ++){
			try {
				threads[i].join();	
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		/* para queira imprimir a matriz para checar:
	    for (int i = 0; i < x; i++){  
	        for (int j = 0; j < z; j++){  
	            for (int h = 0; h < y; h++ ) {  
	            }  
	            System.out.print(resultado[i][j] + " ");
	        }
            System.out.println("");
	    } 
	    */
	    
	    long tEnd = System.currentTimeMillis();
		long tTotal = tEnd - tStart;
		 
		System.out.println("Tempo total em ms: " + tTotal);
		
	}
	

/*
 *    TABELA: 
 *    X           N=1      N=2      N=3      N=4      N=8      N=16
 *    10          0ms      1ms      0ms      1ms      3ms      Como dividimos as threads de acordo com X, esse resultado nao existe
 *    100         0ms      0ms      1ms      1ms      0ms      3ms 
 *    1000        0ms      1ms      1ms      1ms      2ms      5ms 
 *    10000       4ms      5ms      5ms      6ms      6ms      7ms 
 *    100000      24ms     36ms     38ms     23ms     25ms     23ms 
 *    
 *    Comentario: Ao aumentar o valor de x o tempo tambem aumentou como esperado. Com relacao a n, se ha muitas
 *    threads para pouco processamento, o desepenho do programa cai, aumentando o tempo necessario para execucao.
 *    Porem, foi possivel perceber que em determinados casos o aumento de threads colaborou com o processamento,
 *    diminuindo o tempo necessario para o programa rodar, o que fica mais visivel quando x = 100000.
 *    
 */
	
}

