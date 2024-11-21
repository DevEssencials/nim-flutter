class UserModel {
  final String nome;
  final int? pontos;

  UserModel({required this.nome, required this.pontos});

  //métodos para manipular o json
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      nome: json['nome'], 
      pontos: json['placar']);
  }
  
  Map<String, dynamic> toJson() {
    return{
      'nome': nome,
      'placar': pontos
    };
  }

}