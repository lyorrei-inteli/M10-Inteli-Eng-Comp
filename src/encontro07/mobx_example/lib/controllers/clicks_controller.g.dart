// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clicks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClicksController on _ClicksControllerBase, Store {
  late final _$totalClicksAtom =
      Atom(name: '_ClicksControllerBase.totalClicks', context: context);

  @override
  int get totalClicks {
    _$totalClicksAtom.reportRead();
    return super.totalClicks;
  }

  @override
  set totalClicks(int value) {
    _$totalClicksAtom.reportWrite(value, super.totalClicks, () {
      super.totalClicks = value;
    });
  }

  late final _$_ClicksControllerBaseActionController =
      ActionController(name: '_ClicksControllerBase', context: context);

  @override
  void incrementClicks() {
    final _$actionInfo = _$_ClicksControllerBaseActionController.startAction(
        name: '_ClicksControllerBase.incrementClicks');
    try {
      return super.incrementClicks();
    } finally {
      _$_ClicksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalClicks: ${totalClicks}
    ''';
  }
}
