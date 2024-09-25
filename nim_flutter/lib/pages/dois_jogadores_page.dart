import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/widgets/nim_game.dart';

class DoisJogadoresPage extends StatefulWidget {
  final int qntdMaxRetirar;
  final int qntdPalitoJogo;
  final String player1;
  final String player2;
  const DoisJogadoresPage({
    required this.player1,
    required this.player2,
    required this.qntdMaxRetirar,
    required this.qntdPalitoJogo,
    super.key});

  @override
  State<DoisJogadoresPage> createState() => _DoisJogadoresPageState();
}

class _DoisJogadoresPageState extends State<DoisJogadoresPage> {
  late JogoMultPlayer game;
  String? currentPlayer;
  String? otherPlayer;  

  void trocarJogador(){
    if(isPlayer1){
      currentPlayer = widget.player1;
      otherPlayer = widget.player2;
    }else{
      currentPlayer = widget.player2;
      otherPlayer = widget.player1;
    }
  }

  //começo do jogo
  @override
  void initState() {
    super.initState();
    game = JogoMultPlayer(
      maxJogada: widget.qntdMaxRetirar, 
      quantidadeNoJogo: widget.qntdPalitoJogo, 
      namePlayer1: widget.player1, 
      namePlayer2: widget.player2
    );
  }

  //Jogada - verificar se alguem ganhou em cada jogada
  void retirarPalitos(int jogada){
    setState(() {
      game.fazerJogada(jogada);
      isPlayer1 = !isPlayer1;
      if (game.isGameOver()) {
        someoneWins(otherPlayer!);
      } 
    });
  }

  //Mostrar vencedor quando alguem vencer
  void someoneWins(String nameWiner){
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: const Text('Fim de Jogo'),
        content: Text('Parabéns $nameWiner, você venceu!!!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Voltar ao início"),
          ),
        ],
      )
    );
  }
  bool isPlayer1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: NimGame(
        jogar: () => retirarPalitos(2),
        qntJogo: widget.qntdPalitoJogo, 
        currentPlayer: (isPlayer1)?widget.player1:widget.player2, 
        qntRetirar: 10,),
    );
  }
}