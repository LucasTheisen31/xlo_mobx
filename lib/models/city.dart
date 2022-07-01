class City {
  //construtor
  City({this.id, this.nome});

  //metodo que cria um novo objetos, quando temos um Json trabalhamos com Factory
  //recebe um Json e instancia um objeto
  factory City.fromJason(Map<String, dynamic> json) {
    return City(id: json['id'], nome: json['nome']);
  }

  int? id;
  String? nome;

  //toString para quando printar um objeto da classe
  @override
  String toString() {
    return 'City{id: $id, nome: $nome}';
  }
}
