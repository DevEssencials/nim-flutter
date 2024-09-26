import 'package:flutter/material.dart';
import 'package:nim_flutter/pages/comp_page.dart';
import 'package:nim_flutter/pages/dois_jogadores_page.dart';
import 'package:nim_flutter/widgets/customer/alert_single_player_custom.dart';
import 'package:nim_flutter/widgets/customer/dropdown_custom.dart';
import 'package:nim_flutter/widgets/customer/input_decoration_custom.dart';
import 'package:nim_flutter/widgets/customer/text_field_customer.dart';
import 'package:nim_flutter/widgets/utils/validator_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Validator {
  final TextEditingController _qntMaxRController = TextEditingController();
  final TextEditingController _qntMaxPController = TextEditingController();
  final _singlePlayerName = TextEditingController();
  final p1Controller = TextEditingController();
  final p2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? dropdownValue = "none";

  final List<DropdownMenuItem<String>> _mods = [
    const DropdownMenuItem(
      value: 'none',
      child: Text(
        "Escolher Modo",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const DropdownMenuItem(
      value: 'VS',
      child: Text(
        "Modo dois jogadores",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const DropdownMenuItem(
      value: 'computador',
      child: Text(
        "Modo computador",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];
  @override
  void dispose() {
    _qntMaxPController.dispose();
    _qntMaxRController.dispose();
    _singlePlayerName.dispose();
    p1Controller.dispose();
    p2Controller.dispose();
    dropdownValue == "none";
    super.dispose();
  }
  

void inserirNomeJogadorUnico(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final formKeyNomeUnico = GlobalKey<FormState>();
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 35, 109),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 250,
            width: 400,
            child: Form(
              key: formKeyNomeUnico,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título do Dialog
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "INSIRA O NOME DO JOGADOR",
                        style: customTitleTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // Campo de texto para o nome do jogador
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: customInputDecorations(),
                      style: const TextStyle(color: Colors.white),
                      controller: _singlePlayerName,
                      validator: (value) => isNotEmpty(value),
                    ),
                  ),

                  // Botão de "Iniciar Jogo"
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKeyNomeUnico.currentState!.validate()) {
                          Navigator.of(context).pop(); // Fecha o AlertDialog
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CompPage(
                                nomeJogador: _singlePlayerName.text,
                                qntdMaxRetirar:
                                    int.parse(_qntMaxRController.text),
                                qntdPalitoJogo:
                                    int.parse(_qntMaxPController.text),
                              ),
                            ),
                          );
                        }
                      },
                      style: customButtonStyle(),
                      child: Text(
                        "INICIAR JOGO",
                        style: customButtonTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  void inserirNomesJogadores() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKeyNomes = GlobalKey<FormState>();
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 35, 109),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: 350,
              width: 400,
              child: Form(
                key: formKeyNomes,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: const Text(
                            "INSIRA O NOME DOS JOGADORES",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: customInputDecoration(),
                          style: const TextStyle(color: Colors.white),
                          controller: p1Controller,
                          validator: (value) => isNotEmpty(value),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          decoration: customInputDecoration(),
                          style: const TextStyle(color: Colors.white),
                          controller: p2Controller,
                          validator: (value) => combineValidator([
                            () => isNotEmpty(value),
                            () => validarNomes(
                                p1Controller.text, p2Controller.text)
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (p1Controller.text != p2Controller.text && p1Controller.text.isNotEmpty && p2Controller.text.isNotEmpty) {
                                Navigator.of(context)
                                    .pop(); // Fecha o AlertDialog
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DoisJogadoresPage(
                                      player1: p1Controller.text,
                                      player2: p2Controller.text,
                                      qntdMaxRetirar:
                                          int.parse(_qntMaxRController.text),
                                      qntdPalitoJogo:
                                          int.parse(_qntMaxPController.text),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Os jogadores precisam ter um nome e não podem ser iguais.')),
                                );
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                     minimumSize: const Size(900, 50), // Aumenta a largura e altura
                            padding: const  EdgeInsets.symmetric(   vertical: 0, horizontal: 10),
                            backgroundColor: const  Color.fromARGB(255, 255, 255, 255)),
                          child: const Text(
                            "INICIAR JOGO",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 35, 109),
                                fontWeight: FontWeight.w900),
                          ),
                      ),
                    ),
                  ]
                ),
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
        title: const Center(
            child: Text(
          "NIM GAME",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 255, 35, 109),
        toolbarHeight: 110,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                child: Image.network(
                    'https://th.bing.com/th/id/R.01ff082ff740417fd49b0516797922f2?rik=vns3F4pvTXMR8g&riu=http%3a%2f%2fimage.aladin.co.kr%2fCommunity%2fpaper%2f2013%2f0226%2fpimg_718842193830056.jpg&ehk=bbUhM2K6kJ48RlSU%2f%2bjFlUNZr4Mi4A42EhDvNoncE%2bs%3d&risl=&pid=ImgRaw&r=0'),
              ),
              const SizedBox(
                height: 15.0,
              ),
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
              const SizedBox(
                height: 20.0,
              ),
              //escolher modo - 2 jogadores ou jogar contra a máquina
              // se for dois jogadores pedir o nome dos jogadores

              DropdownButtonFormField<String>(
                validator: (value) => dropdownValidate(value!),
                decoration: decorationDropdown(dropdownValue!),
                value: dropdownValue,
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                dropdownColor: const Color.fromARGB(255, 255, 35, 109),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: _mods,
              ),
              const SizedBox(
                height: 15.0,
              ),

              //escolher quantidade de palitos maxima por jogada 1 a 3
              Visibility(
                visible: ( dropdownValue == 'VS' ||  dropdownValue == 'computador') ? true : false,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _qntMaxRController,
                      decoration: customTextField(
                          "Quantidade maxima de palitos pra retirar(min 1, max 3)"),
                      validator: (value) => combineValidator([
                        () => isNotEmpty(value),
                        () => verificaInteiro(value!),
                        () => maiorLimiteJogada(int.parse(value!)),
                      ]),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    //escolher a quantidade máxima de palitos no jogo 5 a 33
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _qntMaxPController,
                      decoration: customTextField(
                          "Quantidade de palitos no Jogo(min 7, max 13)"),
                      validator: (value) => combineValidator([
                        () => isNotEmpty(value),
                        () => verificaInteiro(value!),
                        () => maiorQueOsLimitesPalitosNoJogo(int.parse(value!)),
                      ]),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
              // Text field pra inserir o nome quando for computador
              /* Visibility(
                visible: (dropdownValue == 'computador') ? true : false,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _singlePlayerName,
                  decoration: customTextField(
                    "Insira seu nome pra Jogar"
                  ),
                  validator: (value) => isNotEmpty(value),                    
                ),
              ), */
              //iniciar Jogo
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (dropdownValue == 'VS') {
                        inserirNomesJogadores();
                      } else if (dropdownValue == 'computador') {
                        inserirNomeJogadorUnico(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 23, 97),
                    minimumSize:
                        const Size(250, 50), // Aumenta a largura e altura
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Jogar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
