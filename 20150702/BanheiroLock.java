package trabalho14;

import java.util.Random;
import java.util.Vector;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class BanheiroLock {

	public boolean comHomem;
	public boolean comMulher;
	public Vector<String> filaHomem;
	public Vector<String> homensDentro;
	public Vector<String> filaMulher;
	public Vector<String> mulheresDentro;
	public long contadorHomem;
	public long contadorMulher;
	public Lock trava;
	public Condition variavelCondicional;
	
	public BanheiroLock() {
		this.comHomem = false;
		this.comMulher = false;
		this.filaHomem = new Vector<String>();
		this.homensDentro = new Vector<String>();
		this.filaMulher = new Vector<String>();
		this.mulheresDentro = new Vector<String>();
		this.contadorHomem = 0;
		this.contadorMulher = 0;
		this.trava = new ReentrantLock();
		this.variavelCondicional = trava.newCondition();
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
	public void entrarHomem(){
		trava.lock();
		try {
			while (this.comMulher){
				try {
					variavelCondicional.await();
				} catch (InterruptedException e) { }
			}
			this.homensDentro.add(this.filaHomem.get(0));
			this.comHomem = true;
			System.out.println(this.filaHomem.get(0) + " entrou. Tem " + this.homensDentro.size() + " homens dentro.");
			this.filaHomem.remove(0);
			variavelCondicional.signalAll();
		} finally{
			// unlock presente no metodo SairHomem
		}
	}
	
	// O primeiro homem que entrou é o primeiro a sair, verificando se agora há homens no banheiro
	public void sairHomem(){
		System.out.println(this.homensDentro.get(0)+ " saiu. Tem " + (this.homensDentro.size()-1) + " homens dentro.");
		this.homensDentro.remove(0);
		if(this.homensDentro.isEmpty()){
			this.comHomem = false;
			trava.unlock();
		}
	}
	
	/*
	 * Se tiver homem, a mulher não pode entrar, deve esperar. Caso não tenha homem, a primeira mulher
	 * da fila irá entrar no vetor das mulheres que estão dentro do banheiro.
	 */
	public void entrarMulher(){
		trava.lock();
		try {
			while (this.comHomem){
				try {
					variavelCondicional.await();
				} catch (InterruptedException e) { }
			}
			this.mulheresDentro.add(this.filaMulher.get(0));
			this.comMulher = true;
			System.out.println(this.filaMulher.get(0) + " entrou. Tem " + this.mulheresDentro.size()+ " mulheres dentro.");
			this.filaMulher.remove(0);
			variavelCondicional.signalAll();
		} finally {
			// unlock presente no metodo SairMulher
		}
	}
	
	// A primeira mulher que entrou é a primeira a sair, verificando se agora há mulheres no banheiro
	public void sairMulher(){
		System.out.println(this.mulheresDentro.get(0)+ " saiu. Tem " + (this.mulheresDentro.size()-1) + " mulheres dentro.");
		this.mulheresDentro.remove(0);
		if(this.mulheresDentro.isEmpty()){
			this.comMulher = false;
			trava.unlock();
		}
	}
    
	public static void main(String[] args) {
		
		BanheiroLock banheiro = new BanheiroLock();
						
		// Cria arbitrariamente 50 threads para controlar a entrada/saída de homens e mulheres
		Thread[] threads = new Thread[50]; 
		
		MyThread2 t = new MyThread2(banheiro);
		
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

class MyThread2 implements Runnable {
	
	BanheiroLock banheiro;
	
	MyThread2 (BanheiroLock banheiro){
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
 * Notamos que demorou muito mais por conta do bloco que fica verificando se o banheiro esta livre (bloco guardado).
 * 
 * A questao satisfaz a exclusao mutua pelo fato de que quando um homem ou mulher entra no banheiro, antes verifica
 * se o banheiro esta ocupado com alguem do sexo oposto atraves do boolean comHomem/comMulher. Se estiver ocupado,
 * ele ou ela ira esperar atraves do while ate poder entrar no banheiro, o que ocorre quando o o vetor de pessoas do 
 * outro sexo dentro do banheiro eh vazio.
 * 
 * Ha ausencia de starvation porque eh usado o esquema de filas para entrar no banheiro e um vetor para pessoas dentro
 * do banheiro. Assim, o primeiro homem/mulher que entrou na fila sempre sera privilegiado para entrar/sair do banheiro. 
 * 
 * */