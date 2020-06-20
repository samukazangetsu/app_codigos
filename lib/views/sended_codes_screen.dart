import 'package:app_codigos/views/code_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendedCodesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Códigos TV Box"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("vendidos").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data.documents
                  .map((doc) => Card(
                      elevation: 3,
                      color: _color(doc.data["type"]),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Código: ${doc.data["code"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Valor: R\$${doc.data["price"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                _vencimento(doc.data["type"]),
                                Text(
                                  "Email: ${doc.data["email"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
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

  Color _color(String type) {
    if (type == "1 ano")
      return Colors.green[400];
    else if (type == "3 meses") return Colors.yellow[400];
    return Colors.red[400];
  }

  Text _vencimento(String type) {
    final _date = DateTime.now();
    final _mensal = _date.add(Duration(days: 30));
    final _trimestral = _date.add(Duration(days: 90));
    final _anual = _date.add(Duration(days: 365));
    if (type == "1 ano") {
      return Text(
          "Data de vencimento: ${_anual.day}/${_anual.month}/${_anual.year}",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold));
    } else if (type == "3 meses") {
      return Text(
          "Data de vencimento: ${_trimestral.day}/${_trimestral.month}/${_trimestral.year}",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold));
    }
    return Text(
        "Data de vencimento: ${_mensal.day}/${_mensal.month}/${_mensal.year}",
        style: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold));
  }
}
