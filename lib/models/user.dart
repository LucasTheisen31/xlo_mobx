enum UserType {PARTICULAR, PROFESSIONAL}
/*(0 = PARTICULAR, 1 = PROFESSIONAL)*/

class User{
  //construtor, se nao for passado o UserType ele vai ser por padrao UserType.PARTICULAR
  User({required this.name, required this.email, required this.phone, required this.passwrod, this.userType = UserType.PARTICULAR});

  //atributos
  String name;
  String email;
  String phone;
  String passwrod;
  UserType userType;
}