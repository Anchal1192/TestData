// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

List<DataModel> dataModelFromJson(String str) => List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  DataModel({
    this.schemeCode,
    this.schemeName,
  });

  int? schemeCode;
  String? schemeName;
  bool whislist = false;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    schemeCode: json["schemeCode"],
    schemeName: json["schemeName"],
  );

  Map<String, dynamic> toJson() => {
    "schemeCode": schemeCode,
    "schemeName": schemeName,
  };
}
