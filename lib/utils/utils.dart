import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';

class Utils {

  bool isInsideInterval(RegulatedPeriod regulatedPeriod){

    //fecha de ahora
    var now = new DateTime.now();

    //dia de la semana actual en string (restamos un dia porque para nosotros el lunes es 0)
    int current_week_day = now.weekday - 1; //el 0 --> dilluns
    String str_week_day = current_week_day.toString();

    //del hashmap de dies de la semana, seleccionamos el dia de hoy
    TimeStartEnd timeStartEnd = regulatedPeriod.days_of_the_week[str_week_day];
    int year_start = int.parse(regulatedPeriod.start.substring(0,4));
    int month_start = int.parse(regulatedPeriod.start.substring(5,7));
    int day_start = int.parse(regulatedPeriod.start.substring(8,10));

    int hour_start = int.parse(timeStartEnd.starttime.substring(0,2));
    int minutes_start = int.parse(timeStartEnd.starttime.substring(3,5));
    int seconds_start = int.parse(timeStartEnd.starttime.substring(6,8));

    var startDate = new DateTime(year_start, month_start, day_start, hour_start, minutes_start, seconds_start);

    int year_end = int.parse(regulatedPeriod.end.substring(0,4));
    int month_end = int.parse(regulatedPeriod.end.substring(5,7));
    int day_end = int.parse(regulatedPeriod.end.substring(8,10));

    int hour_end = int.parse(timeStartEnd.endtime.substring(0,2));
    int minutes_end = int.parse(timeStartEnd.endtime.substring(3,5));
    int seconds_end = int.parse(timeStartEnd.endtime.substring(6,8));

    var endDate = new DateTime(year_end, month_end, day_end, hour_end, minutes_end, seconds_end);

    bool insideInterval = now.isAfter(startDate) && now.isBefore(endDate);

    return insideInterval;
  }
    
}