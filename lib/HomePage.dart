import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testing/Apicall.dart';

import 'DataModel.dart';
import 'ServiceCall.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
List<DataModel> data = [];
List<DataModel> favData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdataList();
  }

Future<List<DataModel>> getdataList() async {
  await ServiceCall.get('https://api.mfapi.in/mf').then((response) {
    if(response != null && response.statusCode == 200) {
      var mapp = jsonDecode(response.body);
      data = List<DataModel>.from(mapp.map((x) => DataModel.fromJson(x)));
      print(data);

     data.sort((a,b) {
       return a.schemeName!.compareTo(b.schemeName!);
     });
     //  for(int i = 0; i <data.length-1; i++){
     //    int index = i;
     //    for(int j= i+1; j< data.length; j++){
     //      if (data[j].schemeName.toString() < data[index].schemeName.toString()){
     //        index = j;
     //      }
     //    }
     //  }

      setState((){});
    }
    else {
      print('server error');
    }
  } );
  return data;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
          Padding(
            padding: const EdgeInsets.only(top: 8,right: 8),
            child: Text(favData.length.toString()),
          )
        ],
      ),
      body:data.length == null ? Center(child: CircularProgressIndicator(color: Colors.blue,),): Column(
        children: [
          Autocomplete<DataModel>(
              optionsBuilder: (TextEditingValue textEditingValue){
                return data.where(( DataModel model ) =>
                    model.schemeName!.toLowerCase().startsWith(textEditingValue.text.toLowerCase())).toList();
              },
              displayStringForOption: (DataModel option) => option.schemeName.toString(),
              fieldViewBuilder: (BuildContext context, TextEditingController textcontroller,FocusNode focus,VoidCallback onFieldSubmitted ){
                return TextField(
                  controller:  textcontroller,
                  focusNode: focus,
                  decoration: InputDecoration(
                    hintText: 'Select Data',

                  ),
                );
              },
              onSelected: (DataModel select){
                print(select.schemeName);
              },
              optionsViewBuilder: (
                  BuildContext context,
                  AutocompleteOnSelected<DataModel> onSelected,
                  Iterable<DataModel> option
                  ){
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(width: 300,
                      color: Colors.teal,
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: option.length,
                          itemBuilder: (context,index)
                          {
                            final DataModel op = option.elementAt(index);
                            return GestureDetector(
                              onTap: (){
                                onSelected(op);
                              },
                              child: ListTile(
                                title: Text(op.schemeName.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                );
              },
            ),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [

                    ListTile(
                      title: Text(data[index].schemeName.toString()),
                      trailing:InkWell(
                        onTap:(){
                          print(data[index].whislist);
                          setState((){
                            if(data[index].whislist == true ){
                              data[index].whislist = false;
                              favData.remove(data[index]);
                            }
                            else{
                              data[index].whislist = true;
                              favData.add(data[index]);
                            }
                          });

                        },
                          child: Icon(data[index].whislist == true?Icons.favorite:Icons.favorite_border,color: Colors.red,)),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


