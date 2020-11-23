import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  IO.Socket _socket;

  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  ServerStatus get serverStatus => this._serverStatus;

  void _initConfig() {
    // Dart client
    this._socket = IO.io('http://192.168.0.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('disconnect1');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje $payload');
      print(payload.containskey('nombre') ? payload['nombre'] : 'no-name');
      print(payload.containsKey('mensaje') ? payload['mensaje'] : 'no-mensaje');

      //print('nombre: '+ payload['nombre']);
      //print('mensaje: '+ payload['mensaje']);
    });
    //socket.connect();
  }
}
