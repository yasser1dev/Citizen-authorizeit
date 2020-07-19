import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatefulWidget {

  static Map<String,dynamic> citizenData;



  @override
  _QrCodeWidgetState createState() => _QrCodeWidgetState();
}

class _QrCodeWidgetState extends State<QrCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child:Center(
            child: Column(
              children: [
                Padding(padding:const EdgeInsets.all(20.0) ,child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Authorize', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30)),
                      TextSpan(text: "IT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 30)),
                    ],
                  ),
                )),
                Padding(padding:const EdgeInsets.all(20.0) ,
                  child:RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: "Votre  Code QR", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                      ],
                    ),
                  )
                  ,),
                Padding(padding:const EdgeInsets.all(20.0) ,
                  child:
                  QrImage(
                    data: jsonEncode(QrCodeWidget.citizenData),
                    size: 200.0,),),
                Center(child:RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "Veuillez présenter votre  Code QR \n", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                      TextSpan(text: "à l'autorité lors du contrôle", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                    ],
                  ),
                )
                )
              ],
            ),
          )
      )
      );
  }
}
