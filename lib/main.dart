import 'dart:io';


import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:neveruseless/neveruseless.dart';
import 'package:retrogression/IndexView.dart';
import 'Base/Global.dart';
import 'Base/routes.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}



final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  ThemeMode _themeMode = ThemeMode.light;


  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
    neverBus.on('balck', (object) {
      setState(() {
        if(_themeMode == ThemeMode.light){
          _themeMode = ThemeMode.dark;
        }else{
          _themeMode = ThemeMode.light;
        }
      });
    });

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
    }
  }



  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '溯洄',
      // showPerformanceOverlay: true,
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),
      theme: ThemeData(
        cardColor: Colors.white,//为了弹窗
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        canvasColor: Colors.white,//页面背景色
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme:IconThemeData(
              color: Colors.black
          ),
          elevation: 1.0,//隐藏底部阴影分割线
          centerTitle: true,//标题是否居中 安卓上有效ios默认居中
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
        ),
        buttonTheme: new ButtonThemeData(
          minWidth: 0,
          height: 0,
          padding: EdgeInsets.all(0),
          buttonColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black,fontSize: 13),
        ),
      ),
      home: indexView(),////indexViewForDesktopController(),//LoginViewController(),//
    );
  }
}
