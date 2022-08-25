import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:server_make/controlar.dart';
import 'package:server_make/server.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Server'),
        ),
        body: GetBuilder<ServerControlar>(
          init: ServerControlar(),
         
            builder: (controller) {
            
              return Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Server"),
                            Container(
                              decoration: BoxDecoration(
                                  color: controller.server!.runing
                                      ? Colors.green
                                      : Colors.red),
                              child: Text(controller.server!.runing ? "On" : "Off"),
                            ),
                          ],
                        ),
                      TextButton(onPressed: ()async{
                        await controller.serverStartorSpop();
                      },
                      
                       child: Text(controller.server!.runing?"Stop Server":"start Server")),
                       Expanded(child: ListView(children: controller.serverLogs.map((e) => Text(e)).toList(),)),

                       Container(
                        height: 80,
                       child: Row(children: [
                        Expanded(child: TextField(
                          controller:controller.messageControlar ,
                          decoration: InputDecoration(
                            labelText: "Enter Message",
                          ),
                        )),
                         SizedBox(width: 10,),
                         IconButton(onPressed: (){
                          controller.messageControlar.clear();

                         }, icon: Icon(Icons.clear)),
                         SizedBox(width: 10,),
                         IconButton(
                          onPressed: controller.handelMessage, icon: Icon(Icons.send)),

                        ],)
                       )
                      
                      ],
                    ),
                  ))
                ],
              );
            }));
  }
}
