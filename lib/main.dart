import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webino/API/notificationAPI.dart';
import 'package:webino/HomePage/Feed.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'API/SetApi.dart';

import 'HomePage/Detail.dart';
import 'StartPage/StartPage.dart';

final storage = FlutterSecureStorage();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  runApp(
    new LayoutBuilder(
      builder: (context, constraints) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator"); //

  List lokasi = [];
  String token = "";
  @override
  void initState() {
    super.initState();
    this.fetchLKS();
    this._token();
    NotificationAPI.init(onSelectNotification: onSelectNotification);
    tz.initializeTimeZones();
  }

  fetchLKS() async {
    var value = await storage.read(key: 'token');
    setState(() {
      token = value.toString();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("webinoLocationRongkir") ?? "";

    if (b == "") {
      String locationMekso = await fetchLokasiDummy();
      if (locationMekso.toString().isNotEmpty) {
        prefs.setString("webinoLocationRongkir", locationMekso.toString());
      }
    }
  }

  // void listenNotifications() =>
  //     NotificationAPI.onNotifications.stream.listen(onClick);

  // void onClick(String? payload) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => DetailFeed(
  //             from: true,
  //             slug: payload!.isNotEmpty ? jsonDecode(payload)['slug'] : "",
  //             date: payload.isNotEmpty ? jsonDecode(payload)['tgl'] : ""),
  //       ),
  //     );

  onSelectNotification(payload) async {
    if (payload.toString().isNotEmpty) {
      this.navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) {
          return DetailFeed(
              from: true,
              slug: payload!.isNotEmpty ? jsonDecode(payload)['slug'] : "",
              date: payload.isNotEmpty ? jsonDecode(payload)['tgl'] : "");
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token.isEmpty || token.toString() == "null") {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Webino',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StartPage(
          tokenAB: token,
        ),
      );
    }
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Webino',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedPage(
        fromPage: "main",
      ),
    );
  }

  _token() async {
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'token');

    if (value.toString() != "null") {
      setState(() {
        token = value.toString();
      });
    } else {
      NotificationAPI.cancelAll();
    }
  }
}

// class MyApp2 extends StatefulWidget {
//   @override
//   _MyApp2State createState() => _MyApp2State();
// }

// class _MyApp2State extends State<MyApp2> {
//   @override
//   void initState() {
//     super.initState();
//     NotificationAPI.init();
//     tz.initializeTimeZones();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Webino',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FeedPage(
//         firstLaunch: false,
//       ),
//     );
//   }
// }
