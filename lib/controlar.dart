import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:server_make/server.dart';
import 'package:get/get.dart';
class ServerControlar extends GetxController {
  
  Server ?server;
  List<String> serverLogs=[];
  TextEditingController messageControlar=TextEditingController();

  Future<void> serverStartorSpop()async{
    if(server!.runing){
      server!.colose();
      serverLogs.clear();

    }
    else{

    await server!.start();
    }
    update();
    
  }


  Future<void> start()async{
  

    await server!.start();
   

    
  }


  @override
  void onInit() {
    // TODO: implement onInit
    server=Server(onData, onError);
     start();
    super.onInit();
  }

  void onData(Uint8List data){
    start();
    final reciveData= String.fromCharCodes(data);
     serverLogs.add(reciveData);
     update();
  }
  void onError(dynamic error){
    debugPrint("Error : $error");
  }

  void handelMessage( ){
    server!.brodCusustData(messageControlar.text);
    // serverLogs.add(messageControlar.text);
    messageControlar.clear();
    update();

  }
  
}