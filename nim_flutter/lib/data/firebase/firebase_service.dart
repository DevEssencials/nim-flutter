import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nim_flutter/models/user_model.dart';

class  FirebaseService {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  //alterar ranking 
  Future<void> alterarRanking(UserModel user) async {
    try{
      final doc = await firestoreInstance.collection('ranking')
        .orderBy('pontos', descending: true)
        .get();
      //verificando se tem 5 colocados no ranking
      if(doc.docs.length < 5){
        //se não tiver 5 colocados adicionar mais usuário
        await firestoreInstance.collection('ranking').add({
          'nome': user.nome,
          'pontos': user.pontos,
        });
      }else {
        var jogadores = doc.docs;//lista de jogadores
        var ultimaPosicao = jogadores.last;//jogador com menos pontos
        if(ultimaPosicao["pontos"] < user.pontos){
          //deletando o ultimo com menos pontos
          await ultimaPosicao.reference.delete();
          //adicionando novo jogador ao ranking
          await firestoreInstance.collection('ranking').add({
            'nome': user.nome,
            'pontos': user.pontos,
          });
        }
      }
    } catch (e){
      print("Erro no método de alterar o ranking: $e");
    }
    
  }
  Future<void> isPlayerInRanking(UserModel user) async {
    try {
      CollectionReference reference =  firestoreInstance.collection('ranking');
      QuerySnapshot doc = await reference.get();
      bool estaNoRanking = doc.docs.any((doc) => doc['nome'] == user.nome);
      if(estaNoRanking){
        var playerReference = doc.docs.firstWhere((doc) => doc['nome'] == user.nome);
        await playerReference.reference.update({'pontos': user.pontos});
      }else {
        alterarRanking(user);
      }
    } catch (e) {
      // TODO
    print("erro no método de ver se está no ranking: $e");
    }
  }
}

