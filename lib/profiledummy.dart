import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Constants {
  Constants._();
  static const double padding = 20;
}

class SizeConfig {}

// ignore: camel_case_types
class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  // double heightappbar = AppBar().preferredSize.height;
  int? val = 0;
  @override
  Widget build(BuildContext context) {
    var height2 =
        (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width)
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            //suspect
            elevation: 12,
            shadowColor: Colors.black54,
            title: const Text('Profile'),
            centerTitle: true,
            leading: Icon(Icons.add_a_photo),
            backgroundColor: Color.fromRGBO(105, 191, 233, 1),
          ),
        ),
        body: ListView(
          //suspect //listview
          //  padding: EdgeInsets.zero,
          // scrollDirection: Axis.vertical,
          children: [
            Container(
              height: height2 / 1.15,
              // width: MediaQuery.of(context).size.width, //sus
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //important
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   image: const DecorationImage(
                              //       image: AssetImage(
                              //         'assets/Background profile.jpg',
                              //       ),
                              //       fit: BoxFit.fill),
                              // ),
                              child: Container(
                                //container 1
                                // width: 414,
                                // height: 151,
                                // color: Colors.red,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18),
                                          child: Stack(
                                            // fit: StackFit.expand,
                                            children: [
                                              Container(
                                                //gneral
                                                width: 100,
                                                height: 100,
                                                decoration: const BoxDecoration(
                                                  // image:
                                                  //     const DecorationImage(
                                                  //         image: AssetImage(
                                                  //           'assets/profile.jpg',
                                                  //         ),
                                                  //         fit: BoxFit.fill),
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Container(
                                                        //2
                                                        //color: Colors.red,
                                                        width: 70,
                                                        height: 34,
                                                        decoration: const BoxDecoration(
                                                            // borderRadius: BorderRadius.only(
                                                            //     // bottomLeft: Radius
                                                            //     //     .circular(
                                                            //     //         200),
                                                            //     ),
                                                            shape: BoxShape.circle),
                                                        // alignment: Alignment
                                                        //     .bottomCenter,

                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  // top: 50
                                                                  ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                //top sendiri
                                                                decoration: const BoxDecoration(
                                                                    // color: Colors
                                                                    //     .black54,
                                                                    // borderRadius:
                                                                    //     BorderRadius
                                                                    //         .only(
                                                                    //   bottomLeft:
                                                                    //       Radius.circular(100),
                                                                    //   bottomRight:
                                                                    //       Radius.circular(100),
                                                                    // ),
                                                                    ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 20,
                                                                      bottom: 0,
                                                                      left: 13,
                                                                      right:
                                                                          13),
                                                                  child:
                                                                      Opacity(
                                                                    opacity: 1,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      // color: Colors
                                                                      // .yellow,
                                                                      width:
                                                                          100,
                                                                      // height: 80,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black38,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(70),
                                                                          bottomRight:
                                                                              Radius.circular(70),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'ganti',
                                                                          style: TextStyle(
                                                                              decoration: TextDecoration.underline,
                                                                              color: Colors.white,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // width: 100,
                                                                // height: 28,
                                                                // color: Colors.red),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 12),
                                        child: Container(
                                          child: Text(
                                            "natalie@gmail.com",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ), //414 h versi fidma
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                //container 2
                                //width: 333,
                                //  height: 170,
                                // margin: EdgeInsets.only(
                                // top: 176,
                                //left: 44,
                                //right: 44,
                                //  ),
                                // color: Colors.indigo, //width 326 fdma
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 7, left: 32, top: 25),
                                    child: Container(
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Theme(
                                      data: new ThemeData(
                                        primaryColor: Colors.redAccent,
                                        primaryColorDark: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                        ),
                                        child: Container(
                                          //color: Colors.red,
                                          height: 50, //di  fidma  h39
                                          //width: 340,
                                          child: Container(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            105, 191, 233, 1),
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            105, 191, 233, 1),
                                                        width: 1.0),
                                                  ),
                                                  //     hintText: 'Enter your name',
                                                  prefixText: "   "),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32, top: 20),
                                    child: Text('Jenis Kelamin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 7),
                                  child: Container(
                                    //width: 340,
                                    height: 50, //difidma h39
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(105, 191, 233, 1)),
                                    ),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "   Lainnya",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                      ),
                                      onTap: () => _showMessageDialog(context),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ], //ini!
                    ),
                  ), //ini part 2
                  // Expanded(
                  //   child: Container(
                  //     color: Colors.amber,
                  //   ),
                  // ),
                  //
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 33, right: 33),
                      child: Container(
                        // width: 348,
                        // margin: EdgeInsets.only(
                        //     // top: 449,
                        //     ), //700 di fidma top ke appbar
                        //color: Colors.blue,
                        child: new MaterialButton(
                          elevation: 0,
                          focusColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          //  height: 45.0,
                          highlightColor: Color.fromRGBO(105, 191, 233, 1),
                          minWidth: double.infinity,
                          color: Color.fromRGBO(105, 191, 233, 1),
                          textColor: Colors.white,
                          child: new Text("Simpan Perubahan"),
                          onPressed: () => {},
                          splashColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

//height = tinggi
//width = lebar

  _showMessageDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          //  var hOri = MediaQuery.of(context).size.height;
          // var wOri = MediaQuery.of(context).size.width;
          // var width2 = hOri < wOri ? wOri / 2.10 : hOri / 1.10;
          // var other = hOri < wOri ? 1.9 : 1.03;
          return Dialog(
            insetPadding: EdgeInsets.only(left: 14.5, right: 14.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            elevation: 1,
            backgroundColor: Colors.white,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
//                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.yellow,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            //  color: Colors.yellow,
                            child: Title(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Text('Jenis Kelamin',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                )),
                          ),
                        ),
                        // Spacer(),
                        Expanded(
                          flex: 1,
                          child: Container(
                            //   color: Colors.amber,
                            alignment: AlignmentDirectional.bottomEnd,
                            // color: Colors.blue,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Lanjut',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(105, 191, 233, 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 23,
                  endIndent: 23,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 37),
                        child: Text(
                          'Pria',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Radio(
                          value: 1,
                          groupValue: val,
                          onChanged: (int? value) {
                            val = value;
                          },
                          activeColor: Color.fromRGBO(105, 191, 233, 1),
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 37),
                        child: Text(
                          'Wanita',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: (int? value) {
                            val = value;
                          },
                          activeColor: Color.fromRGBO(105, 191, 233, 1),
                        ),
                      ),
                    ])
              ],
            ),
          );
        },
      );
}
