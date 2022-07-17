// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meus_anuncios_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MeusAnunciosStore on _MeusAnunciosStore, Store {
  Computed<List<Anuncio>>? _$listAnunciosAtivosComputed;

  @override
  List<Anuncio> get listAnunciosAtivos => (_$listAnunciosAtivosComputed ??=
          Computed<List<Anuncio>>(() => super.listAnunciosAtivos,
              name: '_MeusAnunciosStore.listAnunciosAtivos'))
      .value;

  late final _$lisTodosAnunciosAtom =
      Atom(name: '_MeusAnunciosStore.lisTodosAnuncios', context: context);

  @override
  List<Anuncio> get lisTodosAnuncios {
    _$lisTodosAnunciosAtom.reportRead();
    return super.lisTodosAnuncios;
  }

  @override
  set lisTodosAnuncios(List<Anuncio> value) {
    _$lisTodosAnunciosAtom.reportWrite(value, super.lisTodosAnuncios, () {
      super.lisTodosAnuncios = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_MeusAnunciosStore.loading', context: context);

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

  @override
  String toString() {
    return '''
lisTodosAnuncios: ${lisTodosAnuncios},
loading: ${loading},
listAnunciosAtivos: ${listAnunciosAtivos}
    ''';
  }
}
