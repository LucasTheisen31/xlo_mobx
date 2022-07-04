// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateStore on _CreateStore, Store {
  Computed<bool>? _$imagesValidComputed;

  @override
  bool get imagesValid =>
      (_$imagesValidComputed ??= Computed<bool>(() => super.imagesValid,
              name: '_CreateStore.imagesValid'))
          .value;
  Computed<bool>? _$titleValidComputed;

  @override
  bool get titleValid =>
      (_$titleValidComputed ??= Computed<bool>(() => super.titleValid,
              name: '_CreateStore.titleValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateStore.descriptionValid'))
      .value;
  Computed<bool>? _$categoryValidComputed;

  @override
  bool get categoryValid =>
      (_$categoryValidComputed ??= Computed<bool>(() => super.categoryValid,
              name: '_CreateStore.categoryValid'))
          .value;

  late final _$titleAtom = Atom(name: '_CreateStore.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateStore.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_CreateStore.category', context: context);

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$hidePhoneAtom =
      Atom(name: '_CreateStore.hidePhone', context: context);

  @override
  bool get hidePhone {
    _$hidePhoneAtom.reportRead();
    return super.hidePhone;
  }

  @override
  set hidePhone(bool value) {
    _$hidePhoneAtom.reportWrite(value, super.hidePhone, () {
      super.hidePhone = value;
    });
  }

  late final _$_CreateStoreActionController =
      ActionController(name: '_CreateStore', context: context);

  @override
  void setTitle(String? title) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setTitle');
    try {
      return super.setTitle(title);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String? description) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setDescription');
    try {
      return super.setDescription(description);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(Category category) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setCategory');
    try {
      return super.setCategory(category);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHidePhone(bool? value) {
    final _$actionInfo = _$_CreateStoreActionController.startAction(
        name: '_CreateStore.setHidePhone');
    try {
      return super.setHidePhone(value);
    } finally {
      _$_CreateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
category: ${category},
hidePhone: ${hidePhone},
imagesValid: ${imagesValid},
titleValid: ${titleValid},
descriptionValid: ${descriptionValid},
categoryValid: ${categoryValid}
    ''';
  }
}
