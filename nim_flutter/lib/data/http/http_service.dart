import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nim_flutter/models/user_model.dart';

class ClientHttp {

  final baseUrl = 'https://gabrielsk8.pythonanywhere.com/score';

  Future<List<dynamic>> get() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list'));
      if(response.statusCode == 200){
        final List<dynamic> lista = jsonDecode(response.body);
        return lista;
      }else{
        print('deu rui no status code: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erro exception: $e');
      return [];
    }
  }

  Future<List<UserModel>> getScore() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      } else {
        print('Erro ao buscar placar: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro: $e');
      return [];
    }
  }

  Future<void> isInScore(String nome, int vitoria) async{
    try {
  final score = await get();
  bool esta = score.any((user) => user['nome'] == nome);
  if(esta){
    final jogador = score.firstWhere((json) => json['nome'] == nome);
    int id = jogador['id'];
    
    atualizarScore(id, vitoria, nome);
  }
  else{
    subirPlacar(nome, vitoria);
  }
} on Exception catch (e) {
  // TODO
  print('Deu erro aqui ó: $e ');
  
}catch (e){
  print('otro exception mano: $e');
}
  }
  

  Future<void> subirPlacar(String nome, int vitorias) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'nome': nome, 'placar': vitorias}),
      );
      if (response.statusCode == 201) {
        print('Placar atualizado com sucesso!');
      } else {
        print('Erro ao subir placar: ${response.body}');
      }
    } catch (e) {
      print('Erro ao subir placar: $e');
    }
  }

  Future<void> atualizarScore(int id, int vitorias, String name) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'nome': name,'placar': vitorias}),
      );
      if (response.statusCode == 200) {
        print('Score atualizado com sucesso!');
      } else {
        print('Erro ao atualizar score: ${response.body}');
      }
    } catch (e) {
      print('Erro ao atualizar score: $e');
    }
  }

  Future<void> delete(int id) async {
    final responseDelete = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (responseDelete.statusCode == 200) {
        print('Jogador com ID $id excluído com sucesso!');
      } else {
        print('Erro ao excluir jogador com ID $id: ${responseDelete.body}');
      }
  }
}


