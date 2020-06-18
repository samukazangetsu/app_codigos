import 'package:app_codigos/datas/code_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CodeModel {

  static void addCode(CodeData code, String type) {
    Firestore.instance
        .collection("codigos")
        .document(type)
        .collection("items")
        .add(code.toMap());
  }
}
