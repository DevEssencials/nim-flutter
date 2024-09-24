import 'package:flutter/material.dart';

class DoisJogadoresPage extends StatefulWidget {
  final int qntdMaxRetirar;
  final int qntdPalitoJogo;
  const DoisJogadoresPage({
    required this.qntdMaxRetirar,
    required this.qntdPalitoJogo,
    super.key});

  @override
  State<DoisJogadoresPage> createState() => _DoisJogadoresPageState();
}

class _DoisJogadoresPageState extends State<DoisJogadoresPage> {
  final TextEditingController _p1 = TextEditingController();
  final TextEditingController _p2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //inserir os nomes dos jogadores - aplicar a regra de não ter dois jogadores com mesmo nome
      body: Stack(
        children: [
          AlertDialog(
            title: const Text("Insira os nomes dos Jogadores"),
            content: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(),
                SizedBox( height: 10,),
                TextField(),
              ],
            ),
            actions: [
              TextButton(onPressed: (){}, child: Text("Jogar"))
            ],
          )
        ],
      ),

      // gridbuilder com base nas jogadas de cada usuário

      // dropdown button regulado com o max de palitos pra retirar estipulado no início do app 

      
    );
  }
}