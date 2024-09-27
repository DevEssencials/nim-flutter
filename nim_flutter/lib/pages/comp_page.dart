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
          Future.delayed(const Duration(seconds: 2), () {
          jogarComp();
        });
        }
      } else{
        ispossible = false;
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarStyle("Não foi possível fazer jogada! Verifique sua jogada e tente novamente"),
          
        );
      }
    });
  }

  void jogarComp() async{
    setState(() {
    // Mostra o SnackBar com a mensagem "Espere o computador fazer a jogada..." e um CircularProgressIndicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Text('Espere o computador fazer a jogada...'),
            SizedBox(width: 10),
            CircularProgressIndicator(),
          ],
        ),
        duration: Duration(seconds: 2), // Duração até o próximo passo
      ),
    );
  });
  await Future.delayed(const Duration(seconds: 2));
    setState(()  {
        int jComp = gameSinglePlayer.jogarComp();
        gameSinglePlayer.fazerJogada(jComp);
        palitosRestantes -= jComp;

      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Computador retirou $jComp palito(s).'),
        duration: const Duration(seconds: 2),
      ),
    );
        if(gameSinglePlayer.isGameOver()){
          alguemVenceu(widget.nomeJogador);
        }else{
          const SnackBar(
        content: Text('Sua vez'),
        duration:  Duration(seconds: 1),
      );
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
      currentPlayer: isPessoa ? widget.nomeJogador : "Computador",
      jogar: fazerJogada,
      qntJogo: palitosRestantes,
      qntRetirar: widget.qntdMaxRetirar,
      jogada: ispossible,
    );
  }
}