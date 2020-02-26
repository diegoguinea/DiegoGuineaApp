import 'package:flutter/cupertino.dart';

class multilang {
  final String nombrelang;

  multilang(this.nombrelang);

  static const LocalizationsDelegate<multilang> delegate = _multilangDelegate();

  String get titulomap{
    if(nombrelang == 'en'){
      return "Regulated Parking Spaces";
    } if (nombrelang == 'es'){
      return "Plazas de Parking Reguladas";
    }
  }
  String get mapa{
    if(nombrelang == 'en'){
      return "Map";
    } if (nombrelang == 'es'){
      return "Mapa";
    }
  }
  String get informacion{
    if(nombrelang == 'en'){
      return "Information";
    } if (nombrelang == 'es'){
      return "Informacion";
    }
  }
  String get ajustes{
    if(nombrelang == 'en'){
      return "Settings";
    } if (nombrelang == 'es'){
      return "Ajustes";
    }
  }
  String get anadir{
    if(nombrelang == 'en'){
      return "Add City/Spot type";
    } if (nombrelang == 'es'){
      return "Añadir ciudad/Tipo de parking";
    }
  }
  String get inicio{
    if(nombrelang == 'en'){
      return "Log in";
    } if (nombrelang == 'es'){
      return "Iniciar sesion";
    }
  }
  String get crearcuenta{
    if(nombrelang == 'en'){
      return "Create Acount";
    } if (nombrelang == 'es'){
      return "Crear Cuenta";
    }
  }
  String get localizacion{
    if(nombrelang == 'en'){
      return "Location";
    } if (nombrelang == 'es'){
      return "Localizacion";
    }
  }
  String get abrirajustesloc{
    if(nombrelang == 'en'){
      return "Open loation settings";
    } if (nombrelang == 'es'){
      return "Abrir ajustes de localizacion";
    }
  }
  String get fechas{
    if(nombrelang == 'en'){
      return "Dates        ";
    } if (nombrelang == 'es'){
      return "Fecha       ";
    }
  }
  String get horarios{
    if(nombrelang == 'en'){
      return "Time table";
    } if (nombrelang == 'es'){
      return "Horarios";
    }
  }
  String get ciudad{
    if(nombrelang == 'en'){
      return 'City                 ';
    } if (nombrelang == 'es'){
      return 'Ciudad               ';
    }
  }
  String get num_spots{
    if(nombrelang == 'en'){
      return 'Num Spots';
    } if (nombrelang == 'es'){
      return 'Num Spots';
    }
  }
  String get tiempomax{
    if(nombrelang == 'en'){
      return 'Max time:  ';
    } if (nombrelang == 'es'){
      return 'Tiempo maximo:   ';
    }
  }
  String get precio{
    if(nombrelang == 'en'){
      return 'Price:  ';
    } if (nombrelang == 'es'){
      return 'Precio   ';
    }
  }
  String get dia{
    if(nombrelang == 'en'){
      return 'Day';
    } if (nombrelang == 'es'){
      return 'Dia';
    }
  }
  String get lunes{
    if(nombrelang == 'en'){
      return 'Monday';
    } if (nombrelang == 'es'){
      return 'Lunes';
    }
  }
  String get martes{
    if(nombrelang == 'en'){
      return 'Tuesday';
    } if (nombrelang == 'es'){
      return 'Martes';
    }
  }
  String get miercoles{
    if(nombrelang == 'en'){
      return 'Wednesday';
    } if (nombrelang == 'es'){
      return 'Miercoles';
    }
  }
  String get jueves{
    if(nombrelang == 'en'){
      return 'Thursday';
    } if (nombrelang == 'es'){
      return 'Jueves';
    }
  }
  String get viernes{
    if(nombrelang == 'en'){
      return 'Friday';
    } if (nombrelang == 'es'){
      return 'Viernes';
    }
  }
  String get sabado{
    if(nombrelang == 'en'){
      return 'Saturday';
    } if (nombrelang == 'es'){
      return 'Sabado';
    }
  }
  String get domingo{
    if(nombrelang == 'en'){
      return 'Sunday';
    } if (nombrelang == 'es'){
      return 'Domingo';
    }
  }
}

class _multilangDelegate extends LocalizationsDelegate<multilang> {
  const _multilangDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['es','en'].contains(locale.languageCode);
  }

  @override
  Future<multilang> load(Locale locale) async {
    return multilang(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<multilang> old) {
    return false;
  }

}