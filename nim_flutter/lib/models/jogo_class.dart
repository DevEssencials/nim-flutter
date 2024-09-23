
class JogoClass {
  final int maxJogada;
  int quantidadeNoJogo;
  final int jogada;

  JogoClass({
    required this.maxJogada,
    required this.quantidadeNoJogo,
    required this.jogada,
  });
  int? fazerJogada(){
    if(verificarJogada(jogada))return quantidadeNoJogo-=jogada;
    return null;
  }
  bool verificarJogada(jogada){
    return jogada <= maxJogada && jogada <= quantidadeNoJogo;
  }
}

class JogoMultPlayer extends JogoClass{
  final String namePlayer1;
  final String namePlayer2;
  JogoMultPlayer({
    required super.maxJogada, 
    required super.quantidadeNoJogo, 
    required super.jogada, 
    required this.namePlayer1, 
    required this.namePlayer2});


  bool verificarNome(String n1, String n2){
    return n1!=n2;
  }
}