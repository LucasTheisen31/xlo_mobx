//validar email
import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(this);
  }
}

//formatar texto no formato de dinheiro (usa pacote intl) -- uso ex: anuncio.price!.formattedMoney()
extension NumberExtension on num {
  String formattedMoney() {
    return NumberFormat('R\$###,##0.00', 'pt-BR').format(this);
  }
}

//formatar texto no formato de data (usa pacote intl) -- uso ex: anuncio.createDate!.formattedDate()
extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt-BR').format(this);
  }
}
