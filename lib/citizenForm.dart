
import 'dart:convert';

import 'package:authorizeit/models/Citizen.dart';
import 'package:authorizeit/utils/DBMemory.dart';
import 'package:authorizeit/utils/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'CitizenInfos.dart';

class citizenForm extends StatefulWidget {


  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<citizenForm> {
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _lastname = TextEditingController();
  final _adresse = TextEditingController();
  final _cin = TextEditingController();

  List<dynamic> reasonsData=[{"id": 1, "nom": "raison1"}];
  String _currentReason;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReasons();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
     return SafeArea(
         child:Form(
           key: _formKey,
           child:
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Center(
                 child:
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5.0),
                   child:Text(
                       "Veuillez Remplir ce formulaire"
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 child:TextFormField(
                   controller: _name,
                   decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
                       border: new OutlineInputBorder(
                           borderRadius: const BorderRadius.all(const Radius.circular(20.0))
                       ),
                       labelText: 'Prenom : '
                   ),
                   validator: (value) {
                     if (value.isEmpty) {
                       return 'Entrer votre prenom';
                     }
                     return null;
                   },
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 child:TextFormField(
                   controller: _lastname,
                   decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
                       border: new OutlineInputBorder(
                           borderRadius: const BorderRadius.all(const Radius.circular(20.0))
                       ),
                       labelText: 'Nom : '
                   ),
                   validator: (value) {
                     if (value.isEmpty) {
                       return 'Entrer votre prenom';
                     }
                     return null;
                   },
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 child: TextFormField(
                   controller: _adresse,
                   decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
                       border: new OutlineInputBorder(
                           borderRadius: const BorderRadius.all(const Radius.circular(20.0))
                       ),
                       labelText: 'Adresse : '
                   ),
                   validator: (value) {
                     if (value.isEmpty) {
                       return 'Entrer votre adresse';
                     }
                     return null;
                   },
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 child:TextFormField(
                   controller: _cin,
                   decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),
                       border: new OutlineInputBorder(
                           borderRadius: const BorderRadius.all(const Radius.circular(20.0))
                       ),
                       labelText: 'CIN : '
                   ),
                   validator: (value) {
                     if (value.isEmpty) {
                       return 'Entrer votre cin';
                     }
                     return null;
                   },
                 ),
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10.0) ,
                 child: Text("Choisir votre raison"),
               ),
               DropdownButton(
                   value: _currentReason,
                   items: reasonsData.map((item){
                     return DropdownMenuItem(
                         child: Text(item["nom"]),
                         value: item["id"]);
                   }).toList(),
                   onChanged: (val){
                     setState(() {
                       _currentReason=val;
                     });
                   }),

               Center(child:
                  SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            StoreData();
                            //Navigator.of(context).pop();
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>CitizenInfos()));
                          }
                        },
                        child: Text('Valider',style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
               )
             ],
           ),
         )
     );
  }



  void getReasons() async{
    try{
      Response reasons=await get("https://my-json-server.typicode.com/iGX10/AuthorizeIT-MkeddemApp/raisons");
      var listData=jsonDecode(reasons.body);
      print(listData);
      setState(() {
        reasonsData=listData;

      });

    }catch(e){
      print(e);
    }
  }



  void StoreData() async{
    final prefs = await SharedPreferences.getInstance();

    String name = _name.text;
    String lastname = _lastname.text;
    String adresse = _adresse.text;
    String cin = _cin.text;

    Map<String,dynamic> citizenData=Map();
    citizenData['cin']=cin;
    citizenData['nom']=name;
    citizenData['prenom']=lastname;
    citizenData['adresse']=adresse;
    citizenData['raison']=_currentReason;

    String key="citizenData";
    print(json.encode(citizenData));
    prefs.setString(key, jsonEncode(citizenData));



  }




}




