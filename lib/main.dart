import 'package:authorizeit/CitizenInfos.dart';
import 'package:authorizeit/citizenForm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
  title: "App",
  home: MyApp(),
));


/// This Widget is the main application widget.
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  
  static bool showForm=false;
  Future<bool> isDataExist() async{
    final prefs = await SharedPreferences.getInstance();
    String key="citizenData";
    print(prefs.containsKey(key));
    return prefs.containsKey(key);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDataExist().then((value) => showForm=value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child:Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0) ,
                child:RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Authorize', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30)),
                      TextSpan(text: "IT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 30)),
                    ],
                  ),
                ),
            ),
                citizenForm(),
                SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child:RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        ),
                    color: Colors.black,
                    child: Text("Afficher mon document",style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CitizenInfos()));
                    }
                    ,) ,
                )

          ],
        )
        ),

    );
  }
}
