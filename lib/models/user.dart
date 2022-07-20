enum UserType { PARTICULAR, PROFESSIONAL }
/*(0 = PARTICULAR, 1 = PROFESSIONAL)*/

class User {
  //construtor, se nao for passado o type do usuario ele vai ser por padrao type.PARTICULAR
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.type = UserType.PARTICULAR,
    this.createdAt,
  });

  //atributos
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  UserType? type;
  DateTime? createdAt;

  @override
  //metodo chamado quando printamos um objeto do tipo User
  String toString() {
    return 'Dados do usuario : User{id: $id, name: $name, email: $email, phone: $phone, passwrod: $password, type: $type, createdAt: $createdAt}';
  }
}
