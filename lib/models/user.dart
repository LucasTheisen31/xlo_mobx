enum UserType {PARTICULAR, PROFESSIONAL}
/*(0 = PARTICULAR, 1 = PROFESSIONAL)*/

class User{
  //construtor, se nao for passado o type do usuario ele vai ser por padrao type.PARTICULAR
  User({this.id, required this.name, required this.email, required this.phone, this.passwrod, this.type = UserType.PARTICULAR, this.createdAt});

  //atributos
  String? id;
  String name;
  String email;
  String phone;
  String? passwrod;
  UserType type;
  DateTime? createdAt;

  @override
  String toString() {
    return 'Dados do usuario : User{id: $id, name: $name, email: $email, phone: $phone, passwrod: $passwrod, type: $type, createdAt: $createdAt}';
  }
}