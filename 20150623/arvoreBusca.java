
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
	
	public void inserir(Node n){
		  if(this.raiz == null){
		   this.raiz = n;
		  }
		  else
		   inserirNo(this.raiz, n);   
		}
	
	private void inserirNo(Node atual, Node n){
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
		  
	
	public void add(Node atual, Node n) {
		if(atual == null) {
			atual = n;
		}
		else if(atual.valor > n.valor) {
			add(atual.esq, n);
		} else {
			add(atual.dir, n);
		}
	}
	
	
	public static void main(String[] args) {
		
		arvoreBusca arv = new arvoreBusca();
		
		/*colocar threads aqui*/
		Node n = new Node(3); 
		
		arv.inserir(n);

	}

}
