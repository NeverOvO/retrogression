

import 'package:flutter/material.dart';
import 'package:retrogression/IndexView.dart';
import 'package:retrogression/WebView.dart';
import 'package:retrogression/realtime/realTimeView.dart';

final routes = {

  '/indexView': (context, {arguments}) =>indexView(arguments: arguments),

  '/realTimeView': (context, {arguments}) =>realTimeView(arguments: arguments),

  '/WebView': (context, {arguments}) =>WebView(arguments: arguments),
};


var onGenerateRoute = (RouteSettings settings){
  final String? name = settings.name;

  final Function? pageContentBuilder = routes[name];

  if (settings.arguments != null) {
    final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder!(context, arguments: settings.arguments),
    );
    return route;
  } else {
    final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder!(context));
    return route;
  }
};