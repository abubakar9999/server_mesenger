import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

typedef Unit8ListCallback = Function(Uint8List ondata);
typedef Dynamicfunction = Function(dynamic ondata);

class Server {
  Unit8ListCallback? ondata;
  Dynamicfunction? onError;
  Server(this.ondata, this.onError);

  ServerSocket? server;
  bool runing=false;
  List<Socket> sokets = [];



  Future<void> start() async {
    runZoned(() async {
      server = await ServerSocket.bind("192.168.1.112", 4000);
      runing = true;
      server!.listen(OnRequest);
      final massage = 'server is lisening port 4000';
      ondata!(Uint8List.fromList(massage.codeUnits));
    },onError: onError
     
    );
  }

 void OnRequest(Socket socket) {
    if (!sokets.contains(socket)) {
      sokets.add(socket);
    }
    socket.listen((event) {
      ondata!(event);
    });
  }
  Future<void> colose()async{
    await server!.close();
    server=null;
    runing=false;
  }
  void brodCusustData(String data) {
    ondata!(Uint8List.fromList("Me: $data".codeUnits));
    for (final soket in sokets) {
      soket.write(data);
      
    }


  }
}
