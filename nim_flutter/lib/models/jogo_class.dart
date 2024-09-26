
import 'dart:math';

class JogoClass {
  final int maxJogada;
  int quantidadeNoJogo;

  JogoClass({
    required this.maxJogada,
    required this.quantidadeNoJogo,
  });

  void fazerJogada(int jogada){
    quantidadeNoJogo-=jogada;
  }

  bool verificarJogada(int jogada){
    return jogada <= maxJogada && jogada <= quantidadeNoJogo;
  }

  

  bool isGameOver() => quantidadeNoJogo<=0;
}


class JogoMultPlayer extends JogoClass{
  String namePlayer1;
  String namePlayer2;
  JogoMultPlayer({
    required super.maxJogada, 
    required super.quantidadeNoJogo, 
    required this.namePlayer1, 
    required this.namePlayer2});




  bool verificarNome(String n1, String n2){
    return n1!=n2;
  }
}

class JogoComputador extends JogoClass{
  final String nomeJogador;
  JogoComputador({required super.maxJogada, required super.quantidadeNoJogo, required this.nomeJogador});

  int jogarComp(){
    int aleatorio = Random().nextInt(min(super.maxJogada, super.quantidadeNoJogo)) + 1;
    return aleatorio;
  }
}