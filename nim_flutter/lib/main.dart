import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nim_flutter/firebase_options.dart';
import 'package:nim_flutter/pages/home_page.dart';

void main()  async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        useMaterial3: true,
      ),
      home: const HomePage(),
      //const NimGame(qntJogo: 33, currentPlayer: 'currentPlayer', qntRetirar: 4),
      debugShowCheckedModeBanner: false,
    );
  }
}
