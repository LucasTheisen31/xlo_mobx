// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterStore on _FilterStore, Store {
  late final _$orderByAtom =
      Atom(name: '_FilterStore.orderBy', context: context);

  @override
  OrderBy get orderBy {
    _$orderByAtom.reportRead();
    return super.orderBy;
  }

  @override
  set orderBy(OrderBy value) {
    _$orderByAtom.reportWrite(value, super.orderBy, () {
      super.orderBy = value;
    });
  }

  late final _$_FilterStoreActionController =
      ActionController(name: '_FilterStore', context: context);

  @override
  void setOrderBy(OrderBy value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setOrderBy');
    try {
      return super.setOrderBy(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBy: ${orderBy}
    ''';
  }
}
