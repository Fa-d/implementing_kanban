import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

// class ban extends StateNotifier {
//   ban() : super(false);
//
//   void backEnabled(entry) => state = entry;
// }
//
// final popupBackButtonEnabled = StateNotifierProvider<ban>((_) => ban());
