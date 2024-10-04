import 'package:flutter/material.dart';
import 'package:nim_flutter/localData/service_local_data.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final ServiceLocalData service = ServiceLocalData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking de Jogadores"),
      ),
      body: FutureBuilder<List<MapEntry<String, int>>>(
        future: service.getRanking(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar o ranking")); 
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum jogador registrado")); 
          }

          final ranking = snapshot.data!;

          return ListView.builder(
            itemCount: ranking.length,
            itemBuilder: (context, index) {
              final jogador = ranking[index];

              return ListTile(
                leading: Text("#${index + 1}"), 
                title: Text(jogador.key),       
                trailing: Text("${jogador.value} vitórias"), 
              );
            },
          );
        },
      ),
    );
  }
}
