import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Splash_Screen.dart';
import 'Api_call.dart';
import 'Model_Class.dart';
import 'Provider.dart';
import 'Search_Screen.dart';
import 'Set_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider(),)
      ],
      child: Consumer<WeatherProvider>(
          builder: (context,proVar,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: (proVar.getTheme==false)?ThemeData.light():ThemeData.dark(),
              home: SplashScreen(),
            );
          }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isload = false;
  WeatherModel? weather;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isload = true;
    });
    apiCalling().loadApiData(widget.title).then((value) {
      weather = value;
      setState(() {
        isload = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final proVar = Provider.of<WeatherProvider>(context,listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        title: Text('HOME',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
        ),),
        toolbarHeight: 60,
        actions: [
          IconButton(onPressed: (){
            searchList.add(StoreData(weather!.location!.name!, weather!.location!.tzId, weather!.current!.tempC.toString(), weather!.current!.tempF.toString(), weather!.current!.condition!.icon));
            print(searchList);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen(city: weather!.location!.name!,tid: weather!.location!.tzId!, tempc: weather!.current!.tempC.toString(),tempf: weather!.current!.tempF.toString(),Icon: weather!.current!.condition!.icon!,tags: 1),));}, icon: Icon(Icons.search,size: 30,)),
          IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingScreen(),));}, icon: Icon(Icons.menu,size: 30,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
            )
          ),
          child: Center(
              child: (isload == true)
                  ? CircularProgressIndicator()
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 1,
                  child: Column(
                    children: [
                      SizedBox(height: 17,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined,size: 30,),
                          Text('${weather!.location!.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 26,
                              )),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        weather!.current!.lastUpdated!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                              "https:" + weather!.current!.condition!.icon!,height: 100,),
                          (proVar.getTemp == false)? Text(
                            '${weather!.current!.tempC.toString()}°C',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w600,
                            ),
                          ):Text('${weather!.current!.tempF.toString()}°F',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w600,
                            ),),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '${weather!.current!.windKph}°/ ${weather!.current!.feelslikeC}° Feels like ${weather!.current!.feelslikeC}°',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '${weather!.current!.condition!.text}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Divider( endIndent: 10,
                        indent: 10,
                        thickness: 3,),
                      SizedBox(height: 8,),
                      Container(
                        height: 400,
                        width: width,
                        child: ListView.builder(
                          itemCount: weather!.forecast!.forecastday![1].hour!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 8,
                                          blurStyle: BlurStyle.outer,
                                          spreadRadius: 1,
                                          color:(proVar.getTheme == false)?Colors.black87:Colors.white70
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(weather!.forecast!.forecastday![1].hour![index].time!,style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                        Container(
                                          width: 135,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.network("https:" +
                                                  weather!.forecast!.forecastday![1].hour![index].condition!.icon!),
                                              SizedBox(width: 6,),
                                              (proVar.getTemp == false)? Text(
                                                '${weather!.forecast!.forecastday![1].hour![index].tempC.toString()}°C',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ):Text('${weather!.forecast!.forecastday![1].hour![index].tempF.toString()}°F',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ]  ),
                                ),
                              ),
                            );
                          },
                          // scrollDirection: Axis.horizontal,
                          // itemCount: weather!.forecast!.forecastday!.length,
                          // itemBuilder: (context, index) {
                          //   return Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: InkWell(
                          //       onTap: (){
                          //         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HourlyScreen(hour: weather!.forecast!.forecastday![index].hour),));
                          //       },
                          //       child: Container(
                          //         height: 160,
                          //         width: 130,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(15),
                          //             boxShadow: [
                          //               BoxShadow(
                          //                   blurRadius: 8,
                          //                   blurStyle: BlurStyle.outer,
                          //                   spreadRadius: 1,
                          //                   color:(proVar.getTheme == false)?Colors.black87:Colors.white70
                          //               )
                          //             ]
                          //         ),
                          //         child: Center(
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //               MainAxisAlignment.spaceAround,
                          //               children: [
                          //                 Text(
                          //                   weather!.forecast!.forecastday![index]
                          //                       .date!,
                          //                   style: TextStyle(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.w500),
                          //                 ),
                          //                 Image.network("https:" +
                          //                     weather!.current!.condition!.icon!),
                          //                 (proVar.getTemp==false)?   Text(
                          //                   weather!.forecast!.forecastday![index]
                          //                       .day!.maxtempC
                          //                       .toString(),
                          //                   style: TextStyle(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.w500),
                          //                 ): Text(
                          //                   weather!.forecast!.forecastday![index]
                          //                       .day!.maxtempF
                          //                       .toString(),
                          //                   style: TextStyle(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.w500),
                          //                 ),
                          //                 (proVar.getTemp==false)?  Text(
                          //                   '${weather!.forecast!.forecastday![index].day!.avgtempC.toString()} / ${weather!.forecast!.forecastday![index].day!.maxwindKph.toString()}',
                          //                   style: TextStyle(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.w500),
                          //                 ):Text(
                          //                   '${weather!.forecast!.forecastday![index].day!.avgtempF.toString()} / ${weather!.forecast!.forecastday![index].day!.maxwindKph.toString()}',
                          //                   style: TextStyle(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.w500),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          // },
                        ),
                      ),
                      SizedBox(height: 8,),
                      Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 3,
                      ),
                      SizedBox(height: 18,),
                      Container(
                        height: 270,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 1,
                                  color: (proVar.getTheme == false)?Colors.black87:Colors.white70
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.thermostat,
                                      size: 33,
                                    ),
                                    Text(
                                      'Feels Like',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    (proVar.getTemp == false)? Text(
                                      '${weather!.current!.feelslikeC.toString()}°C',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ):  Text(
                                      '${weather!.current!.feelslikeF.toString()}°F',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.water_drop_outlined,
                                      size: 33,
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${weather!.current!.humidity.toString()}%',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.wind,
                                      size: 33,
                                    ),
                                    Text(
                                      weather!.current!.windDir!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${weather!.current!.windKph.toString()}',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.speed,
                                      size: 33,
                                    ),
                                    Text(
                                      'Air perssure',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${weather!.current!.pressureIn.toString()}',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.sunny,
                                      size: 33,
                                    ),
                                    Text(
                                      'UV',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${weather!.current!.uv.toString()}',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 33,
                                    ),
                                    Text(
                                      'Visibility',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${weather!.current!.visKm.toString()}km',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

