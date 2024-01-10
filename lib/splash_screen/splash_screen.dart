import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tracking_app/view/world_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override


  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>World_status()));
    });
  }
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                   AnimatedBuilder(
                       animation: _controller,
                       child: Container(
                         height: 200.0,
                         width: 200.0,
                         child: Center(
                           child: Image(image: AssetImage('assest/images/virus2.png')),
                         ),
                       ),
                       builder: (BuildContext context,Widget?child){
                         return Transform.rotate(
                             angle: _controller.value*2.0*math.pi,
                           child: child,

                         );
                       }),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            Align(
                alignment: Alignment.center,
                child: Text('Covid-19\nTracker app',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
                color: Colors.white),))

          ],
        ),
      ),
    );
  }
}
