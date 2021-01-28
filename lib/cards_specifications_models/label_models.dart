import 'dart:math';

import 'package:clippy_flutter/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelsModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Transform(
        //   transform: Matrix4.rotationY(pi),
        //   origin: Offset(180, 1),
        //   child: Transform.rotate(
        //     angle: pi,
        //     child: Message(
        //       child: Container(
        //         height: 20,
        //         color: Colors.green,
        //       ),
        //       triangleX1: 60.0,
        //       triangleX2: 80.0,
        //       triangleX3: 80.0,
        //       triangleY1: 20.0,
        //     ),
        //   ),
        // ),
        Container(
          height: 200,
          color: Colors.orangeAccent[100],
        ),

      ],
    );
  }
}
