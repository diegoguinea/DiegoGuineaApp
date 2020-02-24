import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';
import 'package:flutter_project/widgets/map.dart';
import 'package:flutter_project/Routes.dart';

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
    final MoreInfoArguments args = ModalRoute.of(context).settings.arguments;
    var regulatedPeriodList = List<Widget>();

    for(RegulatedPeriod regulatedPeriod in args.list_regulated_periods){

      regulatedPeriodList.add(
        new Ink(
          color: Color.fromRGBO(155, 155, 155, 0.5),
          child: ListTile(
            title: Text(regulatedPeriod.title,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
          ),
        ),
      );
      regulatedPeriodList.add(
        ListTile(
          title: Text('Dates              ' + regulatedPeriod.start.substring(8)+'/'+regulatedPeriod.start.substring(5,7) + ' - '
              + regulatedPeriod.end.substring(8)+'/'+regulatedPeriod.end.substring(5,7),

            style: TextStyle(color: Colors.blue),),
        ),
      );

      String currentperiod = _preciovalue(regulatedPeriod);

      regulatedPeriodList.add(
        ListTile(
          title: Text( currentperiod,style: TextStyle(color: Colors.blue),),
        ),
      );

      regulatedPeriodList.add(
        RaisedButton(
          child: Text("Time table", style:TextStyle(color: Colors.blue),),
          color: Colors.white,
          onPressed: (){

            Navigator.pushNamed(context, Routes.calendario,
              arguments: WeekDayArguments(
                  regulatedPeriod,
                  args.project_tz
              ),
            );
          },
        ),
      );
    }
    return ListView(
          children: <Widget>[
              ListTile(
                title: Text('City                 ' +  args.project_name,style: TextStyle(color: Colors.blue),),
              ),
            ListTile(
              title: Text('Num Spots    ' + args.max_capacity.toString(),style: TextStyle(color: Colors.blue),),
            ),
            Column(children: regulatedPeriodList,), //llista dinamica de regulated period
            ],
    );


  }

  //TODO: Esta funcion es la que le da valor a una variable para guardar el tiempo y el precio (no consigo que funcione)
  _preciovalue(RegulatedPeriod regulatedPeriod){
    String resultado = "";
    String resultadoprecio = "";
    for(TimePeriodType timePeriodType in regulatedPeriod.time_period_types){
      if (timePeriodType.period_type_id == 3) {
        resultadoprecio = "Max time:  " + timePeriodType.value + "min    ";
      } else if (timePeriodType.period_type_id == 2) {
        resultadoprecio = "Price:  " + timePeriodType.value + "€/h";
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