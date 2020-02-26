import 'package:flutter/material.dart';
import 'package:flutter_project/services/lang.dart';
import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';
import 'package:flutter_project/widgets/moreinfo.dart';
import 'package:flutter_project/utils/utils.dart';



class CalendarPage extends StatelessWidget {

  static const String routeName = '/calendario';


  @override
  Widget build(BuildContext context) {

    multilang localizations = Localizations.of<multilang>(context, multilang);

    return new Scaffold(
      appBar: AppBar(
        title: Text(localizations.horarios),
        backgroundColor: Color.fromRGBO(47, 180, 233, 1),
        centerTitle: true,
      ),
      body: Calendar(),
    );
  }
}


class Calendar extends StatefulWidget{
  @override
  State<Calendar> createState()=> CalendarState();
}


class CalendarState extends State<Calendar> {

  @override
  void initState(){

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    WeekDayArguments args = ModalRoute.of(context).settings.arguments;


      return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: dataBody(args.regulatedPeriod, args.project_tz, context),
            ),
          ],
        ),
      );
  }
}

DataTable dataBody(RegulatedPeriod regulatedPeriod, project_tz,BuildContext context){
  multilang localizations = Localizations.of<multilang>(context, multilang);
  List<WeekDay> users = WeekDay.getListaDiasSemana(regulatedPeriod, project_tz,context);
  return DataTable(

    columns: [
      DataColumn(
          label: Text(localizations.dia),
          numeric: false,
      ),
      DataColumn(
          label: Text(localizations.horarios),
          numeric: false,
      ),
    ],
    rows: users.map(
          (user) => DataRow(
          cells: [
            DataCell(
              Text(user.dia),
            ),
            DataCell(
              Text(user.horario),
            ),
          ]
      ),
    ).toList(),
  );
}
class WeekDay{
  String dia;
  String horario;

  WeekDay({this.dia,this.horario});

  static List<WeekDay> getListaDiasSemana(RegulatedPeriod regulatedPeriod, String project_tz,BuildContext context){
    multilang localizations = Localizations.of<multilang>(context, multilang);
    List<WeekDay> dias_semana = new List();

    Utils utils = new Utils();

    WeekDay lunes =  WeekDay(dia: localizations.lunes,horario: utils.horario_start_end_tz(regulatedPeriod, "0", project_tz));
    WeekDay martes =  WeekDay(dia: localizations.martes,horario: utils.horario_start_end_tz(regulatedPeriod, "1", project_tz));
    WeekDay miercoles = WeekDay(dia: localizations.miercoles,horario: utils.horario_start_end_tz(regulatedPeriod, "2", project_tz));
    WeekDay jueves = WeekDay(dia: localizations.jueves,horario: utils.horario_start_end_tz(regulatedPeriod, "3", project_tz));
    WeekDay viernes = WeekDay(dia: localizations.viernes,horario: utils.horario_start_end_tz(regulatedPeriod, "4", project_tz));
    WeekDay sabado = WeekDay(dia: localizations.sabado,horario: utils.horario_start_end_tz(regulatedPeriod, "5", project_tz));
    WeekDay domingo = WeekDay(dia: localizations.domingo,horario: utils.horario_start_end_tz(regulatedPeriod, "6", project_tz));

    dias_semana.add(lunes);
    dias_semana.add(martes);
    dias_semana.add(miercoles);
    dias_semana.add(jueves);
    dias_semana.add(viernes);
    dias_semana.add(sabado);
    dias_semana.add(domingo);


    return dias_semana;
  }
}
