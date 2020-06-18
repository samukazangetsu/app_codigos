import 'package:app_codigos/models/push_model.dart';
import 'package:flutter/material.dart';

import 'code_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Códigos TV Box"),
        centerTitle: true,
        backgroundColor: Colors.red,
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
          SizedBox(
            width: 200.0,
            height: 50.0,
            child: RaisedButton(
              color: Colors.red[200],
              onPressed: () {
                final notification = FirebaseNotifications(person).setUpFirebase();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CodeScreen()));
              },
              child: Text("Entrar",
                  style: TextStyle(color: Colors.white, fontSize: 24.0)),
            ),
          ),
        ],
      ),
    );
  }

  void person(String person){
    print("person $person");
  }
}
