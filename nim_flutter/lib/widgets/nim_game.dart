import 'package:flutter/material.dart';
import 'package:nim_flutter/widgets/customer/format_container.dart';
import 'package:nim_flutter/widgets/customer/grid_delegade.dart';
import 'package:nim_flutter/widgets/customer/text_field_customer.dart';
import 'package:nim_flutter/widgets/customer/text_style_jogo.dart';

class NimGame extends StatelessWidget {
  final int qntJogo;
  final String currentPlayer;
  final int qntRetirar;
  
  const NimGame({super.key, required this.qntJogo, required this.currentPlayer, required this.qntRetirar});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // jogador atual
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    "Jogador atual: ",
                    style: styleText(),
                  ),
      
                  Text(
                    currentPlayer,
                    style: styleText(),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Insira a quantidade pra retirar: ",
                    style: TextStyle(fontSize: 13),
                  ),
      
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            //controller: controller,
                            //decoration: decoration(hint),
                            keyboardType: TextInputType.none, // Desabilita teclado virtual
                            //focusNode: foco,  // Gerencia o foco manualmente
                            //onTap: onTap,
                            validator: (value) {
                              if(value == null || value.isEmpty)return "Valor não pode ser nulo";
                              return null;
                            },
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 50,),
            SizedBox(
              
              height: 400,
              width: 400,
              child: GridView.builder(
                gridDelegate: gridDelegate(), 
                itemBuilder: (context, index) => formaContainer(),
                itemCount: qntJogo,
                shrinkWrap: true,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              "$currentPlayer retirou $qntRetirar do jogo",
              style: styleText(),
            ),
          ],
        ),
      ),
    );
  }
}