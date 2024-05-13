// click_action_controller.dart
// Controller que vai gerenciar a ação de incrementar o total de clicks

import 'package:mobx/mobx.dart';
import 'package:mobx_example/controllers/clicks_controller.dart';

part 'click_action_controller.g.dart';

class ClickActionController = _ClickActionControllerBase with _$ClickActionController;

abstract class _ClickActionControllerBase with Store {
  final ClicksController clicksController;

  _ClickActionControllerBase(this.clicksController);

  @action
  void incrementClicks() {
    clicksController.incrementClicks();
  }
}