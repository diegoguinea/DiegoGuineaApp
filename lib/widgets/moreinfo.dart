import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Moreinfo extends StatelessWidget {

  static const String routeName = '/moreinfo';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("More info"),
        backgroundColor: Color.fromRGBO(47, 180, 233, 1),
        centerTitle: true,
      ),
      body: Moreinforegulated(),
    );
  }
}


class Moreinforegulated extends StatefulWidget{
  @override
  State<Moreinforegulated> createState()=> MoreinforegulatedState();
}


class MoreinforegulatedState extends State<Moreinforegulated> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
              ListTile(
                title: Text('City ',style: TextStyle(color: Colors.blue),),
              ),
            ListTile(
              title: Text('Num Spots ',style: TextStyle(color: Colors.blue),),
            ),
              Ink(
                color: Color.fromRGBO(155, 155, 155, 0.5),
                child: ListTile(
                  title: Text('Regulated Period',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                ),
              ),
            ],
    );

  }
}