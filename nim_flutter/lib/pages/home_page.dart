import 'package:flutter/material.dart';
import 'package:nim_flutter/models/jogo_class.dart';
import 'package:nim_flutter/pages/dois_jogadores_page.dart';
import 'package:nim_flutter/widgets/customer/dropdown_custom.dart';
import 'package:nim_flutter/widgets/customer/text_field_customer.dart';
import 'package:nim_flutter/widgets/utils/validator_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Validator{
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue = "none";
  
  final List<DropdownMenuItem<String>> _mods = [
    const DropdownMenuItem(
      value: 'none',
      child: Text("Escolher Modo"),
    ),
    const DropdownMenuItem(
      value: 'VS',
      child: Text("Modo dois jogadores"),
    ),
    const DropdownMenuItem(
      value: 'computador',
      child: Text("Modo computador"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text("NIM GAME",style: TextStyle(fontWeight: FontWeight.bold),)),
        backgroundColor: const Color.fromARGB(255, 250, 82, 138),
      ),
      backgroundColor: Colors.pink[100],
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                SizedBox(
                  child: Image.network(
                    'https://th.bing.com/th/id/R.01ff082ff740417fd49b0516797922f2?rik=vns3F4pvTXMR8g&riu=http%3a%2f%2fimage.aladin.co.kr%2fCommunity%2fpaper%2f2013%2f0226%2fpimg_718842193830056.jpg&ehk=bbUhM2K6kJ48RlSU%2f%2bjFlUNZr4Mi4A42EhDvNoncE%2bs%3d&risl=&pid=ImgRaw&r=0'),),
                const SizedBox(height: 15.0,),
                const Center(
                  child: Text(
                    "Configurações",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                //escolher modo - 2 jogadores ou jogar contra a máquina 
                // se for dois jogadores pedir o nome dos jogadores
                
                DropdownButtonFormField<String>(
                  validator: (value) => dropdownValidate(value!),
                  decoration: decorationDropdown(dropdownValue!),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.black,),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.pinkAccent,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      
                    });
                  },
                  items: _mods,
                ),
                const SizedBox(height: 15.0,),
                //escolher quantidade de palitos maxima por jogada 3 a 5
                TextFormField(
                  decoration: customTextField("Quantidade maxima de palitos pra retirar(min 3, max 5)"),
                  validator: (value) => combineValidator([
                    () => isNotEmpty(value),
                    () => verificaInteiro(value!),
                    () => maiorLimiteJogada(int.parse(value!)),
                  ]),
                    
                ),
                const SizedBox(height: 15.0,),
                //escolher a quantidade máxima de palitos no jogo 5 a 33
                TextFormField(
                  decoration: customTextField("Quantidade de palitos no Jogo(min 5, max 33)"),
                  validator: (value) => combineValidator([
                    () => isNotEmpty(value),
                    () => verificaInteiro(value!),
                    () => maiorQueOsLimitesPalitosNoJogo(int.parse(value!)),
                  ]),
                ),
                const SizedBox(height: 15.0,),
                //iniciar Jogo
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      if(dropdownValue == 'VS'){
                        
                        
                      } else if(dropdownValue == 'computador'){

                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.pinkAccent),
                  ), 
                  child: const Text(
                    "Jogar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}