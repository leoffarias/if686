package trabalho14;

import java.util.Random;
import java.util.Vector;

public class BanheiroSync {

	public boolean comHomem;
	public boolean comMulher;
	public Vector<String> filaHomem;
	public Vector<String> homensDentro;
	public Vector<String> filaMulher;
	public Vector<String> mulheresDentro;
	public long contadorHomem;
	public long contadorMulher;
	
	public BanheiroSync() {
		this.comHomem = false;
		this.comMulher = false;
		this.filaHomem = new Vector<String>();
		this.homensDentro = new Vector<String>();
		this.filaMulher = new Vector<String>();
		this.mulheresDentro = new Vector<String>();
		this.contadorHomem = 0;
		this.contadorMulher = 0;
	}
	
	// Incremento atomico so para imprimir o nome na tela
	public synchronized long incrementaHomem(){
		this.contadorHomem++;
		return this.contadorHomem;
	}
	
	// Incremento atomico so para imprimir o nome na tela
	public synchronized long incrementaMulher(){
		this.contadorMulher++;
		return this.contadorMulher;
	}
	
	/*
	 * Se tiver mulher, o homem não pode entrar, deve esperar. Caso não tenha mulher, o primeiro homem
	 * da fila irá entrar no vetor dos homens que estão dentro do banheiro.
	 */
	public synchronized void entrarHomem(){
		while (this.comMulher){
			try {
				wait();
			} catch (InterruptedException e){}
		}
		this.homensDentro.add(this.filaHomem.get(0));
		this.comHomem = true;
		System.out.println(this.filaHomem.get(0) + " entrou. Tem " + this.homensDentro.size() + " homens dentro.");
		this.filaHomem.remove(0);
	}
	
	// O primeiro homem que entrou é o primeiro a sair, verificando se agora há homens no banheiro
	public synchronized void sairHomem(){
		System.out.println(this.homensDentro.get(0) + " saiu. Tem " + (this.homensDentro.size()-1) + " homens dentro.");
		this.homensDentro.remove(0);
		if(this.homensDentro.isEmpty()){
			this.comHomem = false;
			notifyAll();
		}
	}
	
	/*
	 * Se tiver homem, a mulher não pode entrar, deve esperar. Caso não tenha homem, a primeira mulher
	 * da fila irá entrar no vetor das mulheres que estão dentro do banheiro.
	 */
	public synchronized void entrarMulher(){
		while (this.comHomem){
			try {
				wait();
			} catch (InterruptedException e){}
		}
		this.mulheresDentro.add(this.filaMulher.get(0));
		this.comMulher = true;
		System.out.println(this.filaMulher.get(0) + " entrou. Tem " + this.mulheresDentro.size() + " mulheres dentro.");
		this.filaMulher.remove(0);
	}
	
	// A primeira mulher que entrou é a primeira a sair, verificando se agora há mulheres no banheiro
	public synchronized void sairMulher(){
		System.out.println(this.mulheresDentro.get(0) + " saiu. Tem " + (this.mulheresDentro.size()-1) + " mulheres dentro.");
		this.mulheresDentro.remove(0);
		if(this.mulheresDentro.isEmpty()){
			this.comMulher = false;
			notifyAll();
		}
	}
    
	public static void main(String[] args) {
		
		BanheiroSync banheiro = new BanheiroSync();
						
		// Cria arbitrariamente 50 threads para controlar a entrada/saída de homens e mulheres
		Thread[] threads = new Thread[50]; 
		
		MyThread t = new MyThread(banheiro);
		
		for (int i = 0; i < 50; i ++){															
			threads[i] = (new Thread(t));
			threads[i].start();	
		}
		
		for (int i = 0; i < 50; i ++){
			try {
				threads[i].join();	
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

}

class MyThread implements Runnable {
	
	BanheiroSync banheiro;
	
	MyThread (BanheiroSync banheiro){
		this.banheiro = banheiro;
	}

	public void run() {
		
		Random gerador = new Random();	
		
		// Cria arbitrariamente 50 pessoas querendo entrar/sair do banheiro
		for (int i = 0; i < 50; i++){
			
			boolean quemEntra = gerador.nextBoolean();

			if(quemEntra){
				long nome = banheiro.incrementaHomem();
				banheiro.filaHomem.add("Homem " + nome); // Cria o homem x na fila de homens
				banheiro.entrarHomem();
				try {
					Thread.sleep(10); // Tempo arbitrário para dar para perceber varios homens no banheiro
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				banheiro.sairHomem();
			} else {
				long nome = banheiro.incrementaMulher();
				banheiro.filaMulher.add("Mulher " + nome); // Cria a mulher x na fila de mulheres
				banheiro.entrarMulher();
				try {
					Thread.sleep(10); // Tempo arbitrário para dar para perceber varias mulheres no banheiro
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				banheiro.sairMulher();
			}
		}
	}
	
}


/*
 * A questao satisfaz a exclusao mutua pelo fato de que quando um homem ou mulher entra no banheiro, antes verifica
 * se o banheiro esta ocupado com alguem do sexo oposto atraves do boolean comHomem/comMulher. Se estiver ocupado,
 * ele ou ela ira esperar atraves do wait() ate que a(as) pessoa(as) notifiquem atraves do notifyAll() que sairam
 * do banheiro (o vetor de pessoas dentro do banheiro sera vazio).
 * 
 * Ha ausencia de starvation porque eh usado o esquema de filas para entrar no banheiro e um vetor para pessoas dentro
 * do banheiro. Assim, o primeiro homem/mulher que entrou na fila sempre sera privilegiado para entrar/sair do banheiro. 
 * 
 * */
