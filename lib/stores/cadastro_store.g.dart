// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroStore on _CadastroStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CadastroStore.nameValid'))
          .value;
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_CadastroStore.emailValid'))
          .value;
  Computed<bool>? _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_CadastroStore.phoneValid'))
          .value;
  Computed<bool>? _$password1ValidComputed;

  @override
  bool get password1Valid =>
      (_$password1ValidComputed ??= Computed<bool>(() => super.password1Valid,
              name: '_CadastroStore.password1Valid'))
          .value;
  Computed<bool>? _$password2ValidComputed;

  @override
  bool get password2Valid =>
      (_$password2ValidComputed ??= Computed<bool>(() => super.password2Valid,
              name: '_CadastroStore.password2Valid'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_CadastroStore.isFormValid'))
          .value;
  Computed<dynamic>? _$cadastroPressedComputed;

  @override
  dynamic get cadastroPressed => (_$cadastroPressedComputed ??=
          Computed<dynamic>(() => super.cadastroPressed,
              name: '_CadastroStore.cadastroPressed'))
      .value;

  late final _$nameAtom = Atom(name: '_CadastroStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom = Atom(name: '_CadastroStore.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$celularAtom =
      Atom(name: '_CadastroStore.celular', context: context);

  @override
  String? get celular {
    _$celularAtom.reportRead();
    return super.celular;
  }

  @override
  set celular(String? value) {
    _$celularAtom.reportWrite(value, super.celular, () {
      super.celular = value;
    });
  }

  late final _$password1Atom =
      Atom(name: '_CadastroStore.password1', context: context);

  @override
  String? get password1 {
    _$password1Atom.reportRead();
    return super.password1;
  }

  @override
  set password1(String? value) {
    _$password1Atom.reportWrite(value, super.password1, () {
      super.password1 = value;
    });
  }

  late final _$password2Atom =
      Atom(name: '_CadastroStore.password2', context: context);

  @override
  String? get password2 {
    _$password2Atom.reportRead();
    return super.password2;
  }

  @override
  set password2(String? value) {
    _$password2Atom.reportWrite(value, super.password2, () {
      super.password2 = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_CadastroStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$cadastroAsyncAction =
      AsyncAction('_CadastroStore.cadastro', context: context);

  @override
  Future<void> cadastro() {
    return _$cadastroAsyncAction.run(() => super.cadastro());
  }

  late final _$_CadastroStoreActionController =
      ActionController(name: '_CadastroStore', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction(
        name: '_CadastroStore.setName');
    try {
      return super.setName(name);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String email) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction(
        name: '_CadastroStore.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword1(String password1) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction(
        name: '_CadastroStore.setPassword1');
    try {
      return super.setPassword1(password1);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword2(String password2) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction(
        name: '_CadastroStore.setPassword2');
    try {
      return super.setPassword2(password2);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
celular: ${celular},
password1: ${password1},
password2: ${password2},
loading: ${loading},
nameValid: ${nameValid},
emailValid: ${emailValid},
phoneValid: ${phoneValid},
password1Valid: ${password1Valid},
password2Valid: ${password2Valid},
isFormValid: ${isFormValid},
cadastroPressed: ${cadastroPressed}
    ''';
  }
}
