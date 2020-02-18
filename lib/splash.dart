import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/home.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplshScr createState() => _SplshScr();
}

class _SplshScr extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder:(BuildContext context){
     return DWidget();
   }))
   );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(89, 184, 251, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 400,
             width: 400,
             child : Image.asset('assets/logoblancoazul.png'),
          ),
          Center(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  Container(
                    width: 20,
                  ),
                  Container(
                      child: Center(
                        child: Text('www.urbiotica.com',style: TextStyle(fontSize: 12, color: Colors.white),),
                      )
                  ),
                ]
            ),
          ),

      ],),
    );
  }
}