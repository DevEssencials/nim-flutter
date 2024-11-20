import 'dart:convert';

import 'package:http/http.dart' as http;

class Client {
  

  Future<void> getScore() async{
    final url = Uri.parse('https://gabrielsk8.pythonanywhere.com/score/list');
    var response = await http.get(url);
    if(response.statusCode == 200){
      final score = jsonDecode(response.body);
      print('Score: $score');
    }
  }
}