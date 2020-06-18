import 'package:app_codigos/datas/code_data.dart';
import 'package:app_codigos/models/code_model.dart';
import 'package:flutter/material.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  // Controladores dos TextForm
  final _codeController = TextEditingController();
  final _priceController = TextEditingController();

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
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Insira seus códigos aqui!",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 25.0, 50.0, 10.0),
                child: Column(
                  children: <Widget>[
                    // Input código
                    TextFormField(
                      decoration: InputDecoration(labelText: "Código"),
                      controller: _codeController,
                      validator: (text) {
                        if (text.isEmpty || text.length == 0)
                          return "Insira um código";
                      },
                    ),
                    // Input valor
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Preço",
                          prefixText: "R\$",
                          prefixStyle: TextStyle()),
                      controller: _priceController,
                      validator: (text) {
                        if (text.isEmpty || text.length == 0)
                          return "Insira um valor";
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Tempo de validade:"),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '1 mês',
                                '3 meses',
                                '1 ano'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    CodeData codeData = CodeData();
                    codeData.code = _codeController.text;
                    codeData.type = dropdownValue;
                    codeData.price = _priceController.text;
                    CodeModel.addCode(codeData, dropdownValue);
                    _snack();
                    _clearAll();
                  }
                },
                child: Text("Enviar"),
              )
            ],
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
      _priceController.text = "";
    });
  }
}
