import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/mapview.dart';
import 'package:flutter_application_1/pages/home.dart';

 void main() {
  runApp(Home());


 }

 class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //Container body;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Exploration app"),
          centerTitle: true,
        ),
          //Container body = Container();
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/images/MapPieni2.png"),
                fit: BoxFit.cover),
            ),
            ),
            new Center(
              child: ElevatedButton(onPressed: (){
            //button action
            //Navigator.push(
             // context,
             // MaterialPageRoute(builder: (context) => mapview()),
            //);
            Navigator.pushNamed(context, '/mapview');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 7, 168, 55),
            elevation: 20,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
            fontFamily: 'Guerrilla',)
          ),
          child: const Text("Start Exploring!"),
          ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/settingsPage');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text("settings"),
              )
              ),
            )
            
          ],
          //constraints: const BoxConstraints.expand(),
          //decoration: const BoxDecoration(
           // image: DecorationImage(
             // image: AssetImage("C:\Users\tuukk\Documents\Projektit\flutter_application_1\assets\images\MapPieni2.png"),
             // fit: BoxFit.cover,
              ),
          ),
          //margin: const EdgeInsets.all(100),
          //padding: EdgeInsets.all(10),
          //color: Colors.red,
         // height: 100,
          //width: 100,
          //child: const Text("Aloita"),
        );
          
  
      
    
  }
}