import 'package:flutter/animation.dart';

import 'kanban_main_view.dart';

class KanbanViewController {
  KanbanViewController();

  KanbanMainViewState state;

  Future<void> animateTo(
    int index, {
    Duration duration,
    Curve curve,
  }) async {
    double offset = index * state.widget.width;
    if (state.kanbanMainViewController != null &&
        state.kanbanMainViewController.hasClients) {
      await state.kanbanMainViewController.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
    }
  }
}
