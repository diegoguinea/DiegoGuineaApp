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