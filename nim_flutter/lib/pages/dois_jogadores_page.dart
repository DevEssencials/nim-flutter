import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/widgets/customer/customer_game_page.dart';
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
    super.key,
  });

  @override
  State<DoisJogadoresPage> createState() => _DoisJogadoresPageState();
}

class _DoisJogadoresPageState extends State<DoisJogadoresPage> {
  late JogoMultPlayer game;
  bool isPlayer1 = true;
  int palitosRestantes = 0;
  bool ispossible = true;

  @override
  void initState() {
    super.initState();
    game = JogoMultPlayer(
      maxJogada: widget.qntdMaxRetirar,
      quantidadeNoJogo: widget.qntdPalitoJogo,
      namePlayer1: widget.player1,
      namePlayer2: widget.player2,
    );
    palitosRestantes = widget.qntdPalitoJogo;
  }

  void trocarJogador() {
    setState(() {
      isPlayer1 = !isPlayer1;
    });
  }

  void retirarPalitos(int jogada) {
    setState(() {
      if(game.verificarJogada(jogada)){
        game.fazerJogada(jogada);
        palitosRestantes -= jogada;
        if (game.isGameOver()) {
          someoneWins(isPlayer1 ? widget.player2 : widget.player1);
        } else {
          trocarJogador();
        }
      }else{
        ispossible = false;
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarStyle("Não foi possível fazer jogada! Verifique sua jogada e tente novamente")
        );
      }
    });
  }



  void someoneWins(String nameWiner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Fim de Jogo'),
   content: Text(
  (nameWiner == "Computador") 

      ? "O computador venceu"
      : "Parabéns $nameWiner, você venceu!!!" ,
      
      
),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Voltar ao início"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: NimGame(
        jogarComp: null,
        isComp: false,
        jogada: ispossible,
        jogar: retirarPalitos,
        qntJogo: palitosRestantes,
        currentPlayer: isPlayer1 ? widget.player1 : widget.player2,
        qntRetirar: widget.qntdMaxRetirar,
      ),
    );
  }
}
