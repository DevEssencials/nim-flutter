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
  bool isPlayer1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: NimGame(
        qntJogo: widget.qntdPalitoJogo, 
        currentPlayer: (isPlayer1)?widget.player1:widget.player2, 
        qntRetirar: 10,),
    );
  }
}