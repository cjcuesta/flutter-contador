import 'package:contador/pages/areas_page.dart';
import 'package:contador/pages/conteo_page.dart';
import 'package:contador/pages/menu_page.dart';
import 'package:contador/pages/producto_page.dart';
import 'package:contador/pages/status.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'conteo': (_) => ConteoPage(),
  'menu': (_) => MenuPage(),
  'areas': (_) => AreasPage(),
  'producto': (_) => ProductoPage(),
  'status': (_) => StatusPage(),
};
