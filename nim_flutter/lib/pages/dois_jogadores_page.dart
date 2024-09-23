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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //inserir os nomes dos jogadores - aplicar a regra de não ter dois jogadores com mesmo nome
      

      // gridbuilder com base nas jogadas de cada usuário

      // dropdown button regulado com o max de palitos pra retirar estipulado no início do app 

      
    );
  }
}