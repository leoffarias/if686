package trab13;

public class Fichas {

	public int[][] repositorios; //10 arrays de fichas

	int contador; // RECURSO COMPARTILHADO

	public Fichas() {
		repositorios = new int[10][10000];
		contador = 0;
	}

	public int obterFicha(int[][] rep) {
		
		return 0;
	}


	public static void main(String[] args) {

		Fichas f = new Fichas();

		//Preencher os arrays de fichas:
		//Primeira linha = 0, 10, 20...
		//Segunda linha = 1, 11, 21... Até 99999

		int ficha = 0;
		for (int coluna = 0; coluna < 10000; coluna++) {
			for (int linha = 0; linha < 10; linha++) {
				f.repositorios[linha][coluna] = ficha;
				ficha++;
			}
		}
	}

}

class MyThread implements Runnable {

	@Override
	public void run() {

	}


}
