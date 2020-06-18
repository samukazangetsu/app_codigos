import 'package:flutter/material.dart';

import 'code_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Códigos TV Box"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Seja bem vindo!",
              style: TextStyle(color: Colors.black, fontSize: 35.0),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CodeScreen()));
            },
            child: Text("Entrar"),
          )
        ],
      ),
    );
  }
}
