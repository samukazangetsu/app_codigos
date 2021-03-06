import 'package:app_codigos/datas/code_data.dart';
import 'package:app_codigos/models/code_model.dart';
import 'package:app_codigos/views/sended_codes_screen.dart';
import 'package:flutter/material.dart';

import 'avaliable_codes_screen.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  // Controladores dos TextForm
  final _codeController = TextEditingController();

  // Global Keys
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Valor inicial do dropdown
  String dropdownValue = "1 mês";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Códigos TV Box"),
          centerTitle: true,
          backgroundColor: Colors.redAccent[200],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "INSIRA SEUS CÓDIGOS AQUI",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: <Widget>[
                          Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(15.0)),
                              margin: EdgeInsets.all(15.0),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    // Input código
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Código",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                      controller: _codeController,
                                      validator: (text) {
                                        if (text.isEmpty || text.length == 0)
                                          return "Insira um código";
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Tempo de validade:"),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: DropdownButton<String>(
                                              value: dropdownValue,
                                              icon: Icon(Icons.arrow_drop_down),
                                              elevation: 16,
                                              underline: Container(
                                                height: 2,
                                                color: Colors.red,
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: <String>[
                                                '1 mês',
                                                '3 meses',
                                                '1 ano'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 210.0,
                                      height: 50.0,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        elevation: 3,
                                        color: Colors.red[500],
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            CodeData codeData = CodeData();
                                            codeData.code =
                                                _codeController.text;
                                            codeData.type = dropdownValue;
                                            if (dropdownValue == '1 mês')
                                              codeData.price = 20.0;
                                            else if (dropdownValue == '3 meses')
                                              codeData.price = 60.0;
                                            else
                                              codeData.price = 240.0;
                                            CodeModel.addCode(
                                                codeData, dropdownValue);
                                            _snack();
                                            _clearAll();
                                          }
                                        },
                                        child: Text("Enviar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: 210.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SendedCodesScreen()));
                          },
                          child: Text("Ver Códigos Vendidos",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: 210.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Colors.blueGrey,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AvaliableCodesScreen()));
                          },
                          child: Text(
                            "Ver Códigos Disponíveis",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // Funções
  void _snack() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Seus códigos foram enviados!"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 2),
    ));
  }

  void _clearAll() {
    setState(() {
      _codeController.text = "";
      // _maskController.text = "0.00";
    });
  }
}
