import 'package:app_codigos/datas/code_data.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvaliableCodesScreen extends StatefulWidget {
  @override
  _AvaliableCodesScreenState createState() => _AvaliableCodesScreenState();
}

class _AvaliableCodesScreenState extends State<AvaliableCodesScreen> {
  bool copied;
  int numb;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Códigos TV Box"),
              centerTitle: true,
              backgroundColor: Colors.redAccent[200],
              bottom: TabBar(indicatorColor: Colors.white, tabs: <Widget>[
                Tab(
                  text: "1 mês",
                ),
                Tab(
                  text: "3 meses",
                ),
                Tab(
                  text: "1 ano",
                )
              ]),
            ),
            body: TabBarView(
              children: [
                FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance
                        .collection("codigos")
                        .document("1 mês")
                        .collection("items")
                        .getDocuments(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              CodeData data = CodeData.fromDocument(
                                  snapshot.data.documents[index]);

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 2.5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: numb != index
                                              ? Icon(
                                                  Icons.check_box_outline_blank)
                                              : Icon(
                                                  Icons.check_box,
                                                  color: Colors.green,
                                                ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${data.code}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.0,
                                          height: 40.0,
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  side: BorderSide(width: 1)),
                                              elevation: 0,
                                              color: Colors.blue[200],
                                              child: Icon(
                                                Icons.content_copy,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  numb = index;
                                                });
                                                ClipboardManager
                                                        .copyToClipBoard(
                                                            "${data.code}")
                                                    .then((result) {
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        'Código Copiado para Área de Transferência'),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                });
                                              }),
                                        )
                                      ],
                                    )),
                              );
                            });
                    }),
                FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance
                        .collection("codigos")
                        .document("3 meses")
                        .collection("items")
                        .getDocuments(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              CodeData data = CodeData.fromDocument(
                                  snapshot.data.documents[index]);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 2.5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: numb != index
                                              ? Icon(
                                                  Icons.check_box_outline_blank)
                                              : Icon(
                                                  Icons.check_box,
                                                  color: Colors.green,
                                                ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${data.code}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.0,
                                          height: 40.0,
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  side: BorderSide(width: 1)),
                                              elevation: 0,
                                              color: Colors.blue[200],
                                              child: Icon(
                                                Icons.content_copy,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  numb = index;
                                                });
                                                ClipboardManager
                                                        .copyToClipBoard(
                                                            "${data.code}")
                                                    .then((result) {
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        'Código Copiado para Área de Transferência'),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                });
                                              }),
                                        )
                                      ],
                                    )),
                              );
                            });
                    }),
                FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance
                        .collection("codigos")
                        .document("1 ano")
                        .collection("items")
                        .getDocuments(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              CodeData data = CodeData.fromDocument(
                                  snapshot.data.documents[index]);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 2.5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: numb != index
                                              ? Icon(
                                                  Icons.check_box_outline_blank)
                                              : Icon(
                                                  Icons.check_box,
                                                  color: Colors.green,
                                                ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${data.code}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.0,
                                          height: 40.0,
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  side: BorderSide(width: 1)),
                                              elevation: 0,
                                              color: Colors.blue[200],
                                              child: Icon(
                                                Icons.content_copy,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  numb = index;
                                                });
                                                ClipboardManager
                                                        .copyToClipBoard(
                                                            "${data.code}")
                                                    .then((result) {
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        'Código Copiado para Área de Transferência'),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                });
                                              }),
                                        )
                                      ],
                                    )),
                              );
                            });
                    })
              ],
            )));
  }
}
