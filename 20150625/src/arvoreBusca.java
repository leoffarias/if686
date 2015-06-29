import java.util.Random;

class Node {
	int valor;
	Node esq;
	Node dir;
	
	public Node(int v) {
		this.valor = v;
		this.esq = null;
		this.dir = null;
	}
}

public class arvoreBusca {

	Node raiz;
	
	public arvoreBusca() {
		this.raiz = null;
	}
	
	synchronized void inserir(Node n){
		  if(this.raiz == null){
		   this.raiz = n;
		  }
		  else
		   inserirNo(this.raiz, n);   
		}
	
	synchronized void inserirNo(Node atual, Node n){
		  if(n.valor < atual.valor){
		   if(atual.esq == null){
			   atual.esq = n;
		   }
		   else {
		    inserirNo(atual.esq, n);
		  }
		  }
		  else {
		   if(atual.dir == null){
			   atual.dir = n;
		   }
		   else {
		    inserirNo(atual.dir, n);
		  }
		  }
	}
	
	public void imprimirArv(Node n) {
		if (n != null) {
			System.out.println(n.valor+" ");
		}
			if(n.esq != null) {imprimirArv(n.esq); }
			if(n.dir != null) {imprimirArv(n.dir); }
		
	}
		  

	
	public static void main(String[] args) throws InterruptedException {
		
		arvoreBusca arv = new arvoreBusca();
		
		MyThread r = new MyThread(arv);
		Thread[] td = new Thread[50];
		
		for(int i = 0; i < 50; i++) {
		td[i] = new Thread(r);
		td[i].start();
	}
		for (int i = 0; i < 50; i++) {
			td[i].join();
		}
		
		arv.imprimirArv(arv.raiz);
		System.out.println(arv.raiz.esq.esq.valor);
	}

}

class MyThread implements Runnable {
	
		arvoreBusca arv;
		

	   public MyThread(arvoreBusca arv) {
	       this.arv = arv;
	   }

	   public void run() {
		   for (int i = 0; i < 2000; i++) {
		   Random gerador = new Random();
	       int numero = gerador.nextInt(100000);
		   Node n = new Node(numero); 
		   arv.inserir(n);
		   }
	   }
	}
