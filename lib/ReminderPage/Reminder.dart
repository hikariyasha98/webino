import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webino/API/SetApi.dart';
import 'package:webino/API/notificationAPI.dart';
import 'package:webino/HomePage/Detail.dart';
import 'package:webino/setting/scrollbehavior.dart';
import 'package:collection/collection.dart';
import '../my_flutter_app_icons.dart';

final storage = new FlutterSecureStorage();

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List reminderData = [];
  ScrollController? scrollController;
  DateTime now = new DateTime.now();
  bool isLoading = true;
  bool reloadBol = false;
  bool sort = false;
  late DateTime limit = new DateTime(now.year, now.month, now.day + 1);
  static const items = <String>[
    'Closest Date',
    'Furthest Date',
  ];
  final List<PopupMenuItem<String>> _sortBy = items
      .map(
        (String value) => PopupMenuItem(
          child: Text(value),
          value: value,
        ),
      )
      .toList();

  String data = 'asd';
  @override
  void initState() {
    super.initState();
    this.fetchreminder(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchreminder(reload) async {
    var reminderRSP = await checkreminder();
    if (reminderRSP['code'] == 200) {
      List getreminder = [];
      List reminderDatadone = [];
      // ignore: unused_local_variable
      bool done = false;
      int totalpages = reminderRSP['meta']['total_pages'];
      int currentpage = reminderRSP['meta']['current_page'];
      setState(() {
        getreminder = reminderRSP['data'];
      });

      if (totalpages > currentpage) {
        var bol4 = List.generate(totalpages - 1, (i) => i + 2);
        var bol5 = List.generate(totalpages - 1, (i) => false);

        bol4.forEachIndexed((index, element) async {
          var getdata = await checkreminderplus(element);
          if (getdata['code'] == 200) {
            // print(getdata['data']);
            getreminder.addAll(getdata['data']);

            bol5[index] = true;
          }
          if (!bol5.contains(false)) {
            setState(() {
              getreminder = getreminder;
              done = true;
            });

            for (final i in getreminder) {
              var dueDate = DateTime.tryParse(i['tgl']);
              var dueLimit =
                  DateTime(dueDate!.year, dueDate.month, dueDate.day + 1);
              if (now.isBefore(dueLimit) == true) {
                reminderDatadone.add(i);
              }
            }
            setState(() {
              reminderData = reminderDatadone;
              isLoading = false;
              reloadBol = reload;
            });

            await Future.delayed(Duration(seconds: 2));
            setState(() {
              reloadBol = false;
            });
          }
        });
      } else {
        for (final i in getreminder) {
          var dueDate = DateTime.tryParse(i['tgl']);
          var dueLimit =
              DateTime(dueDate!.year, dueDate.month, dueDate.day + 1);
          if (now.isBefore(dueLimit) == true) {
            reminderDatadone.add(i);
          }
        }
        setState(() {
          reminderData = reminderDatadone;
          isLoading = false;
          reloadBol = reload;
        });

        await Future.delayed(Duration(seconds: 2));
        setState(() {
          reloadBol = false;
        });
      }
    }
  }

  Future<Null> reload() async {
    setState(() {
      reloadBol = true;
    });
    fetchreminder(false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      reloadBol = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Image(
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          image: AssetImage("assets/images/navbar.jpg"),
          fit: BoxFit.fill,
        ),

        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            MyFlutterApp.back,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        // backgroundColor: Colors
        //     .transparent,
        backgroundColor: Color.fromRGBO(156, 223, 255, 1),
        title: Text(
          "Reminder",
        ),

        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.sort_rounded,
                color: Colors.white,
              ),
              color: Colors.white,
              elevation: 20,
              enabled: true,
              onSelected: (String? value) {
                value == 'Closest Date'
                    ? setState(() {
                        reminderData.sort((a, b) {
                          var adate = a['tgl'];
                          var bdate = b['tgl'];
                          return adate.compareTo(bdate);
                        });
                        //   print(filteredData);
                        sort = false;
                      })
                    : value == 'Furthest Date'
                        ? setState(() {
                            reminderData.sort((b, a) {
                              var adate = a['tgl'];
                              var bdate = b['tgl'];
                              return adate.compareTo(bdate);
                            });
                            //   print(filteredData);
                            sort = false;
                          })
                        : print('chuaakss');
              },
              itemBuilder: (context) => _sortBy),
          Container(
            // color: Colors.red,
            // height: 10,
            width: 15,
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : reminderData.length == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 47.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/ilustrasi.png",
                          width: MediaQuery.of(context).size.width * 0.382,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(
                            "Belum ada pengingat",
                            style: TextStyle(
                              color: Color.fromRGBO(85, 85, 91, 1),
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : reloadBol
                  ? Container(
                      padding: EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: [
                          Container(
                            child: NotificationListener(
                              child: ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: reminderData.length,
                                  itemBuilder: (context, index) {
                                    return loadCard(index);
                                  }),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Tidak Ada Yang Lain',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: reload,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: reminderData.length,
                                        itemBuilder: (context, index) {
                                          return reminderCard(
                                              reminderData[index]);
                                        }),
                                    Center(
                                      child: Text(
                                        'Tidak Ada Yang Lain',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }

  void reminderSuccess(mesage) => Fluttertoast.showToast(msg: mesage);

  reminderCard(index) {
    int id = index['id'];
    String name = index['product_name'];
    String image = index['featured_image'].toString();
    String tgl = index['tanggal_acara'].toString().split('_')[0];
    var split = index['tanggal_acara'].toString().split('_')[1].split(":");
    var indesx = split.length - 1;
    split.removeAt(indesx);
    var splits = split.join(":");
    String time = splits;
    String tglSet = index['tgl'].toString();
    String status = index['status'];
    String slug = index['slug'].toString();
    var date = DateTime.tryParse(tglSet);
    var tryParseDate = DateTime.tryParse(tglSet.toString());
    DateTime dueDueDate = DateTime(
      tryParseDate!.year,
      tryParseDate.month,
      tryParseDate.day,
      tryParseDate.hour,
      tryParseDate.minute - 30,
    );
    var dueDate = dueDueDate;

    DateTime now = new DateTime.now();
    var nowDate = DateTime.tryParse(now.toString());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFeed(
              from: false,
              date: tglSet,
              slug: slug,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: EdgeInsets.all(5),
                  //   width: MediaQuery.of(context).size.width * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: image != ""
                          ? FadeInImage(
                              image: NetworkImage(image),
                              placeholder: AssetImage(
                                "assets/images/load.jpg",
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    'assets/images/Picture not found.jpg',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.fill,
                              fadeInDuration: const Duration(milliseconds: 300),
                            )
                          : Image.asset(
                              "assets/images/Picture not found.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    //   width: MediaQuery.of(context).size.width * 0.66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          //    width: MediaQuery.of(context).size.width * 0.6,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.38,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          MyFlutterApp.calendar,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Container(
                                          width: 9.5,
                                        ),
                                        Text(
                                          tgl.isNotEmpty
                                              ? tgl
                                              : "10 November 2025",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            //        fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MyFlutterApp.time,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Container(
                                          width: 9.5,
                                        ),
                                        Text(
                                          time.isNotEmpty ? time : "24:00:00",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            //        fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MyFlutterApp.location,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        Container(
                                          width: 9.5,
                                        ),
                                        Text(
                                          status.isNotEmpty
                                              ? (status == "Both"
                                                  ? "Online & Offline"
                                                  : status)
                                              : "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            //   fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  //   width: MediaQuery.of(context).size.width * 0.2,

                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (nowDate!.isAfter(dueDate))
                                              ? () {
                                                  print("due $dueDate");
                                                  //      print(nowDate);
                                                  String message =
                                                      "Reminder Melebihi 30 Menit Sebelum Acara";
                                                  reminderSuccess(message);
                                                }
                                              : () async {
                                                  bool a =
                                                      index['notification_1'] !=
                                                              null
                                                          ? true
                                                          : false;
                                                  bool b =
                                                      index['notification_2'] !=
                                                              null
                                                          ? true
                                                          : false;
                                                  bool c =
                                                      index['notification_3'] !=
                                                              null
                                                          ? true
                                                          : false;
                                                  List<bool> dataNotif = [
                                                    c,
                                                    b,
                                                    a
                                                  ];

                                                  var asd = await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ReminderDialog(
                                                        //   refresh: fetchreminder(true),
                                                        dataAll: index,
                                                        update: "update",
                                                        dueDate: date,
                                                        id: id,
                                                        data: dataNotif,
                                                      );
                                                    },
                                                  );

                                                  if (asd != null) {
                                                    if (asd) {
                                                      reload();
                                                    }
                                                  }
                                                },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0, left: 8, right: 8),
                                            child: Container(
                                              color: Colors.white,
                                              child: Icon(
                                                MyFlutterApp.time,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () async {
                                            var delRSP =
                                                await deleteReminder(id);
                                            if (delRSP['code'] == 200) {
                                              reload();
                                            }
                                          },
                                          child: Container(
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 16,
                                                ),
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Icon(
                                                    MyFlutterApp.trash,
                                                    color: Colors.grey,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadCard(index) {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(156, 223, 255, 1),
      highlightColor: Colors.white,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color.fromRGBO(156, 223, 255, 1),
                        highlightColor: Colors.white,
                        child: Container(
                          //  height: ,
                          width: double.infinity,
                          color: Colors.white,

                          child: Text(""),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: Colors.white,
                              child: Text(""),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                              color: Colors.white,
                              child: Text(""),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class ReminderDialog extends StatefulWidget {
  const ReminderDialog({
    Key? key,
    @required this.dataAll,
    @required this.dueDate,
    required this.id,
    required this.data,
    required this.update,
  }) : super(key: key);

  final dataAll;
  final int id;
  final List<bool> data;
  final dueDate;
  final String update;

  @override
  _ReminderDialogState createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  void reminderSuccess(mesage) => Fluttertoast.showToast(msg: mesage);
  List<bool> reminderTimeSet = [false, false, false];
  List<bool> b = [];
  @override
  void initState() {
    super.initState();
    this.checkData();
  }

  checkData() {
    List<bool> a = widget.data;

    setState(() {
      reminderTimeSet = a;
    });
  }

  Function eq = const ListEquality().equals;
  @override
  Widget build(BuildContext context) {
    b = widget.data;
    var tglAcara = widget.dueDate.toString().split("T")[0];
    var dueDate = DateTime.tryParse(tglAcara);
    //  var due2 = DateTime.tryParse(widget.dueDate.toString());
    DateTime now = new DateTime.now();
    var nowDate = DateTime.tryParse(now.toString().split(" ")[0]);
    var date3 = DateTime(dueDate!.year, dueDate.month, dueDate.day - 3);
    var date2 = DateTime(dueDate.year, dueDate.month, dueDate.day - 1);
    var width2 = MediaQuery.of(context).size.width;

    double popUpPadding = width2 * 0.0338;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(popUpPadding),
          child: Container(
            width: double.infinity,

            height: MediaQuery.of(context).size.height * 0.31,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            // padding: EdgeInsets.only(
            //   top: 10,
            //   left: 10,
            //   right: 10,
            //   bottom: 4,
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width2 * 0.0195),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //   Flexible(flex: 1, child: Container()),
                            Text(
                              "Pilih Waktu Pengingat",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     //    width: double.infinity / 2,

                            //     child: Row(
                            //       mainAxisSize: MainAxisSize.max,
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Container(),
                            //         GestureDetector(
                            //           onTap: () {
                            //             if (reminderTimeSet.contains(false)) {
                            //               for (int i = 0;
                            //                   i < reminderTimeSet.length;
                            //                   i++) {
                            //                 setState(() {
                            //                   reminderTimeSet[i] = true;
                            //                 });
                            //                 //   }
                            //               }
                            //             } else {
                            //               for (int i = 0;
                            //                   i < reminderTimeSet.length;
                            //                   i++) {
                            //                 setState(() {
                            //                   reminderTimeSet[i] = false;
                            //                 });
                            //                 //   }
                            //               }
                            //             }
                            //           },
                            //           child: Container(
                            //             child: Text(
                            //               'Select All',
                            //               style: TextStyle(
                            //                   color: Color.fromRGBO(
                            //                       156, 223, 255, 1),
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 12),
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              setState(() {
                                reminderTimeSet[0] = !reminderTimeSet[0];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width2 * 0.04465, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color.fromRGBO(105, 191, 233, 1)),
                                  color: Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width2 * 0.04465),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Hari H (30 Menit Sebelum)",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                        reminderTimeSet[0]
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        size: 20,
                                        color: reminderTimeSet[0]
                                            ? Colors.blue
                                            : Colors.black)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: nowDate!.isBefore(date2)
                                ? () {
                                    setState(() {
                                      reminderTimeSet[1] = !reminderTimeSet[1];
                                    });
                                  }
                                : () {
                                    String mesage = 'Waktu Telah Berlalu';
                                    reminderSuccess(mesage);
                                  },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width2 * 0.04465, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color.fromRGBO(105, 191, 233, 1)),
                                  color: Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width2 * 0.04465),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "H - 1",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: nowDate.isBefore(date2)
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                        reminderTimeSet[1]
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        size: 20,
                                        color: reminderTimeSet[1] &&
                                                nowDate.isBefore(date2)
                                            ? Colors.blue
                                            : nowDate.isBefore(date2)
                                                ? Colors.black
                                                : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: nowDate.isBefore(date3)
                                ? () {
                                    setState(() {
                                      reminderTimeSet[2] = !reminderTimeSet[2];
                                    });
                                  }
                                : () {
                                    String mesage = 'Waktu Telah Berlalu';
                                    reminderSuccess(mesage);
                                  },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width2 * 0.04465, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Color.fromRGBO(105, 191, 233, 1)),
                                  color: Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width2 * 0.04465),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "H - 3",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: nowDate.isBefore(date3)
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                        reminderTimeSet[2]
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        size: 20,
                                        color: reminderTimeSet[2] &&
                                                nowDate.isBefore(date3)
                                            ? Colors.blue
                                            : nowDate.isBefore(date3)
                                                ? Colors.black
                                                : Colors.grey)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 5),
                Divider(
                  thickness: 1,
                  height: 1,
                ),
                Container(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width2 * 0.0195),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                          reminderTimeSet.contains(true)
                              ? Colors.white.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        reminderTimeSet.contains(true)
                            ? Color.fromRGBO(0, 173, 255, 1)
                            : Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: Color.fromRGBO(105, 191, 233, 1),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    onPressed: reminderTimeSet.contains(true)
                        ? () async {
                            String a = reminderTimeSet[0] ? "H" : "";
                            String b = reminderTimeSet[1] ? "H" : "";
                            String c = reminderTimeSet[2] ? "H" : "";

                            if (widget.update.isNotEmpty) {
                              var updateRSP =
                                  await updateReminder(widget.id, a, b, c);

                              if (updateRSP['code'] == 200) {
                                String mesage = 'Reminder Berhasil Diubah';
                                reminderSuccess(mesage);
                                Map ab = updateRSP['data'];
                                int idRmd = ab['product_id'] * 10;
                                Navigator.pop(context, true);

                                if (ab['notification_3'] != null) {
                                  var localID = idRmd + 1;

                                  var body1 = widget.dataAll['product_name'];
                                  var dateParse1 =
                                      DateTime.tryParse(ab['notification_3']);
                                  String? paylord = jsonEncode(widget.dataAll);
                                  if ((now.isBefore(dateParse1!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body1,
                                      payload: paylord,
                                      scheduledDate: dateParse1,
                                    );
                                } else {
                                  int id = idRmd;
                                  NotificationAPI.cancel(id);
                                }

                                if (ab['notification_2'] != null) {
                                  var localID = idRmd + 2;
                                  var body2 = widget.dataAll['product_name'];
                                  String? paylord = jsonEncode(widget.dataAll);
                                  var dateParse2 =
                                      DateTime.tryParse(ab['notification_2']);
                                  if ((now.isBefore(dateParse2!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body2,
                                      payload: paylord,
                                      scheduledDate: dateParse2,
                                    );
                                } else {
                                  int id = idRmd + 2;
                                  NotificationAPI.cancel(id);
                                }
                                if (ab['notification_1'] != null) {
                                  var localID = idRmd + 3;
                                  var body3 = widget.dataAll['product_name'];
                                  String? paylord = jsonEncode(widget.dataAll);
                                  var dateParse3 =
                                      DateTime.tryParse(ab['notification_1']);
                                  if ((now.isBefore(dateParse3!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body3,
                                      payload: paylord,
                                      scheduledDate: dateParse3,
                                    );
                                } else {
                                  int id = idRmd + 3;
                                  NotificationAPI.cancel(id);
                                }

                                //   return ReminderPage().method();
                              }
                            } else {
                              var rsp = await setReminder(widget.id, a, b, c);

                              if (rsp['code'] == 200) {
                                Navigator.pop(context, true);
                                Map a = rsp['data'];
                                int idRmd = a['product_id'] * 10;
                                // if (a['notification_1'] != null) {
                                //   // var b = localID + 1;
                                //   //   localID = b;
                                //   String? paylord = jsonEncode(widget.dataAll);
                                //   var dateParse1 =
                                //       DateTime.tryParse(a['notification_1']);
                                //   var body =
                                //       widget.dataAll['product_name'].toString();
                                //   //print("${element['slug']}/${element['tgl']}");
                                //   // print(localID);
                                //   if ((now.isBefore(dateParse1!)) == true)
                                //     NotificationAPI.showNotification(
                                //       id: idRmd,
                                //       title: 'Reminder',
                                //       body: body,
                                //       payload: paylord,
                                //     );
                                // } else {
                                //   int id = idRmd;
                                //   NotificationAPI.cancel(id);
                                // }

                                if (a['notification_1'] != null) {
                                  var localID = idRmd + 1;

                                  var body1 = widget.dataAll['name'];

                                  var dateParse1 =
                                      DateTime.tryParse(a['notification_1']);
                                  String? paylord = jsonEncode(widget.dataAll);
                                  if ((now.isBefore(dateParse1!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body1,
                                      payload: paylord,
                                      scheduledDate: dateParse1,
                                    );
                                } else {
                                  int id = idRmd;
                                  NotificationAPI.cancel(id);
                                }

                                if (a['notification_2'] != null) {
                                  var localID = idRmd + 2;
                                  var body2 = widget.dataAll['name'];
                                  String? paylord = jsonEncode(widget.dataAll);
                                  var dateParse2 =
                                      DateTime.tryParse(a['notification_2']);
                                  if ((now.isBefore(dateParse2!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body2,
                                      payload: paylord,
                                      scheduledDate: dateParse2,
                                    );
                                } else {
                                  int id = idRmd + 2;
                                  NotificationAPI.cancel(id);
                                }
                                if (a['notification_3'] != null) {
                                  var localID = idRmd + 3;
                                  var body3 = widget.dataAll['name'];
                                  String? paylord = jsonEncode(widget.dataAll);
                                  var dateParse3 =
                                      DateTime.tryParse(a['notification_3']);
                                  if ((now.isBefore(dateParse3!)) == true)
                                    NotificationAPI.showScheduledNotification(
                                      id: localID,
                                      title: 'Reminder',
                                      body: body3,
                                      payload: paylord,
                                      scheduledDate: dateParse3,
                                    );
                                } else {
                                  int id = idRmd + 3;
                                  NotificationAPI.cancel(id);
                                }

                                String mesage = 'Reminder Berhasil Ditambahkan';
                                reminderSuccess(mesage);
                              } else {
                                String mesage = "Acara Sudah Pernah Direminder";
                                reminderSuccess(mesage);
                              }
                            }
                          }
                        : () {
                            String mesage = "Silahkan pilih waktu";
                            reminderSuccess(mesage);
                          },
                    child: Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Pilih",
                            style: TextStyle(
                                color: reminderTimeSet.contains(true)
                                    ? Colors.white
                                    : Color.fromRGBO(105, 191, 233, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Center(child: ,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
