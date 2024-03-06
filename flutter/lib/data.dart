// import 'package:flutter/cupertino.dart';

class RealtimeDataModel {
  String number;
  RealtimeDataModel({required this.number});
  factory RealtimeDataModel.fromMap(Map data) {
    return RealtimeDataModel(number: data["number"]);
  }
}
