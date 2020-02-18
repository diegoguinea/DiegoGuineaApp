import 'package:flutter_project/services/lang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/map.dart';
import 'package:flutter_project/Routes.dart';


class DWidget extends StatelessWidget {


  @override
  Widget build (BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);

    return new Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text(localizations.titulomap,textAlign: TextAlign.center),backgroundColor: Colors.lightBlueAccent),
      body: MapScreen(),
    );
  }
}

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:<Widget>[
          _createHeader(),
          new ListTile(
            leading: Icon(Icons.map, color: Colors.black, size: 28 ),
            title: Text(localizations.mapa,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushNamed(context, Routes.map);
            },
          ),
          new ListTile(
            leading: Icon(Icons.info,color: Colors.black),
            title: Text(localizations.informacion,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.information);
            },
          ),

          new ListTile(
            leading: Icon(Icons.settings,color: Colors.black),
            title: Text(localizations.ajustes,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
          new ListTile(
            leading: Icon(Icons.group_add,color: Colors.black),
            title: Text(localizations.anadir,style: TextStyle(color: Colors.black),) ,
            onTap: () {
              Navigator.pushNamed(context, Routes.addSpotType);
            },
          ),
          new ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.black
            ),
            title: Text(localizations.inicio,style: TextStyle(color: Colors.black),) ,
            onTap: () {
            },
          )
        ],
      ) ,
    );
  }
}



Widget _createHeader(){
  return UserAccountsDrawerHeader(
    accountName: Text("Usuario"),
    accountEmail: Text("usuario@gmail.com"),
    decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        image: DecorationImage(image: NetworkImage(""),
            fit : BoxFit.cover
        )
    ),
  );
}

