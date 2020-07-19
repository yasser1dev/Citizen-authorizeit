import 'dart:ui';

import 'package:authorizeit/QRCodeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:authorizeit/Shared/Constants.dart';

class CitizenInfos extends StatefulWidget {

  @override
  _CitizenInfosState createState() => _CitizenInfosState();
}


class _CitizenInfosState extends State<CitizenInfos> {

  Map<String,dynamic> infos;
  var listRaison=["Urgence","Médicament","Produits alimentiares","Etudes"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCitizen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: themePrimaryColor,
    ),
        backgroundColor: themePrimaryColor,

        body: SafeArea(
        child:FutureBuilder(
        builder: (context,snapshot){
           if(snapshot.connectionState==ConnectionState.none && snapshot.data==null){
             return  CircularProgressIndicator(
                 backgroundColor: Colors.blue);
           }
           else {
             return Column(
                 children: [
                   Center(
                     child: Padding(padding: const EdgeInsets.all(50.0),
                       child:RichText(
                         text: TextSpan(
                           children: <TextSpan>[
                             TextSpan(text: 'Authorize', style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white,
                                 fontSize: 30)),
                             TextSpan(text: "IT", style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: themeSecondaryColor,
                                 fontSize: 30)),
                           ],
                         ),
                       ),
                     ),
                   ),
                   Padding(padding:const EdgeInsets.all(10.0),child: RichText(
                     text: TextSpan(
                       style: DefaultTextStyle
                           .of(context)
                           .style,
                       children: <TextSpan>[
                         TextSpan(text: 'Nom : ', style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 20,color: themeSecondaryColor)),
                         TextSpan(text: infos["nom"], style: TextStyle(
                             fontSize: 20,color: themeSecondaryColor)),
                       ],
                     ),
                   ),),
                   Padding(padding: const EdgeInsets.all(10.0),child: RichText(
                     text: TextSpan(
                       style: DefaultTextStyle
                           .of(context)
                           .style,
                       children: <TextSpan>[
                         TextSpan(text: 'Prenom  : ', style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 20,color: themeSecondaryColor)),
                         TextSpan(text: infos["prenom"], style: TextStyle(
                             fontSize: 20,color: themeSecondaryColor)),
                       ],
                     ),
                   ),),
                   Padding(padding:const EdgeInsets.all(10.0) ,child: RichText(
                     text: TextSpan(
                       style: DefaultTextStyle
                           .of(context)
                           .style,
                       children: <TextSpan>[
                         TextSpan(text: 'Adresse  : ', style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 20,color: themeSecondaryColor)),
                         TextSpan(text: infos["adresse"], style: TextStyle(
                             fontSize: 20,color: themeSecondaryColor)),
                       ],
                     ),
                   ),),
                   Padding(padding: const EdgeInsets.all(10.0),child: RichText(
                     text: TextSpan(
                       style: DefaultTextStyle
                           .of(context)
                           .style,
                       children: <TextSpan>[
                         TextSpan(text: 'CIN  : ', style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 20,color: themeSecondaryColor)),
                         TextSpan(text: infos["cin"], style: TextStyle(
                             fontSize: 20,color: themeSecondaryColor)),
                       ],
                     ),
                   ),),
                   Padding(padding: const EdgeInsets.all(10.0),child: RichText(
                     text: TextSpan(
                       style: DefaultTextStyle
                           .of(context)
                           .style,
                       children: <TextSpan>[
                         TextSpan(text: 'Raison  : ', style: TextStyle(color: themeSecondaryColor,
                             fontWeight: FontWeight.bold, fontSize: 20)),
                         TextSpan(text: listRaison[int.parse(infos["raison"]) -
                             1], style: TextStyle(fontSize: 20,color: themeSecondaryColor)),
                       ],
                     ),
                   ),),
                   SizedBox(
                   width: MediaQuery.of(context).size.width * 0.7,
                     child: Padding(padding: const EdgeInsets.all(20.0),
                         child:RaisedButton(
                           color: themeSecondaryColor,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(18.0),
                           ),
                           child: Text("Générer QR Code",
                             style: TextStyle(color: Colors.white),),
                           onPressed: () {
                             Navigator.of(context).pop();
                             Navigator.push(context, MaterialPageRoute(builder: (
                                 context) => QrCodeWidget()));
                           })),
                   ),

                 ]
             );
           }

        },
      future: getCitizen(),
        )
      )
    );
  }
  Future getCitizen() async {
    final prefs = await SharedPreferences.getInstance();
    String key="citizenData";
    Map<String,dynamic> infosCitizen=jsonDecode(prefs.getString(key));
    print(jsonEncode(infosCitizen));
    infos=infosCitizen;


    QrCodeWidget.citizenData=infos;
    return infosCitizen;

  }
}





