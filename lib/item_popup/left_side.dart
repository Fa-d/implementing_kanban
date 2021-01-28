import 'package:flutter/material.dart';

class LeftSidePopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Column(
      // mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.book),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                  Text(
                    "The name of the board",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text("In List"),
                    FlatButton(
                      onPressed: () {},
                      child: Text("TODO's"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: TextFormField(),
        // ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                child: Text("Submitß"),
                onPressed: () {
                  // if (_formKey.currentState.validate()) {
                  //   _formKey.currentState.save();}
                }),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
        ),
      ],
    );
  }
}
