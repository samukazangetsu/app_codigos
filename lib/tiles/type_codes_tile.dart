import 'package:app_codigos/datas/code_data.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';

class TypeCodesTile extends StatefulWidget {
  final String type;
  final CodeData codeData;
  final int index;

  const TypeCodesTile(
      {Key key,
      @required this.type,
      @required this.codeData,
      @required this.index})
      : super(key: key);
  @override
  _TypeCodesTileState createState() => _TypeCodesTileState();
}

class _TypeCodesTileState extends State<TypeCodesTile> {
  int numb;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: numb != widget.index
                    ? Icon(Icons.check_box_outline_blank)
                    : Icon(
                        Icons.check_box,
                        color: Colors.green,
                      ),
              ),
              Expanded(
                child: Text(
                  "${widget.codeData.code}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                ),
              ),
              SizedBox(
                width: 80.0,
                height: 40.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        side: BorderSide(width: 1)),
                    elevation: 0,
                    color: Colors.blue[200],
                    child: Icon(
                      Icons.content_copy,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        numb = widget.index;
                      });
                      ClipboardManager.copyToClipBoard(
                              "${widget.codeData.code}")
                          .then((result) {
                        final snackBar = SnackBar(
                          content:
                              Text('Código Copiado para Área de Transferência'),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    }),
              )
            ],
          )),
    );
  }
}
