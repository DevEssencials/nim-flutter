import 'package:flutter/material.dart';
import 'package:nim_flutter/pages/home_page.dart';
import 'package:nim_flutter/widgets/nim_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NimGame(qntJogo: 33, currentPlayer: 'currentPlayer', qntRetirar: 4),
      debugShowCheckedModeBanner: false,
    );
  }
}

