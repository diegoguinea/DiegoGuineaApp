import 'package:flutter/material.dart';
import 'package:flutter_project/home.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_project/services/lang.dart';


class SettingsPage extends StatelessWidget {

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Scaffold(
        appBar: AppBar(
          title: Text(localizations.ajustes,textAlign: TextAlign.center),backgroundColor: Colors.lightBlueAccent),
        drawer: AppDrawer(),
        body: SettingsScreen(),
    );
  }

}

class SettingsScreen extends StatefulWidget{
  @override
  State<SettingsScreen> createState()=> SettingsScreenState();
}


class SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return Scaffold(
        body: BottomAppBar(
        child: SingleChildScrollView(
          child:  new Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 25,
                ),
            Row(
              children: <Widget>[
                Container(
                  child: Text(localizations.localizacion,style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                ),
                ]
            ),

                Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 20,
                  ),
                  Container(
                    child: ButtonTheme(
                      minWidth: 200,
                      buttonColor: Colors.white,
                      child:  RaisedButton(
                        onPressed: AppSettings.openLocationSettings,
                        child: Text(localizations.abrirajustesloc),
                      ),
                    ),
                  ),
                ]
                ),

              ],
            ),
          ),
        ),
        ),
        );

  }
}
