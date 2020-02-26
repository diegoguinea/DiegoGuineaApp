import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';
import 'package:flutter_project/services/lang.dart';
import 'package:flutter_project/widgets/map.dart';
import 'package:flutter_project/Routes.dart';
import 'package:flutter_project/widgets/ProjectCardItem.dart';

class Moreinfo extends StatelessWidget {

  static const String routeName = '/moreinfo';

  @override
  Widget build(BuildContext context) {
    MoreInfoArguments args = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: AppBar(
        title: Text(args.name),
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
    multilang localizations = Localizations.of<multilang>(context, multilang);
    final MoreInfoArguments args = ModalRoute.of(context).settings.arguments;
    var regulatedPeriodItemList = List<Widget>(); //lista de varios regulated period

    //para cada regulated period creamos una Card con sus datos
    for(RegulatedPeriod regulatedPeriod in args.list_regulated_periods){

      String currentperiod = _preciovalue(regulatedPeriod);

      //TODO estaria bien crear una clase aparte igual que el ProjectCardItem
      var regulatedPeriodItem = Column( children: ListTile.divideTiles(
        context: context,
          tiles: [
            ListTile(
              title: Text(regulatedPeriod.title,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
            ),
            ListTile(
              title: Text(localizations.fechas + regulatedPeriod.start.substring(8)+'/'+regulatedPeriod.start.substring(5,7) + ' - '
                  + regulatedPeriod.end.substring(8)+'/'+regulatedPeriod.end.substring(5,7),

                style: TextStyle(color: Colors.black54),),
            ),
            ListTile(
              title: Text( currentperiod,style: TextStyle(color: Colors.black54),),
            ),
            ListTile(
              title: Text(localizations.horarios, style:TextStyle(color: Colors.black54),),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, Routes.calendario,
                  arguments: WeekDayArguments(
                      regulatedPeriod,
                      args.project_tz
                  ),
                );
              },
          ),

      ]).toList());

      //creamos una Card para cada periodo regulado
      regulatedPeriodItemList.add(
          Card(child:regulatedPeriodItem)
      );

    }

    //TODO añadir scroll por si es mas largo que la pantalla
    return ListView(
          children: <Widget>[
            //TODO mejorar el formato de los datos del proyecto
            Card(child: ProjectCardItem(
              projectName: args.project_name,
              numSpots: args.max_capacity.toString(),
            )),
            Column(children: regulatedPeriodItemList,), //lista de varios regulated period
            ],
    );


  }

  //TODO: Esta funcion es la que le da valor a una variable para guardar el tiempo y el precio (no consigo que funcione)
  _preciovalue(RegulatedPeriod regulatedPeriod){
    multilang localizations = Localizations.of<multilang>(context, multilang);
    String resultado = "";
    String resultadoprecio = "";
    for(TimePeriodType timePeriodType in regulatedPeriod.time_period_types){
      if (timePeriodType.period_type_id == 3) {
        resultadoprecio = localizations.tiempomax + timePeriodType.value + "min    ";
      } else if (timePeriodType.period_type_id == 2) {
        resultadoprecio = localizations.precio + timePeriodType.value + "€/h    ";
      }
      resultado = resultado + resultadoprecio;

    }
    return resultado;
  }

}
class WeekDayArguments{
  RegulatedPeriod regulatedPeriod;
  String project_tz;
  WeekDayArguments(this.regulatedPeriod, this.project_tz);
}