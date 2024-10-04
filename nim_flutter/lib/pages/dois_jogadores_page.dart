import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/widgets/customer/customer_game_page.dart';
import 'package:nim_flutter/widgets/nim_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    iniciarNovoJogo();//separando o init state do inicio do jogo pra poder reiniciar
  }

  void iniciarNovoJogo() {
    setState(() {
      game = JogoMultPlayer(
        maxJogada: widget.qntdMaxRetirar,
        quantidadeNoJogo: widget.qntdPalitoJogo,
        namePlayer1: widget.player1,
        namePlayer2: widget.player2,
      );
      palitosRestantes = widget.qntdPalitoJogo;
      isPlayer1 = true;
    });
  }

  void trocarJogador() {
    setState(() {
      isPlayer1 = !isPlayer1;
    });
  }

  Future<void> salvarVitoria(String playerName) async { //metodo pra salvar nome de quem venceu e registrar 1 ponto
    final prefs = await SharedPreferences.getInstance();
    int vitorias = prefs.getInt(playerName) ?? 0; // pegando da instancia 
    await prefs.setInt(playerName, vitorias + 1); // salva o nome do jogador e pega 
  }

  void retirarPalitos(int jogada) {
    setState(() {
      if (game.verificarJogada(jogada)) {
        game.fazerJogada(jogada);
        palitosRestantes -= jogada;
        if (game.isGameOver()) {
          someoneWins(isPlayer1 ? widget.player1 : widget.player2);
        } else {
          trocarJogador();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarStyle("Não foi possível fazer jogada! Verifique sua jogada e tente novamente"),
        );
      }
    });
  }

  void someoneWins(String nameWiner) {
    salvarVitoria(nameWiner); // salva o nome de quem ganhou 

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Fim de Jogo'),
        content: Text("Parabéns $nameWiner, você venceu!!!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Voltar ao início"),
          ),
          TextButton( // reiniciar o jogo
            onPressed: () {
              Navigator.of(context).pop(); 
              iniciarNovoJogo(); 
            },
            child: const Text("Reiniciar Jogo"),
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