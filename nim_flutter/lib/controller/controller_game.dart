import 'package:nim_flutter/data/firebase/firebase_service.dart';
import 'package:nim_flutter/models/user_model.dart';

class ControllerGame {
  final service = FirebaseService();
  Future<void> chamarService(UserModel user) async{
    await service.isPlayerInRanking(user);
  }
}