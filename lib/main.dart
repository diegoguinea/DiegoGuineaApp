import 'package:flutter_project/services/lang.dart';
import 'package:flutter_project/splash.dart';
import 'package:flutter_project/widgets/add.dart';
import 'package:flutter_project/widgets/ajustes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/information.dart';
import 'package:flutter_project/widgets/map.dart';
import 'package:flutter_project/Routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project/widgets/moreinfo.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Castellano
        ],
        localizationsDelegates: [
          multilang.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: SplashScreen(),             //      new DWidget(),
        routes: <String, WidgetBuilder>{
          Routes.map: (BuildContext context) => new MapPage(),
          Routes.information: (BuildContext context) => new InfoPage(),
          Routes.settings: (BuildContext context) => new SettingsPage(),
          Routes.addSpotType: (BuildContext context) => new AddPage(),
          Routes.moreinfo: (BuildContext context)=> new Moreinfo(),
        }
    );
  }
}






