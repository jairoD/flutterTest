import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterTest/layouts/products.dart';
import 'package:flutterTest/services/categoryProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: MyApp(),
      create: (context) => CategoryProvider(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //backgroundColor: Color(0xFFF9F9FD)),
          backgroundColor: Color(0xFFF9F9FD),
          primaryColor: Color(0xff000E69),
          accentColor: Color(0xff000E69),
          chipTheme: ChipThemeData(
              backgroundColor: Color(0xff2D48F2),
              disabledColor: Colors.grey,
              selectedColor: Color(0xff2D48F2),
              secondarySelectedColor: Color(0xff2D48F2),
              padding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              labelStyle: TextStyle(fontSize: 12),
              secondaryLabelStyle: TextStyle(),
              brightness: Brightness.light),
          primarySwatch: CustomColor.navy,
          cursorColor: Color(0xffA9B0E1),
          fontFamily: 'Gilroy',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Color(0xff1B1B26),
            ),
            headline6: TextStyle(
                color: Color(0xff000E69),
                fontSize: 32,
                fontWeight: FontWeight.bold),
            headline1: TextStyle(
                color: Color(0xff000E69),
                fontSize: 16,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
                color: Color(0xff6A6A73),
                fontSize: 12,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(color: Color(0xffA9B0E1)),
            subtitle2: TextStyle(
                color: Color(0xff000E69),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          )),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Products();
  }
}

class CustomColor {
  static const MaterialColor navy = MaterialColor(
    0xffA9B0E1,
    <int, Color>{
      50: Color(0xffA9B0E1),
      100: Color(0xffA9B0E1),
      200: Color(0xffA9B0E1),
      300: Color(0xffA9B0E1),
      400: Color(0xffA9B0E1),
      500: Color(0xffA9B0E1),
      600: Color(0xffA9B0E1),
      700: Color(0xffA9B0E1),
      800: Color(0xffA9B0E1),
      900: Color(0xffA9B0E1),
    },
  );
}
