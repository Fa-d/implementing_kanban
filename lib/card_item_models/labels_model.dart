import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class LabelModel extends StatefulWidget {
  @override
  _LabelModelState createState() => _LabelModelState();
}

class _LabelModelState extends State<LabelModel> {
  bool page = true;
  Color screenPickerColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return page
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LABELS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color_row(Colors.red),
                color_row(Colors.greenAccent),
                color_row(Colors.blue),
                color_row(Colors.orangeAccent),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        page = false;
                      });
                    },
                    child: Text(
                      "Create a new label",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
          child: Column(
              children: [
                ColorPicker(
                  color: screenPickerColor,
                  onColorChanged: (Color color) =>
                      setState(() => screenPickerColor = color),
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "The name of card",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: screenPickerColor),
                      ),
                      prefixIcon: const Icon(
                        Icons.format_paint_outlined,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Select"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
        );
  }

  color_row(Color color) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Banana"),
            ),
          ),
          flex: 5,
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        )
      ],
    );
  }
}
