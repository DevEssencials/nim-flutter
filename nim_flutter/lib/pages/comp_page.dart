import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
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
    if(gameSinglePlayer.verificarJogada(jogada)){
      gameSinglePlayer.fazerJogada(jogada);
      palitosRestantes -= jogada;
    } else{
      trocarParaComputador();
      int jComp = gameSinglePlayer.jogarComp();
      palitosRestantes -= jComp;
    }
  }

  void trocarParaComputador(){
    isPessoa = !isPessoa;
  }






  @override
  Widget build(BuildContext context) {
    return NimGame(
      currentPlayer: (isPessoa) ? widget.nomeJogador: "Computador",
      jogar: fazerJogada,
      qntJogo: palitosRestantes,
      qntRetirar: widget.qntdMaxRetirar,
    );
  }
}