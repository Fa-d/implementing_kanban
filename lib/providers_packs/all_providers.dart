import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

final selectedColorOfLabel =
    StateNotifierProvider<ColorPicked>((_) => ColorPicked());
class ColorPicked extends StateNotifier<Color> {
  ColorPicked() : super(Colors.red);
  void setColor(color) => state = color;

}
