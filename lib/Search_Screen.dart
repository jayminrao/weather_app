import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model_Class.dart';
import 'Provider.dart';
import 'main.dart';

class SearchScreen extends StatefulWidget {
  final String? city;
  final String? tid;
  final String? tempc;
  final String? tempf;
  final String? Icon;
  final int? tags;
  SearchScreen({
    required this.city, required this.tid, required this.tempc, required this.tempf, this.Icon, this.tags});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final proVar = Provider.of<WeatherProvider>(context,listen: true);
    return Scaffold(
      appBar:  AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.blueAccent],
            ),
          ),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(CupertinoIcons.back,color: Colors.white,size: 35,)),
        automaticallyImplyLeading: false,
        toolbarHeight: 110,
        title: Container(
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            child: TextField(
              onSubmitted: (value){
                searchController.text = value;
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: searchController.text),), (route) => false);
              },
              controller: searchController,
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: 0,
                  bottom: 11,
                  top: 11,
                  right: 15,
                ),
                hintText: "Search Location",
              ),
            ),
          ),
        ),
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
            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: height,
                  child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: widget.city!),), (route) => false);

                          },
                          child: Container(
                            height: 130,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:(proVar.getTheme == false)?Colors.black12:Colors.white ,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      blurStyle: BlurStyle.outer,
                                      color:(proVar.getTheme == false)?Colors.black87:Colors.white70
                                  )
                                ],
                                image: DecorationImage(image: NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/6TIZLa1AKeBel0yVO7ReIn/1fc0e2fd9fcc6d66b3cc733aa2547e11/weather-images.jpg?fit=fill&w=1200&h=630',),fit: BoxFit.cover)

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 25,),
                                    Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Text(searchList[index].city!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.white),),
                                    ),
                                    // Text(searchList[index].tid!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white54),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.network(
                                        "https:" + searchList[index].Icon!),
                                    (proVar.getTemp == false)? Text(
                                      '${searchList[index].tempc}°C',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),
                                    ):Text('${searchList[index].tempc}°F',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}