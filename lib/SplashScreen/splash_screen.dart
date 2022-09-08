import 'package:flutter/material.dart';
import 'package:skynetsecurity/Screens/home_page.dart';
import '../Screens/home.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  int splashtime = 3;


  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context){
            return const HomePage();
          }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body:Container(
            alignment: Alignment.center,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  SizedBox(
                      height:200,width:200,
                      child:Image.asset("assets/images/logo.png")
                  ),
                  Container(
                    margin: EdgeInsets.only(top:30),
                    //margin top 30
                    child:const Text("SkyNet Matrix", style: TextStyle(
                      fontSize: 30,color: Colors.white,
                    ),),
                  ),
                  // Container(
                  //   margin:EdgeInsets.only(top:15),
                  //   child:Text("Version: 1.0.0", style:TextStyle(
                  //     color:Colors.black45,
                  //     fontSize: 20,
                  //   )),
                  // ),
                ]
            )
        )
    );
  }
}