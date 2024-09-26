import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/widgets/nim_game.dart';

class DoisJogadoresPage extends StatefulWidget {
  final int qntdMaxRetirar;
  final int qntdPalitoJogo;
  final String player1;
  final String player2;
  final bool isVsComputer;

  const DoisJogadoresPage({
    required this.player1,
    required this.player2,
    required this.qntdMaxRetirar,
    required this.qntdPalitoJogo,
    this.isVsComputer = false,
    super.key,
  });

  @override
  State<DoisJogadoresPage> createState() => _DoisJogadoresPageState();
}

class _DoisJogadoresPageState extends State<DoisJogadoresPage> {
  late JogoMultPlayer game;
  bool isPlayer1 = true;
  int palitosRestantes = 0;

  @override
  void initState() {
    super.initState();
    game = JogoMultPlayer(
      maxJogada: widget.qntdMaxRetirar,
      quantidadeNoJogo: widget.qntdPalitoJogo,
      namePlayer1: widget.player1,
      namePlayer2: widget.isVsComputer ? "Computador" : widget.player2,
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
      game.fazerJogada(jogada);
      palitosRestantes -= jogada;
      if (game.isGameOver()) {
        someoneWins(isPlayer1 ? widget.player2 : widget.player1);
      } else {
        trocarJogador();
        if (widget.isVsComputer && !isPlayer1) {
          jogarComputador();
        }
      }
    });
  }

  void jogarComputador() {
    final random = Random();
    final jogada = random.nextInt(widget.qntdMaxRetirar) + 1;
    retirarPalitos(jogada);
  }

  void someoneWins(String nameWiner) {
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: NimGame(
        jogar: retirarPalitos,
        qntJogo: palitosRestantes,
        currentPlayer: isPlayer1 ? widget.player1 : widget.player2,
        qntRetirar: widget.qntdMaxRetirar,
      ),
    );
  }
}
