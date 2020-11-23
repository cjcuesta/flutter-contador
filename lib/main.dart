import 'package:contador/routes/routes.dart';
import 'package:contador/provider/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'conteo',
        routes: appRoutes,
      ),
    );
  }
}
