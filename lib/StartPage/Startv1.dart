import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StartPagev1 extends StatefulWidget {
  const StartPagev1({Key? key}) : super(key: key);

  @override
  _StartPagev1State createState() => _StartPagev1State();
}

class _StartPagev1State extends State<StartPagev1> {
  // bool _email = false, _password = false, _login = true, _signUp = false;
  void _signFunct() => Fluttertoast.showToast(msg: 'Login Error');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(156, 223, 255, 1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width / 1,
              child: Image.asset(
                "assets/images/Background.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height / 5,
              //   //color: Colors.blue,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 50.0),
              //     child: Image.asset(
              //       "assets/images/Logo Webino.png",
              //       width: MediaQuery.of(context).size.width * 0.4,
              //     ),
              //   ),
              // ),
              Expanded(
                  child: Container(
                //  color: Colors.green,
                child: ListView(
                  primary: false,
                  children: [
                    Padding(
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
                                          "Masuk",
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 11.0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 1,
                                          ),
                                          hintText: "Alamat Email",
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintStyle: TextStyle(
                                              height: 0.5, color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
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
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(1)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 1),
                                          //  labelText: "Alamat Email",
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              height: 0.5, color: Colors.grey),
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Lupa Password ?",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(85, 85, 91, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color.fromRGBO(156, 223, 255, 1),
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
                                          onPressed: () {},
                                          child: Container(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.022),
                                            width: (MediaQuery.of(context)
                                                .size
                                                .width), //*
                                            // 0.318),
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                          color: Color.fromRGBO(85, 85, 91, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _signFunct,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Text(
                                            "Sign-Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              //  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
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
                                          "Masuk",
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 11.0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 1,
                                          ),
                                          hintText: "Alamat Email",
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintStyle: TextStyle(
                                              height: 0.5, color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
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
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(1)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 1),
                                          //  labelText: "Alamat Email",
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              height: 0.5, color: Colors.grey),
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "Lupa Password ?",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(85, 85, 91, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Color.fromRGBO(156, 223, 255, 1),
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
                                          onPressed: () {},
                                          child: Container(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.022),
                                            width: (MediaQuery.of(context)
                                                .size
                                                .width), //*
                                            // 0.318),
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                          color: Color.fromRGBO(85, 85, 91, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _signFunct,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Text(
                                            "Sign-Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              //  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}



// Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height / 3,
//                   // color: Colors.blue,
//                   child: Image.asset(
//                     "assets/images/Logo Webino.png",
//                     width: MediaQuery.of(context).size.width * 0.282,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 44.0, left: 44.0),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       //  color: Colors.red,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             //   color: Colors.green,
//                             child: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.only(bottom: 50.0),
//                                     child: Text(
//                                       "Masuk",
//                                       style: TextStyle(
//                                         fontSize: 36,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 11.0),
//                                   child: TextField(
//                                     keyboardType: TextInputType.emailAddress,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.symmetric(
//                                         horizontal: 10,
//                                         vertical: 1,
//                                       ),
//                                       hintText: "Alamat Email",
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       hintStyle: TextStyle(
//                                           height: 0.5, color: Colors.grey),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             color: Colors.white.withOpacity(1)),
//                                       ),
//                                       border: new OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             color: Colors.white.withOpacity(1)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 11.0),
//                                   child: TextField(
//                                     keyboardType: TextInputType.emailAddress,
//                                     decoration: InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             color: Colors.white.withOpacity(1)),
//                                       ),
//                                       contentPadding: EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 1),
//                                       //  labelText: "Alamat Email",
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       hintText: "Password",
//                                       hintStyle: TextStyle(
//                                           height: 0.5, color: Colors.grey),
//                                       border: new OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide(
//                                             color: Colors.white.withOpacity(1)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: Text(
//                                       "Lupa Password ?",
//                                       style: TextStyle(
//                                           color: Color.fromRGBO(85, 85, 91, 1),
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: TextButton(
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                         Color.fromRGBO(156, 223, 255, 1),
//                                       ),
//                                       shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                         RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(50.0),
//                                           side: BorderSide(color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     onPressed: () {},
//                                     child: Container(
//                                       height:
//                                           (MediaQuery.of(context).size.height *
//                                               0.022),
//                                       width:
//                                           (MediaQuery.of(context).size.width *
//                                               0.318),
//                                       child: Center(
//                                         child: Text(
//                                           "Masuk",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Padding(
//                           //   padding: const EdgeInsets.only(bottom: 20.0),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 20.0),
//                             child: Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Don't have an account ? ",
//                                     style: TextStyle(
//                                       color: Color.fromRGBO(85, 85, 91, 1),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: _signFunct,
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       child: Text(
//                                         "Sign-Up",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           //  ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),