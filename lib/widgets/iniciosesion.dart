
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_project/widgets/map.dart';
import 'package:flutter_project/datamodels/users.dart';

class loginclass extends StatefulWidget{
  static const String routeName = '/loginclass';
  @override
  _myloginclass createState() => new _myloginclass();
}

class _myloginclass extends State<loginclass>{

  bool _isSelected = false;

  void _radio(){
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
  width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 2.0,color: Colors.black)
    ),
    child: isSelected ? Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
       shape: BoxShape.circle,
        color: Colors.black,
      ),
    )
        : Container(),
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
     return new Scaffold(
       backgroundColor: Colors.white,
       resizeToAvoidBottomPadding: true,
       appBar: AppBar(
         title: Text("Iniciar sesion"),
           backgroundColor: Color.fromRGBO(47, 180, 233, 1),
             centerTitle: true,
        ),
       drawer: AppDrawer(),
       body:  Stack(
         fit: StackFit.expand,
         children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(top:20.0),
                 //child: Image.asset('assets/logoblancoazul2.png'),
               ),
               Expanded(
                 child: Container(),
               ),
               //Image.asset('assets/logoblancoazul.png'),
             ],
           ),
           SingleChildScrollView(
             child: Padding(
               padding: EdgeInsets.only(left: 28.0,right: 28.0,top: 60.0),
               child: Column(
                 children: <Widget>[
                  /* Row(
                     children: <Widget>[
                       Image.asset('assets/logoblancoazul2.png',
                         width: ScreenUtil().setWidth(110),
                          height: ScreenUtil().setHeight(110),),
                       Text("LOGO",style: TextStyle(fontFamily: "Poppins-Bold"),)
                     ],
                   ),*/ //LOGO
                   SizedBox(
                     height: ScreenUtil().setHeight(100),
                   ),
                   Container(
                     width: double.infinity,
                     height: ScreenUtil().setHeight(500),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(8.0),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black12,
                           offset: Offset(0.0,15.0),
                           blurRadius: 15.0
                         ),
                         BoxShadow(
                             color: Colors.black12,
                             offset: Offset(0.0,-10.0),
                             blurRadius: 10.0
                         )
                       ]),
                     child: Padding(
                       padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text("Login",style: TextStyle(
                             fontSize: ScreenUtil().setSp(45),
                             fontFamily: "Poppins-Bold",
                             letterSpacing: .6,
                           ),),
                           SizedBox(
                             height: ScreenUtil().setHeight(30),
                           ),
                           Text("Email",style: TextStyle(
                             fontFamily: "Poppins-Bold",
                             fontSize:  ScreenUtil().setSp(26),
                           ),),
                           TextField(
                             controller: emailController,
                             decoration: InputDecoration(
                               hintText: "email",
                               hintStyle: TextStyle(
                                 color: Colors.grey, fontSize: 12.0,
                               ),
                             ),
                           ),
                           SizedBox(
                             height: ScreenUtil().setHeight(30),
                           ),
                           Text("Password",style: TextStyle(
                             fontFamily: "Poppins-Bold",
                             fontSize:  ScreenUtil().setSp(26),
                           ),),
                           TextField(
                             controller: passwordController,
                             obscureText: true,
                             decoration: InputDecoration(
                               hintText: "Password",
                               hintStyle: TextStyle(
                                 color: Colors.grey, fontSize: 12.0,
                               ),
                             ),
                           ),
                           SizedBox(
                             height: ScreenUtil().setHeight(35),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: <Widget>[
                               Text("Forgot Password?",style: TextStyle(
                                 color: Colors.blue,
                                 fontFamily: "Poppins-Medium",
                                 fontSize: ScreenUtil().setSp(28)
                               ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: ScreenUtil().setHeight(40),),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                      /* Row(
                         children: <Widget>[
                           SizedBox(
                             width: 12.0,
                           ),
                           GestureDetector(
                             onTap: _radio,
                             child: radioButton(_isSelected),
                           ),
                           SizedBox(
                             width: 8.0,
                           ),
                           Text("Remember me",style: TextStyle(fontSize: 12, fontFamily: "Poppins-Medium" ),),
                         ],
                       ),*/ //recordar password
                       InkWell(
                         child: Container(
                           width: ScreenUtil().setWidth(330),
                           height: ScreenUtil().setHeight(100),
                           decoration: BoxDecoration(
                               gradient: LinearGradient(
                                   colors: [
                                     Color(0xFF17ead1),
                                     Color(0xFF6078ea),

                                   ]
                               ),
                               borderRadius: BorderRadius.circular(6.0),
                               boxShadow: [
                                 BoxShadow(
                                     color: Color(0xFF6078ea).withOpacity(.3),
                                     offset: Offset(0.0,8.0),
                                     blurRadius: 8.0
                                 ),
                               ]
                           ),
                           child: Material (
                             color: Colors.transparent,
                             child: InkWell(
                               onTap: (){
                                 //TODO: AQUI MANDAMOS PSW A LA API
                                 _auth(emailController.text, passwordController.text);
                               },
                               child: Center(
                                 child: Text("Sing in",style: TextStyle(color: Colors.white,
                                     fontFamily: "Poppins-Bold",
                                     fontSize: 18,
                                     letterSpacing: 1.0),),
                               ),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: ScreenUtil().setHeight(40),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       horizontalLine(),
                       //Text("Social Login",st)
                     ],
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     );
  }
  _auth(String email, String password)async{
  print("email:" + email);

    Map data = {
      'email' : email,
      'password' : password,
    };
    var jsonData = null;
    print("data:" + data.toString());
    print("api:" + Constants.API_POST_AUTH);
    var response = await http.post(Constants.API_POST_AUTH, body: JsonEncoder().convert(data),
      headers: {HttpHeaders.authorizationHeader: Constants.PUBLIC_TOKEN,
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = json.decode(response.body);
      users usuarios = users.fromJson(jsonData);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences.setString("token", usuarios.token);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MapPage()), (Route<dynamic> route) => false);
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
}