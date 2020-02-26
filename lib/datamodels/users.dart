class users{
  int user_id;
  String name;
  String token;
  List<pruser> listpruser;


  users({this.user_id,this.name,this.token,this.listpruser});

  factory users.fromJson(Map<String, dynamic> json){

    if(json['projects'] != null){
      var listpruser = json['projects'] as List;
      return users(
        user_id: json['user_id'],
        name: json['name'],
        token: json['token'],
        listpruser: listpruser.map((tagJson)=> pruser.fromJson(tagJson)).toList(),
      );
    } else {
      return users(
        user_id: json['user_id'],
        name: json['name'],
        token: json['token'],
      );
    }


  }

}

class pruser{
  String name;
  String project_id;
  List<spotype> spot_types;

  pruser({this.name,this.project_id,this.spot_types});

  factory pruser.fromJson(Map<String, dynamic> json){

    if(json['spot_types'] != null){
      var spot_types = json['spot_types'] as List;
      return pruser(
        name: json['name'],
        project_id: json['project_id'],
        spot_types: spot_types.map((tagJson)=> spotype.fromJson(tagJson)).toList(),
      );
    } else {
      return pruser(
        name: json['name'],
        project_id: json['project_id'],
      );
    }


  }

}

class spotype{
  int spot_type_id;
  String name;
  String description;
  SpotTypeInfo spot_type_info;

  spotype({this.spot_type_id,this.name,this.description,this.spot_type_info});

  factory spotype.fromJson(Map<String, dynamic> json){
    return spotype(
      spot_type_id: json['spot_type_id'],
      name: json['name'],
      description: json['description'],
      spot_type_info: SpotTypeInfo.fromJson(json['spot_type_info']),
    );
  }

}

class SpotTypeInfo{
  String user_nif;
  String matricula;
  String num_targeta;

  SpotTypeInfo({this.user_nif,this.matricula,this.num_targeta});
  factory SpotTypeInfo.fromJson(Map<String, dynamic> json){
    return SpotTypeInfo(
      user_nif: json['user_nif'],
      matricula: json['matricula'],
      num_targeta: json['num_targeta'],
    );
  }

}