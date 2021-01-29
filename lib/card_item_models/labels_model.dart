import 'package:flutter/material.dart';

class LabelModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LABELS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {},
            child: Text("Create a new label"),
          ),
          color_row(Colors.red),
          color_row(Colors.greenAccent),
          color_row(Colors.blue),
          color_row(Colors.orangeAccent),

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
