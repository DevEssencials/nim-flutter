import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocalData {

  Future<List<MapEntry<String,int>>> getRanking() async {
    final data = await SharedPreferences.getInstance();
    Map<String, int> ranking = {};
    final keys = data.getKeys();
    for(String nome in keys){
      int? pontos = data.getInt(nome) ?? 0;
      ranking[nome] = pontos;
    }
    //ordenando o map do maior pro menor
    List<MapEntry<String,int>> rankingOrdenado = ranking.entries.toList()
      ..sort((a, b)=> b.value.compareTo(a.value));

    return rankingOrdenado;
  }
}