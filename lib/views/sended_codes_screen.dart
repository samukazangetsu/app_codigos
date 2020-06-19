import 'package:app_codigos/views/code_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendedCodesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("Códigos TV Box"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("codigos")
            .document("1 mês")
            .collection("items")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data.documents
                  .map((doc) => Card(
                      elevation: 3,
                      color: Colors.indigo[700],
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Código: ${doc.data["code"]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                                Text(
                                  "Valor: R\$${doc.data["price"]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                                Text(
                                  "Data de vencimento: ${_date.day}/${_date.month}/${_date.year}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                                Text(
                                  "Email:",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ],
                            )),
                            IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () {})
                          ],
                        ),
                      )))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
