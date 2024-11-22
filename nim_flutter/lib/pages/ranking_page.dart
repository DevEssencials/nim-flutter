import 'package:flutter/material.dart';
import 'package:nim_flutter/data/http/http_service.dart';


class RankingPage extends StatefulWidget {
  const RankingPage({super.key,});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final ClientHttp service = ClientHttp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking de Jogadores"),
      ),
      body: FutureBuilder(
        future: service.getScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar o ranking"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum jogador registrado"));
          }

          final ranking = snapshot.data!;

          // Ordena os jogadores por pontos em ordem decrescente.
          ranking.sort((a, b) => b.pontos!.compareTo(a.pontos!));

          return ListView.builder(
            itemCount: ranking.length,
            itemBuilder: (context, index) {
              final jogador = ranking[index];

              return ListTile(
                leading: Text("#${index + 1}"),
                title: Text(jogador.nome),
                trailing: Text(
                  jogador.pontos! > 1
                      ? "${jogador.pontos} vitórias"
                      : "${jogador.pontos} vitória",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

