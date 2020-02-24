import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/datamodels/infoRegulatedSpot.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/datamodels/regulatedSpots.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/utils/utils.dart';
import 'package:flutter_project/Routes.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart' as tz;

class MapPage extends StatelessWidget{


  static const String routeName = '/map';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text("Plazas de Parking Reguladas"),backgroundColor: Color.fromRGBO(47, 180, 233, 1),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: MapScreen());
  }
}

class MapScreen extends StatefulWidget{
  @override
  State<MapScreen> createState()=> MapScreenState();
}


class MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _urbioticaLocation = CameraPosition(
    target: LatLng(Constants.LAT_URBIOTICA, Constants.LON_URBIOTICA),
    zoom: Constants.INITIAL_ZOOM,
  );

  LocationData _currentLocation;
  var location;
  StreamSubscription<LocationData> _locationSubscription;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  BitmapDescriptor pmrIcon;
  BitmapDescriptor cdIcon;
  BitmapDescriptor otherIcon;
  Project project;


  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();

    //actualitzacio automatica de la ubicacio a traves del SetState
    _locationSubscription = location.onLocationChanged().listen((
        LocationData currentLocation) async {
        _currentLocation = currentLocation;
    });

    //els icones s'han de definir abans no es crei el mapa perque es vegin be
    _createCustomIcons();
  }


  //First, create a method that handles the asset path and receives a size (this can be either the width, height, or both, but using only one will preserve ratio).
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer
        .asUint8List();
  }

  // Puntos de interes
  Future<Project> getRegulatedSpots() async {
    final response = await http.get(Constants.API_GET_REGULATED_SPOTS,
      headers: {HttpHeaders.authorizationHeader: Constants.PUBLIC_TOKEN},);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      ListProjects responseJson = ListProjects.fromJson(jsonResponse);
      return responseJson.listProjects[0];
    } else {
      throw Exception('No pudieron cargarse los datos:' + response.body);
    }
  }

  void _createCustomIcons() async {
    int iconSize = 100;

    final Uint8List pmrMarker = await getBytesFromAsset(
        'assets/icons/parking_minus.png', iconSize);
    pmrIcon = BitmapDescriptor.fromBytes(pmrMarker);


    final Uint8List cdMarker = await getBytesFromAsset(
        'assets/icons/parking_carga.png', iconSize);
    cdIcon = BitmapDescriptor.fromBytes(cdMarker);

    final Uint8List otherMarker = await getBytesFromAsset(
        'assets/icons/parking.png', iconSize);
    otherIcon = BitmapDescriptor.fromBytes(otherMarker);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _googleMap(context)
        ],
      ),
      //boto que serveix per mostrar markers en una altra posicio. De moment no el necessitem, pero com a exemple
      /* floatingActionButton: FloatingActionButton(
          child: Icon(Icons.local_parking),
          onPressed: () {
            _onAddMarkerButtonPressed();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
*/
    );
  }


  Widget _googleMap(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _urbioticaLocation,
        myLocationEnabled: true,
        markers: markers.values.toSet(),
      ),
    );
  }


  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    //crida API urbiotica
    project = await getRegulatedSpots();

    //update dels marcadors
    setState(() {
      markers.clear();
      _parkingToMarkers(project);

    });

    try {
      _currentLocation = await location.getLocation();

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: Constants.INITIAL_ZOOM,
        ),
      ));

      //si l'usuari no dona permisos d'ubicacio
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        if (project != null) {
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0,
              target: LatLng(
                  project.project_center.lat, project.project_center.lon),
              zoom: Constants.INITIAL_ZOOM,
            ),
          ));
        } else { //si no hi ha permisos de GPS i no hi ha dades de projectes
          controller.animateCamera(CameraUpdate.newCameraPosition(
            _urbioticaLocation,
          ));
        }
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  //CON ESTA MANERA ASIGNAMOS UNA ICONO SEGUN SEA CARGA DESCARGA,PLAZA MINUSVALIDO O PARKING NORMAL //
  ////////////////////////////////////////////////////////////////////////////////////////////////////


  void _parkingToMarkers(Project puntos) {
    List<RegulatedSpots> listRegulatedSpots = puntos.list_regulated_spots;

    for (var i = 0; i < listRegulatedSpots.length; i++) {
      BitmapDescriptor customIcon;

      String address = "";
      if (listRegulatedSpots[i].address != null) {
        address = listRegulatedSpots[i].address;
      }
      //assignem icona segons spot type
      if (customIcon == null && listRegulatedSpots[i].spot_type.name == "C/D") {
        customIcon = cdIcon;
      } else
      if (customIcon == null && listRegulatedSpots[i].spot_type.name == "PRM") {
        customIcon = pmrIcon;
      } else {
        customIcon = otherIcon;
      }

      Marker marker = Marker(

        icon: (customIcon),
        onTap: (){
          _pressmarker(listRegulatedSpots[i].pom_id.toString());
        },
        markerId: MarkerId(listRegulatedSpots[i].pom_id.toString()),
        infoWindow: InfoWindow(
            title: listRegulatedSpots[i].name, snippet: address),
        position: LatLng(listRegulatedSpots[i].location.lat,
            listRegulatedSpots[i].location.lon), //lat i lon
      );
      //afegim el marker a la variable global markers
      markers[marker.markerId] = marker;
    }
  }
// TODO: Aqui definimos la informacion que damos cuando presionamos el icono

   _pressmarker(String pomid) async {

     initializeTimeZones();

     final response = await http.get(Constants.API_GET_POM_ID + pomid,
      headers: {HttpHeaders.authorizationHeader: Constants.PUBLIC_TOKEN},);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      ProjectIndividualSpot project = ProjectIndividualSpot.fromJson(jsonResponse);

      _showinfo(project);

    } else {
      throw Exception('No pudieron cargarse los datos:' + response.body);
    }
  }

   _preciohora(TimePeriodType timePeriodType, bool currentperiod){
      String resultado = "";
      if(currentperiod) {
        if (timePeriodType.period_type_id == 3) {
          resultado = "Max time:  " + timePeriodType.value + " min";
        } else if (timePeriodType.period_type_id == 2) {
          resultado = "Price  " + timePeriodType.value + " €/h";
        }
      }
      return resultado;
   }

   //obtenemos el horario a mostrar en el bottom sheet segun el dia de hoy
   _horario(RegulatedPeriod regulatedPeriod, String project_tz){
       Utils utils = new Utils();

       var current_location_tz = tz.getLocation(project_tz);
       var now = new tz.TZDateTime.now(current_location_tz);
       int current_week_day = now.weekday - 1; //el 0 --> dilluns

       String horario = utils.horario_start_end_tz(regulatedPeriod, current_week_day.toString() , project_tz);
       String text = "Current Regulated Period:   "  + horario;

       return text;
    }

  _showinfo(ProjectIndividualSpot project) {
    Utils utils = new Utils();
    var regulatedPeriodWidgets = List<Widget>();
    var currentperiodWidget = List<Widget>();
    bool insideCurrentRegulatedPeriod;

    for (RegulatedPeriod regulatedPeriod in project.regulated_spots.list_regulated_periods) {
      //miramos si la hora actual esta dentro del periodo regulado de la plaza de parking
      bool insideCurrentRegulatedPeriod = utils.isInsideInterval(
          regulatedPeriod, project.project_timezone);

      String currentperiod = "";
      if (insideCurrentRegulatedPeriod) { //solo ponemos el texto "Current Regulated Period: None" si no hay ninguna otra información
        currentperiod = _horario(regulatedPeriod, project.project_timezone);
      } else if (!insideCurrentRegulatedPeriod && currentperiodWidget.isEmpty) {
        currentperiod = "Current Regulated Period: None";
      }

      currentperiodWidget.add(
        new Row(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(left: 25)),
            Text(currentperiod, style: TextStyle(color: Colors.white),),
          ],
        ),
      );

      if(insideCurrentRegulatedPeriod){
        //creamos una lista de widgets que depende de cuantos "time_period_types" tenemos. Para cada ptime_period_types, añadimos un widget.
        for(TimePeriodType timePeriodType in regulatedPeriod.time_period_types){
          String resultado = _preciohora(timePeriodType, insideCurrentRegulatedPeriod);
          if(resultado != "") {  //sino añade una row con el texto vacio
            regulatedPeriodWidgets.add(
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(left: 50)),
                  Text(resultado, style: TextStyle(color: Colors.white),),
                ],
              ),
            );
          }
        }
      }


    }

    showBottomSheet(context: context, builder: (builder){
       return Container(
          height: 200,
          width: double.infinity,
          color: Color.fromRGBO(47, 180, 233, 1),
          child: SingleChildScrollView(
            child : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(left: 25)),
                    Container(
                        child:  Text(project.regulated_spots.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),)
                    ),
                    SizedBox(width: 180),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.keyboard_arrow_down,size: 35,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(left: 25)),
                    Container(
                      child: Text(project.regulated_spots.occupation.max_capacity.toString() + ' spots ' + project.regulated_spots.spot_type.name,style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic)),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(children: currentperiodWidget,),
                SizedBox(height: 10,),
               Column(children: regulatedPeriodWidgets,),
                SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    RaisedButton(

                      color: Color.fromRGBO(47, 180, 233, 1),
                      child: Text('MORE INFO',style: TextStyle(color: Colors.white),),
                      onPressed: (){
                          Navigator.pushNamed(
                            context,
                            Routes.moreinfo,
                            arguments: MoreInfoArguments(
                              project.project_name,
                              project.project_timezone,
                              project.regulated_spots.name,
                              project.regulated_spots.occupation.max_capacity,
                              project.regulated_spots.list_regulated_periods,
                            ),
                          );

                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
      );
    });


  }
}
class MoreInfoArguments{
  String project_name;
  String project_tz;
  String name;
  int max_capacity;
  List<RegulatedPeriod> list_regulated_periods;
  MoreInfoArguments(this.project_name, this.project_tz, this.name, this.max_capacity, this.list_regulated_periods);
}