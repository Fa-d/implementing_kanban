import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implementing_kanban/card_item_models/models/label_object.dart';

class ColorPicked extends StateNotifier<Color> {
  ColorPicked() : super(Colors.red);

  void setColor(color) => state = color;
}

final selectedColorOfLabel =
    StateNotifierProvider<ColorPicked>((_) => ColorPicked());

class CurrentPopupClass extends StateNotifier {
  CurrentPopupClass() : super(true);

  void setCurrentPopup(val) => state = val;
}

final currentPopup =
    StateNotifierProvider<CurrentPopupClass>((_) => CurrentPopupClass());

class OverlayChecking extends StateNotifier {
  OverlayChecking() : super(OverlayEntry);

  void setOverlayEntry(entry) => state = entry;
}

final currentOverlayCheck =
    StateNotifierProvider<OverlayChecking>((_) => OverlayChecking());

final selectedLabels =
    StateNotifierProvider<CurrentLabelList>((_) => CurrentLabelList([]));

class CurrentLabelList extends StateNotifier<List<SingleLabelObject>> {
  CurrentLabelList(List<SingleLabelObject> items)
      : super(items ?? <SingleLabelObject>[]);

  addToLabel(SingleLabelObject item) => state = [...state, item];
}

final subPopupLocation = StateNotifierProvider((_) => SubPopupLocClass(
      PopupLoc(
        offset: Offset.zero,
        // link: LayerLink(),
      ),
    ));

class SubPopupLocClass extends StateNotifier<PopupLoc> {
  SubPopupLocClass(PopupLoc state) : super(state);

  setOffsetVal(PopupLoc model) => state = model;
}

class DescriptionEditingClass extends StateNotifier {
  DescriptionEditingClass() : super(true);

  void setTrueOrFalse(bool val) => state = val;

  bool getTrueOrFalse() => state;
}

final descriptionEditor = StateNotifierProvider<DescriptionEditingClass>(
    (_) => DescriptionEditingClass());
