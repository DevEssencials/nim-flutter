import 'package:nim_flutter/data/firebase/firebase_service.dart';
import 'package:nim_flutter/data/http/http_service.dart';
import 'package:nim_flutter/data/localData/service_local_data.dart';
import 'package:nim_flutter/models/user_model.dart';

class ControllerGame {
  final service = FirebaseService();
  final serviceLocal = ServiceLocalData();
  final client = ClientHttp();

  Future<void> chamarService(UserModel user) async{
    await service.isPlayerInRanking(user);
  }

  Future<void> syncRankingWithFirebase() async {
  List<MapEntry<String, int>> rankingOrdenado = await serviceLocal.getRanking();

  List<MapEntry<String, int>> top5 = rankingOrdenado.take(5).toList();

  for (var entry in top5) {
    final user = UserModel(nome: entry.key, pontos: entry.value);
    await chamarService(user); 
  }
  }

  Future<void> salvarVitoriaApi(UserModel user) async {
    await client.isInScore(user.nome, user.pontos!);
  }
}