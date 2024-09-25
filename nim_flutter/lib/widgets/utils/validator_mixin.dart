mixin Validator{
  String? isNotEmpty( value){
    if(value.isEmpty)return 'Campo obrigatório';
    return null;
  }
  String? maiorQueOsLimitesPalitosNoJogo(int value){
    if(value>7 ||value<13)return 'Valor fora dos limites';
    return null;
  }
  String? maiorLimiteJogada(int value){
    if(value>1 || value<3)return 'Valor fora dos limites';
    return null;
  }

  String? verificaInteiro(String value){
    try {
      int.parse(value);
      return null; // É um inteiro válido
    } catch (e) {
      return 'Valor precisa ser inteiro'; // Não é um inteiro
    }
  }

  String? combineValidator(List<String? Function()> validators){
    for(final val in validators){
      final validar = val();
      if(validar != null)return validar;
    }return null;
  }

  String? dropdownValidate(String value){
    if(value == "none")return 'Escolha algum modo';
    return null;
  }

  String? validarNomes(String nome1, nome2){
    if(nome1 == nome2)return 'Os Nomes devem ser diferentes';
    return null;
  }

}