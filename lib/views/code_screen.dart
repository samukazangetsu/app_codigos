import 'package:app_codigos/datas/code_data.dart';
import 'package:app_codigos/models/code_model.dart';
import 'package:app_codigos/models/push_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  // Controladores dos TextForm
  final _codeController = TextEditingController();
  final _maskController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

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
                      decoration: InputDecoration(
                          labelText: "Código",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      controller: _codeController,
                      validator: (text) {
                        if (text.isEmpty || text.length == 0)
                          return "Insira um código";
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Input valor
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Preço",
                          prefixText: "R\$",
                          prefixStyle: TextStyle(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      controller: _maskController,
                      validator: (text) {
                        double _priceText = double.parse(text);
                        if (text.isEmpty || _priceText == 0.00)
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
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.red[500],
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      CodeData codeData = CodeData();
                      codeData.code = _codeController.text;
                      codeData.type = dropdownValue;
                      double _price = double.parse(_maskController.text);
                      codeData.price = _price;
                      CodeModel.addCode(codeData, dropdownValue);
                      _snack();
                      _clearAll();
                    }
                  },
                  child: Text("Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.red[500],
                  onPressed: () {
                    CodeModel.deleteCode();
                  },
                  child: Text("Excluir",
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ),
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
      _maskController.text = "0.00";
    });
  }
}
