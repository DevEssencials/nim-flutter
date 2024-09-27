import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/widgets/customer/customer_game_page.dart';
import 'package:nim_flutter/widgets/nim_game.dart';

class CompPage extends StatefulWidget {
  final int qntdMaxRetirar;
  final int qntdPalitoJogo;
  final String nomeJogador;



  const CompPage({
    required this.nomeJogador,
    required this.qntdMaxRetirar,
    required this.qntdPalitoJogo,
    super.key,
  });

  @override
  State<CompPage> createState() => _CompPageState();
}

class _CompPageState extends State<CompPage> {
  late JogoComputador gameSinglePlayer;
  bool isPessoa = true;
  int palitosRestantes = 0;
  bool ispossible = true;

  @override
  void initState(){
    super.initState();
    gameSinglePlayer = JogoComputador(
      nomeJogador: widget.nomeJogador,
      maxJogada: widget.qntdMaxRetirar, 
      quantidadeNoJogo: widget.qntdPalitoJogo,
    );
    palitosRestantes = widget.qntdPalitoJogo;
  }

  //Jogar computador
  void fazerJogada(int jogada){
    setState(() {
      if(gameSinglePlayer.verificarJogada(jogada)){
        ispossible = true;
        gameSinglePlayer.fazerJogada(jogada);
        palitosRestantes -= jogada;
        if(gameSinglePlayer.isGameOver()){
          alguemVenceu("Computador");
        } else {
          isPessoa = !isPessoa;
        }
      } else{
        ispossible = false;
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarStyle("Não foi possível fazer jogada! Verifique sua jogada e tente novamente")
        );
      }
    });
  }

  void jogarComp(){
    setState(() {
      ispossible = true;
        int jComp = gameSinglePlayer.jogarComp();
        gameSinglePlayer.fazerJogada(jComp);
        palitosRestantes -= jComp;
        if(gameSinglePlayer.isGameOver()){
          alguemVenceu(widget.nomeJogador);
        }else{
          isPessoa = !isPessoa;
        }
    });
  }

  

  void alguemVenceu(String nameWiner) {
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
    return NimGame(
      jogarComp: jogarComp,
      isComp: !isPessoa,
      currentPlayer: isPessoa ? widget.nomeJogador : "Computador",
      jogar: fazerJogada,
      qntJogo: palitosRestantes,
      qntRetirar: widget.qntdMaxRetirar,
      jogada: ispossible,
    );
  }
}