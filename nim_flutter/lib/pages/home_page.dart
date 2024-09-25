import 'package:flutter/material.dart';
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
  final TextEditingController _qntMaxRController = TextEditingController();
  final TextEditingController _qntMaxPController = TextEditingController();

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

  void inserirNomesJogadores() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKeyNomes = GlobalKey<FormState>();
        final _p1Controller = TextEditingController();
        final _p2Controller = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.pink[100],
          content: SizedBox(
            height: 180,
            child: Form(
              key: _formKeyNomes,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Insira o nome do jogadores"),
                TextFormField(
                  controller: _p1Controller,
                  validator: (value) => isNotEmpty(value),
                ),
                TextFormField(
                  controller: _p2Controller,
                  validator: (value) => combineValidator([
                    () => isNotEmpty(value),
                    () => validarNomes(_p1Controller.text, _p2Controller.text)
                  ]),
                ),
                const SizedBox(height: 9,),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_p1Controller.text != _p2Controller.text) {
                        Navigator.of(context).pop(); // Fecha o AlertDialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DoisJogadoresPage(
                              player1: _p1Controller.text,
                              player2: _p2Controller.text,
                              qntdMaxRetirar: int.parse(_qntMaxRController.text),
                              qntdPalitoJogo: int.parse(_qntMaxPController.text),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Os nomes dos jogadores não podem ser iguais.')),
                        );
                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.pinkAccent),
                  ), 
                  child: const Text(
                    "Iniciar Jogo",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]
                // ... (restante dos campos do formulário)
                
              ),
            ),
          ),
        );
      },
    );
  }


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
                    'https://th.bing.com/th/id/R.01ff082ff740417fd49b0516797922f2?rik=vns3F4pvTXMR8g&riu=http%3a%2f%2fimage.aladin.co.kr%2fCommunity%2fpaper%2f2013%2f0226%2fpimg_718842193830056.jpg&ehk=bbUhM2K6kJ48RlSU%2f%2bjFlUNZr4Mi4A42EhDvNoncE%2bs%3d&risl=&pid=ImgRaw&r=0'
                  ),
                ),
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
                  controller: _qntMaxRController,
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
                  controller: _qntMaxPController,
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
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: 
                            (context) => DoisJogadoresPage(
                              qntdMaxRetirar: int.parse(_qntMaxRController.text), 
                              qntdPalitoJogo: int.parse(_qntMaxPController.text)
                            )
                          )
                        ); */
                        inserirNomesJogadores();
                        
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