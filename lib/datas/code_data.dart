import 'package:cloud_firestore/cloud_firestore.dart';

class CodeData {
  String code;
  String id;
  String type;
  double price;

  CodeData();

  CodeData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    code = snapshot.data["code"];
    type = snapshot.data["type"];
  }

  Map<String, dynamic> toMap() {
    return {"code": code, "type": type, "price": price};
  }
}
