class UF {
  //construtor
  UF({this.id, this.sigla, this.nome});

  //metodo que cria um novo objetos, quando temos um Json trabalhamos com Factory
  //recebe um Json e instancia um objeto
  factory UF.fromJason(Map<String, dynamic> json) {
    return UF(id: json['id'], sigla: json['sigla'], nome: json['nome']);
  }

  int? id;
  //iniciais do estado
  String? sigla;
  //nome do estado
  String? nome;

  //toString para quando printar um objeto da classe
  @override
  String toString() {
    return 'UF{id: $id, sigla: $sigla, nome: $nome}';
  }
}
