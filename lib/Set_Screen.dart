import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final proVar = Provider.of<WeatherProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.blueAccent],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 30,
            )),
        shape: Border(bottom: BorderSide(width: 1)),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
          colors: [
            Colors.blue,
            Colors.blueAccent,
            Colors.purpleAccent,
          ],
        )),
        child: Column(
          children: [
            Container(
              height: 150,
              width: width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 1,
                    color: (proVar.getTheme == false)
                        ? Colors.black87
                        : Colors.white70)
              ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (proVar.isTheme == false)
                        ? Text(
                            'Theme',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w400),
                          )
                        : Text(
                            'Dark Theme',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w400),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: DayNightSwitch(
                          value: proVar.getTheme,
                          moonImage: AssetImage('assets/images/moon.png'),
                          sunImage: AssetImage('assets/images/sun.png'),
                          sunColor: Color(0xFFFDB813),
                          moonColor: Color(0xFFf5f3ce),
                          dayColor: Color(0xFF87CEEB),
                          nightColor: Color(0xFF003366),
                          onChanged:(value) {proVar.setTheme = value;
                          proVar.setThemeSharePrefrence(value);
                          }),
                    )
                    // Switch(
                    //     dragStartBehavior: DragStartBehavior.start,
                    //     value: proVar.getTheme,
                    //     onChanged: (value) {
                    //       proVar.setTheme = value;
                    //       proVar.setThemeSharePrefrence(value);
                    //     })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
