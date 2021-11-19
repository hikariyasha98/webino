import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webino/API/StartAPI.dart';
import 'package:webino/API/notificationAPI.dart';

import 'package:webino/HomePage/Feed.dart';

import 'package:webino/StartPage/OTP.dart';

import 'package:webino/StartPage/PageSignUP/SignUp.dart';
import 'package:webino/my_flutter_app_icons.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key, required this.tokenAB}) : super(key: key);

  final String tokenAB;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController _emailLogInController = TextEditingController();
  TextEditingController _passLogInController = TextEditingController();
  bool _loading = false;

  String token = "";
  bool _obsPassword = false;
  String _emailLogin = "", _passLogin = "", logindetail = "", emptyForm = "";

  void _wrong() => Fluttertoast.showToast(
      fontSize: 13,
      backgroundColor: Color.fromRGBO(137, 196, 224, 1),
      msg: logindetail);
  void _empty() => Fluttertoast.showToast(
      fontSize: 13,
      backgroundColor: Color.fromRGBO(137, 196, 224, 1),
      msg: emptyForm);
  var currentFocus;
  final storage = new FlutterSecureStorage();
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<bool> _onbackPressed() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        double popUpPadding = MediaQuery.of(context).size.width * 0.0338;
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(popUpPadding),
          child: Container(
            width: double.infinity,
            height: 122,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 4,
            ),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      bottom: 2.0,
                    ),
                    child: Text(
                      "Keluar Dari Webino ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7.0,
                    right: 7.0,
                  ),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Apakah Anda Ingin Keluar ?",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            child: Text(
                              "Batal",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 30,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          exit(0);
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Keluar",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(105, 191, 233, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    return shouldPop ?? false;
  }

  @override
  void initState() {
    super.initState();
  }

  catchToken() async {
    var tokenb = await storage.read(key: 'token');
    setState(() {
      token = tokenb.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    if (_loading) {
      return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 5,
            child: Image.asset(
              'assets/images/tLoading.gif',
            ),
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          var tokenA = await storage.read(key: 'token');
          if (tokenA == "Guest") {
            Navigator.pop(context);
          } else {
            _onbackPressed();
          }
          return false;
        },
        child: GestureDetector(
          onTap: unfocus,
          child: Scaffold(
            backgroundColor: Color.fromRGBO(156, 223, 255, 1),
            body: Container(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  new Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Image.asset(
                            "assets/images/Background.jpg",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Positioned(
                    top: 45.0,
                    left: 0.0,
                    right: 0.0,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            //  color: Colors.blue,
                            child: Image.asset(
                              "assets/images/Logo Webino.png",
                              width: MediaQuery.of(context).size.width * 0.382,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4.5,
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        //s    height: MediaQuery.of(context).size.height / 2,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 44.0, left: 44.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              //  color: Colors.red,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    //   color: Colors.green,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Masuk",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                //   color: Colors.red,
                                                // width: MediaQuery.of(context)
                                                //         .size
                                                //         .width *
                                                //  0.135,
                                                child: TextButton(
                                                  // style: ButtonStyle(
                                                  //  // overlayColor: null,
                                                  //   // MaterialStateProperty.all<
                                                  //   //         Color>(
                                                  //   //     Colors.transparent
                                                  //   //         .withOpacity(
                                                  //   //             0.2)),
                                                  // ),
                                                  // behavior:
                                                  //     HitTestBehavior.translucent,
                                                  onPressed: () async {
                                                    //  print(widget.tokenAB);

                                                    // setState(() {
                                                    //   _loading = true;
                                                    // });

                                                    if (widget.tokenAB == "" ||
                                                        widget.tokenAB ==
                                                            'null') {
                                                      var actoken = "Guest";
                                                      await storage.write(
                                                          key: 'token',
                                                          value: actoken);
                                                      // var tokenA = await storage
                                                      //     .read(key: 'token');
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    FeedPage(
                                                                      fromPage:
                                                                          "Start",
                                                                    )),
                                                      );
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    // width: 100,
                                                    color: Colors.transparent,
                                                    child: Text(
                                                      "Skip",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 11.0),
                                          child: TextField(
                                            onEditingComplete: () =>
                                                node.nextFocus(),
                                            onChanged: (value) {
                                              setState(() {
                                                // emptyForm ==
                                                //         "Silahkan isi Email dan Password"
                                                //     ? emptyForm =
                                                //         "Silahkan isi Password"
                                                //     : emptyForm = "";
                                                _emailLogin = value;
                                              });
                                            },
                                            onSubmitted: (value) {
                                              setState(() {
                                                _emailLogin = value;
                                              });
                                            },
                                            controller: _emailLogInController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              hintText: "Alamat Email",
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  height: 0.5,
                                                  color:
                                                      // emptyForm ==
                                                      //             "Silahkan isi Email" ||
                                                      //         emptyForm ==
                                                      //             "Silahkan isi Email dan Password"
                                                      //     ? Colors.red
                                                      //     :
                                                      Colors.grey),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color:
                                                        // emptyForm ==
                                                        //             "Silahkan isi Email" ||
                                                        //         emptyForm ==
                                                        //             "Silahkan isi Email dan Password"
                                                        //     ? Colors.red
                                                        //     :
                                                        Colors.white
                                                            .withOpacity(1)),
                                              ),
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(1)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 11.0, bottom: 1),
                                          child: TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                // emptyForm ==
                                                //         "Silahkan isi Email dan Password"
                                                //     ? emptyForm =
                                                //         "Silahkan isi Email"
                                                //     : _emailLogin == ""
                                                //         ? emptyForm =
                                                //             "Silahkan isi Email"
                                                //         : emptyForm = "";
                                                _passLogin = value;
                                              });
                                            },
                                            onSubmitted: (value) {
                                              setState(() {
                                                _passLogin = value;
                                              });
                                            },
                                            obscureText: !this._obsPassword,
                                            controller: _passLogInController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color:
                                                        //  emptyForm ==
                                                        //             "Silahkan isi Password" ||
                                                        //         emptyForm ==
                                                        //             "Silahkan isi Email dan Password"
                                                        //     ? Colors.red
                                                        //     :
                                                        Colors.white
                                                            .withOpacity(1)),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 1),
                                              //  labelText: "Alamat Email",
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: IconButton(
                                                  icon: Icon(
                                                    MyFlutterApp.eye,
                                                    color: Colors.grey,
                                                    size: 26,
                                                  ),
                                                  onPressed: () {
                                                    setState(() =>
                                                        this._obsPassword =
                                                            !this._obsPassword);
                                                  },
                                                ),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  height: 0.5,
                                                  color:
                                                      // emptyForm ==
                                                      //             "Silahkan isi Password" ||
                                                      //         emptyForm ==
                                                      //             "Silahkan isi Email dan Password"
                                                      //     ? Colors.red
                                                      //     :
                                                      Colors.grey),
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(1)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7.0,
                                              bottom: 4.0,
                                              right: 15.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                              onPressed: () async {
                                                var url =
                                                    "https://webino.id/forgot-password";
                                                await _launchUrl(url);
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           LupaPassPage()),
                                                // );
                                              },
                                              child: Text(
                                                "Lupa Password ?",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        85, 85, 91, 1),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(Colors.white
                                                    .withOpacity(0.2)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              (_emailLogin != "" &&
                                                      _passLogin != "")
                                                  ? Color.fromRGBO(
                                                      0, 173, 255, 1)
                                                  : Color.fromRGBO(
                                                      156, 223, 255, 1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                side: BorderSide(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          onPressed: (_emailLogin != "" &&
                                                  _passLogin != "")
                                              ? () async {
                                                  setState(() {
                                                    _loading = true;
                                                  });
                                                  unfocus();
                                                  String email = _emailLogin;
                                                  String password = _passLogin;
                                                  var testlog = await login(
                                                      email, password);
                                                  var code = testlog['code'];
                                                  if (code == 200) {
                                                    var actoken =
                                                        testlog['data']
                                                            ['access_token'];
                                                    if (testlog['data'][
                                                            'email_verified'] ==
                                                        null) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OTPPage(
                                                                  accesstoken:
                                                                      actoken),
                                                        ),
                                                      );
                                                    } else {
                                                      String un =
                                                          testlog['data']
                                                              ['name'];
                                                      String email =
                                                          _emailLogin;

                                                      await storage.write(
                                                          key: 'token',
                                                          value: actoken);

                                                      await storage.write(
                                                          key: 'email',
                                                          value: email);
                                                      await storage.write(
                                                          key: 'username',
                                                          value: un);
                                                      var notifavail =
                                                          await setLocalReminder();
                                                      if (notifavail
                                                          .toString()
                                                          .isNotEmpty) {}

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FeedPage(
                                                            fromPage: "Start",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    setState(() {
                                                      _loading = false;
                                                    });
                                                    if (testlog[
                                                            'errorDetails'] !=
                                                        null) {
                                                      setState(() {
                                                        logindetail =
                                                            testlog['errorDetails']
                                                                    ['email']
                                                                .toString()
                                                                .replaceAll(
                                                                    "[", "")
                                                                .replaceAll(
                                                                    "]", "");
                                                      });
                                                    } else {
                                                      logindetail =
                                                          testlog['error']
                                                              .toString();
                                                    }
                                                    _wrong();
                                                  }
                                                }
                                              : () {
                                                  if (_emailLogin.isEmpty &&
                                                      _passLogin.isEmpty) {
                                                    setState(() {
                                                      emptyForm =
                                                          "Silahkan isi Email dan Password";
                                                    });
                                                    _empty();
                                                  } else if (_passLogin
                                                      .isEmpty) {
                                                    setState(() {
                                                      emptyForm =
                                                          "Silahkan isi Password";
                                                    });
                                                    _empty();
                                                  } else if (_emailLogin
                                                      .isEmpty) {
                                                    setState(() {
                                                      emptyForm =
                                                          "Silahkan isi Email";
                                                    });
                                                    _empty();
                                                  }
                                                },
                                          child: Container(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.022),
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1),
                                            child: Center(
                                              child: Text(
                                                "Masuk",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(bottom: 20.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account ? ",
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(85, 85, 91, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpPage()),
                                              );
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                "Sign-Up",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  _launchUrl(url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
