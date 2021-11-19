import 'package:flutter/material.dart';

import '../../my_flutter_app_icons.dart';

class LupaPassPage extends StatefulWidget {
  const LupaPassPage({Key? key}) : super(key: key);

  @override
  _LupaPassPageState createState() => _LupaPassPageState();
}

class _LupaPassPageState extends State<LupaPassPage> {
  TextEditingController _emailLogInController = TextEditingController();
//  TextEditingController _passLogInController = TextEditingController();

  String _emailLogin = "", _passLogin = "";

  @override
  Widget build(BuildContext context) {
    print("width ${MediaQuery.of(context).size.width * 0.78}");
    print("height : ${MediaQuery.of(context).size.height}");
    return Scaffold(
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
              top: 50.0,
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
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    MyFlutterApp.back,
                    color: Colors.white,
                  ),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white.withOpacity(0.0),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    //  color: Colors.red,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
                Container(
                  // color: Colors.green,
                  //   height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 44.0, left: 44.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        //  color: Colors.red,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //   color: Colors.green,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 20.0),
                                      child: Text(
                                        "Verifikasi \n"
                                        "Email",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 11.0),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _emailLogin = value;
                                        });
                                      },
                                      onSubmitted: (value) {
                                        setState(() {
                                          _emailLogin = value;
                                        });
                                      },
                                      controller: _emailLogInController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 1,
                                        ),
                                        hintText: "Email",
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                            height: 0.5, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(1)),
                                        ),
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          (_emailLogin != "")
                                              ? Color.fromRGBO(105, 191, 233, 1)
                                              : Color.fromRGBO(
                                                  156, 223, 255, 1),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            side:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onPressed: (_emailLogin != "" &&
                                              _passLogin != "")
                                          ? () {
                                              print("lah");
                                            }
                                          : null, // () {},
                                      child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.022),
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                1),
                                        child: Center(
                                          child: Text(
                                            "Lanjut",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Masukan E-mail yang terdaftar. "
                        "Kami akan mengirimkan \n"
                        "kode verifikasi atur ulang password ke E-mail Anda.",
                        style: TextStyle(
                          color: Color.fromRGBO(85, 85, 91, 1),
                          fontWeight: FontWeight.bold,
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
    );
  }
}
