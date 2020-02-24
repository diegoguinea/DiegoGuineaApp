import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';
import 'package:timezone/standalone.dart';

class Utils {

  bool isInsideInterval(RegulatedPeriod regulatedPeriod, String project_tz){

    var current_location_tz = getLocation(project_tz);

    //fecha de ahora
    var now = new TZDateTime.now(current_location_tz);
    //dia de la semana actual en string (restamos un dia porque para nosotros el lunes es 0)
    int current_week_day = now.weekday - 1; //el 0 --> dilluns
    String str_week_day = current_week_day.toString();

    //del hashmap de dies de la semana, seleccionamos el dia de hoy
    int year_start = int.parse(regulatedPeriod.start.substring(0,4));
    int month_start = int.parse(regulatedPeriod.start.substring(5,7));
    int day_start = int.parse(regulatedPeriod.start.substring(8,10));

    var startDateUtc = new DateTime.utc(year_start, month_start, day_start, 0, 0, 0);
    var startDate = new TZDateTime.from(startDateUtc, current_location_tz);

    int year_end = int.parse(regulatedPeriod.end.substring(0,4));
    int month_end = int.parse(regulatedPeriod.end.substring(5,7));
    int day_end = int.parse(regulatedPeriod.end.substring(8,10));
    var endDateUtc = new DateTime.utc(year_end, month_end, day_end, 0, 0, 0);
    var endDate = new TZDateTime.from(endDateUtc, current_location_tz);

    bool insideInvertal = now.isAfter(startDate) && now.isBefore(endDate);

    bool insideDayWeekHours;

    if(insideInvertal){
      TimeStartEnd timeStartEnd = regulatedPeriod.days_of_the_week[str_week_day];
      int hour_start = int.parse(timeStartEnd.starttime.substring(0,2));
      int minutes_start = int.parse(timeStartEnd.starttime.substring(3,5));
      int seconds_start = int.parse(timeStartEnd.starttime.substring(6,8));
      var startTimeInUtc = new DateTime.utc(now.year, now.month, now.day, hour_start, minutes_start, seconds_start);
      var startDayWeekHours = new TZDateTime.from(startTimeInUtc, current_location_tz);

      int hour_end = int.parse(timeStartEnd.endtime.substring(0,2));
      int minutes_end = int.parse(timeStartEnd.endtime.substring(3,5));
      int seconds_end = int.parse(timeStartEnd.endtime.substring(6,8));
      var endTimeInUtc = new DateTime.utc(now.year, now.month, now.day, hour_end, minutes_end, seconds_end);
      var endDayWeekHours = new TZDateTime.from(endTimeInUtc, current_location_tz);

      insideDayWeekHours = now.isAfter(startDayWeekHours) && now.isBefore(endDayWeekHours);

    }

    return insideDayWeekHours;
  }

  TZDateTime getStartTimeTz(RegulatedPeriod regulatedPeriod, String str_weekday, String project_tz){
    var current_location_tz = getLocation(project_tz);

    //horari segons dia de la setmana
    var now = new TZDateTime.now(current_location_tz);

    //int current_week_day = now.weekday - 1; //el 0 --> dilluns
    //String str_week_day = current_week_day.toString();

    var dateTz;

    TimeStartEnd timeStartEnd = regulatedPeriod.days_of_the_week[str_weekday];
    if(timeStartEnd != null){
      int hour = int.parse(timeStartEnd.starttime.substring(0,2));
      int minutes = int.parse(timeStartEnd.starttime.substring(3,5));
      int seconds = int.parse(timeStartEnd.starttime.substring(6,8));
      var dateUtc = new DateTime.utc(now.year, now.month, now.day, hour, minutes, seconds);
      dateTz = new TZDateTime.from(dateUtc, current_location_tz);
    }
    return dateTz;
  }

  TZDateTime getEndTimeTz(RegulatedPeriod regulatedPeriod, String str_weekday, String project_tz){
    var current_location_tz = getLocation(project_tz);

    //horari segons dia de la setmana
    var now = new TZDateTime.now(current_location_tz);
    var dateTz;

    TimeStartEnd timeStartEnd = regulatedPeriod.days_of_the_week[str_weekday];
    if(timeStartEnd != null){
      int hour = int.parse(timeStartEnd.endtime.substring(0,2));
      int minutes = int.parse(timeStartEnd.endtime.substring(3,5));
      int seconds = int.parse(timeStartEnd.endtime.substring(6,8));
      var dateUtc = new DateTime.utc(now.year, now.month, now.day, hour, minutes, seconds);
      dateTz = new TZDateTime.from(dateUtc, current_location_tz);
    }
    return dateTz;
  }


  String twoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  String horario_start_end_tz(RegulatedPeriod regulatedPeriod, String str_weekday, String project_tz){
    TZDateTime startTimeTz = getStartTimeTz(regulatedPeriod, str_weekday, project_tz);
    TZDateTime endTimeTz = getEndTimeTz(regulatedPeriod, str_weekday, project_tz);
    String start = "";
    String end= "";
    if(startTimeTz != null){
      start = startTimeTz.hour.toString() + ":" + twoDigits(startTimeTz.minute);
    } else {
      start = " - ";
    }
    if(endTimeTz != null){
      end = endTimeTz.hour.toString() + ":" + twoDigits(endTimeTz.minute);
    } else {
      end = " - ";
    }
    String horario =  start + "/" + end ;
    return horario;
  }
}