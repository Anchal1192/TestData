import 'dart:convert';

import 'DataModel.dart';
import 'ServiceCall.dart';

class Apicall{
 static Future<List<DataModel>> getdataList() async {
    List<DataModel>  myList = [];
    await ServiceCall.get('https://api.mfapi.in/mf').then((response) {
      if(response != null && response.statusCode == 200) {
        var mapp = jsonDecode(response.body);
        myList = List<DataModel>.from(mapp.map((x) => DataModel.fromJson(x)));
         print(myList);
      }
      else {
        print('server error');
      }
    } );
    return myList;
  }
}