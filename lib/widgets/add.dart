import 'package:flutter/material.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/services/lang.dart';

class AddPage extends StatelessWidget {

  static const String routeName = '/add';

  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Scaffold(
        appBar: AppBar(
          title: Text(localizations.anadir),
          backgroundColor: Color.fromRGBO(47, 180, 233, 1),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: AddScreen(),
    );
  }
}


class AddScreen extends StatefulWidget{
  @override
  State<AddScreen> createState()=> AddScreenState();
}


class AddScreenState extends State<AddScreen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BottomAppBar(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
    );

  }
}