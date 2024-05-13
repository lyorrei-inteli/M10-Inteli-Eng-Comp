// clicks_controller.dart
// Controller que vai gerenciar a quantidade total de clicks que foram acionados no projeto

import 'package:mobx/mobx.dart';

part 'clicks_controller.g.dart';

class ClicksController = _ClicksControllerBase with _$ClicksController;

abstract class _ClicksControllerBase with Store {
  @observable
  int totalClicks = 0;

  @action
  void incrementClicks() {
    totalClicks++;
  }
}

