import 'dart:collection';
import 'dart:ffi';

import 'package:flutter_project/datamodels/regulatedSpots.dart';

class ProjectIndividualSpot{
  String project_id;
  String project_name;
  String project_timezone;
  Coordinates project_center;
  infoRegulatedSpots regulated_spots;


  ProjectIndividualSpot({this.project_id,this.project_name,this.project_timezone,this.project_center,this.regulated_spots});


  factory ProjectIndividualSpot.fromJson(Map<String, dynamic> json){


      return ProjectIndividualSpot(
        project_id: json['project_id'],
        project_name: json['project_name'],
        project_timezone: json['project_timezone'],
        project_center: Coordinates.fromJson(json['project_center']),
        regulated_spots: infoRegulatedSpots.fromJson(json['regulated_spot'])
      );

  }
}
class infoRegulatedSpots{
  int pom_id;
  String name;
  String address;
  int location_type_id;
  Coordinates location;
  propiedades_spot spot_type;
  capacidad occupation;
  List<RegulatedPeriod> list_regulated_periods;

  infoRegulatedSpots({this.pom_id,this.name,this.address,this.location_type_id,this.location,this.spot_type,this.occupation,this.list_regulated_periods});

  factory infoRegulatedSpots.fromJson(Map<String, dynamic> json){
    if(json['regulated_periods'] != null){

      var listRegulated = json['regulated_periods'] as List;

      return infoRegulatedSpots(
        pom_id: json['pom_id'],
        name: json['name'],
        address: json['address'],
        location_type_id: json['location_type_id'],
        location: Coordinates.fromJson(json['location']),
        spot_type: propiedades_spot.fromJson(json['spot_type']),
        occupation: capacidad.fromJson(json['occupation']),
        list_regulated_periods: listRegulated.map((tagJson)=> RegulatedPeriod.fromJson(tagJson)).toList(),
      );
    } else {
        return infoRegulatedSpots(
        pom_id: json['pom_id'],
        name: json['name'],
        address: json['address'],
        location_type_id: json['location_type_id'],
        location: Coordinates.fromJson(json['location']),
        spot_type: propiedades_spot.fromJson(json['spot_type']),
        occupation: capacidad.fromJson(json['occupation']),
    );
    }
  }
}
class RegulatedPeriod{
  int time_period_id;
  String title;
  String start;
  String end;
  String timezone;
  List<TimePeriodType> time_period_types;
  Map<String,TimeStartEnd> days_of_the_week;

  RegulatedPeriod({this.time_period_id,this.title,this.start,this.end,this.timezone,this.time_period_types, this.days_of_the_week});

  factory RegulatedPeriod.fromJson(Map<String, dynamic> json){
    if(json['time_period_types'] != null){

      var listRegulated = json['time_period_types'] as List;
      var listDaysWeek = new Map.from(json['days_of_the_week']) ;

      return RegulatedPeriod(
        time_period_id: json['time_period_id'],
        title: json['title'],
        start: json['start'],
        end: json['end'],
        timezone: json['timezone'],
        time_period_types: listRegulated.map((tagJson)=> TimePeriodType.fromJson(tagJson)).toList(),
        days_of_the_week: listDaysWeek.map( (key, value) => new MapEntry<String, TimeStartEnd>(key, TimeStartEnd.fromJson(value))),


      );
    } else {
      return RegulatedPeriod(
        time_period_id: json['time_period_id'],
        title: json['title'],
        start: json['start'],
        end: json['end'],
        timezone: json['timezone'],

      );
    }
  }
}

class TimePeriodType {
  int period_type_id;
  String name;
  String description;
  String value;
  int time_periods_types_id;

  TimePeriodType({this.period_type_id,this.name,this.description,this.value,this.time_periods_types_id});

  factory TimePeriodType.fromJson(Map<String, dynamic> json){
    return TimePeriodType(
      period_type_id: json['period_type_id'],
      name: json['name'],
      description: json['description'],
      value: json['value'],
      time_periods_types_id: json['time_periods_types_id'],
    );
  }
}



class TimeStartEnd {
  
  String starttime;
  String endtime;

  TimeStartEnd({this.starttime,this.endtime});

  factory TimeStartEnd.fromJson( Map<String, dynamic> json){

    return TimeStartEnd(
      starttime: json['start_time'],
      endtime: json['end_time'],
    );
  }
}