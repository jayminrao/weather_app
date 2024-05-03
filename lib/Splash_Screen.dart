import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Ahmedabad',),), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://user-images.githubusercontent.com/55695328/131248428-ce7c7cbd-e199-4fb1-a242-73bc903a3703.jpeg'),fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: Text(
                'Music App',
                style: TextStyle(
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}