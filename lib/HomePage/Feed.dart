import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webino/API/SetApi.dart';
import 'package:webino/API/notificationAPI.dart';
import 'package:webino/HomePage/Detail.dart';
import 'package:webino/HomePage/Filter.dart';
import 'package:webino/HomePage/Search.dart';
import 'SideAppbar.dart';
import 'package:webino/HomePage/Slider.dart';
import 'package:webino/StartPage/StartPage.dart';
import 'package:webino/setting/scrollbehavior.dart';
import 'package:webino/my_flutter_app_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ReminderButton.dart';
import 'SpecialEvent/SpecialEvent.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    Key? key,
    required this.fromPage,
  }) : super(key: key);
  final String fromPage;
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final storage = new FlutterSecureStorage();
  // final _random = new Random();
  ScrollController scrollController = new ScrollController();

  String token = "";
  String lokasi = "", uName = "UserName";
  String uEmail = "Email@example.org";

  List<String> apiList = [];
  List<dynamic> apiresult = [];
  List pvs = [];
  List specialEvent = [];
  List prd = [];
  List prdInc = [];
  List produk = [];

  List<Color> testas = [Colors.red, Colors.yellow, Colors.blue];
  int feedLength = 12;
  int currentPage = 0;
  int totalPageA = 0;
  int estimasiPanjang = 0;
  int? c = 0;
  int sisa = 0;
  int feeder = 0;
  String sideImage = "";
  bool isLoading = true,
      imageloading = true,
      reload = false,
      newData = false,
      sliderLoading = true;

  @override
  void initState() {
    super.initState();
    this.fetchData();
    this.fetchSlider();
    this.fetchProfile();
    this.fetchSepcialEvent();

    if (widget.fromPage == "main") listenNotifications();
  }

  @override
  void dispose() {
    super.dispose();
    this.fetchData();
    this.fetchSlider();
    this.fetchProfile();
    this.fetchSepcialEvent();
    scrollController.dispose();
  }

  void listenNotifications() => NotificationAPI.onNotifications.stream
      .listen(widget.fromPage == "Detail" ? null : onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DetailFeed(
                from: true,
                slug: payload != null ? jsonDecode(payload)['slug'] : "",
                date: payload != null ? jsonDecode(payload)['tgl'] : "");
          },
        ),
      ).whenComplete(() => null);

  bool onNotificatin(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !imageloading &&
          currentPage != 1) {
        setState(() {
          newData = true;
        });
        fetchDataB();
      }
    }
    return true;
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var responsa = await feedprodukV2();
    if (responsa['code'] == 200) {
      var gem = responsa['data'];
      setState(() {
        totalPageA = responsa['meta']['total_pages'];
      });

      if (gem.length < 9) {
        setState(() {
          currentPage = responsa['meta']['total_pages'];
          prd = gem;
          produk = prd.reversed.toList();
          // feedLength = produk.length;
        });

        fetchDataB();
      } else {
        setState(() {
          currentPage = responsa['meta']['total_pages'];
          prd = gem;
          produk = prd.reversed.toList();
          feedLength = produk.length;
        });

        var b = produk.length;
        double multipler = (b.toDouble() / 8);
        int c = multipler.floor();
        double d = multipler - c;

        setState(() {
          estimasiPanjang = c + 1;
          sisa = (d * 8).toInt();
        });

        setState(() {
          isLoading = false;
          imageloading = false;
        });
      }
    }
  }

  fetchDataB() async {
    int a = currentPage - 1;
    setState(() {
      currentPage = a;
    });

    var responsa = await feedprodukPlus(a);

    if (responsa['code'] == 200) {
      var gemA = responsa['data'];

      setState(() {
        prdInc = gemA;
        produk.addAll(prdInc.reversed.toSet().toList());
        feedLength = produk.length;
      });

      var b = produk.length;
      double multipler = (b.toDouble() / 8);
      int c = multipler.floor();
      double d = multipler - c;

      setState(() {
        estimasiPanjang = c + 1;
        sisa = (d * 8).toInt();
      });

      setState(() {
        newData = false;
        imageloading = false;
      });
    }
  }

  fetchSlider() async {
    var slideresp = await feedSlider();

    if (slideresp['code'] == 200) {
      setState(() {
        apiresult = slideresp['data'];
      });

      apiresult.forEach((element) {
        apiList.add(element['featured_image'].toString());
      });

      setState(() {
        sliderLoading = false;
      });
    }
  }

  fetchProfile() async {
    var tokenA = await storage.read(key: 'token');

    setState(() {
      token = tokenA.toString();
    });

    if (tokenA != "Guest" ||
        tokenA.toString().isNotEmpty ||
        tokenA.toString() != 'null') {
      var userAPI = await userPorfile(tokenA.toString());
      if (userAPI['code'] == 200) {
        setState(() {
          sideImage = userAPI['data']['profile_photo_url'];
          uEmail = userAPI['data']['email'].toString();
          uName = userAPI['data']['name'].toString();
        });
        await storage.write(
            key: 'username', value: userAPI['data']['name'].toString());
        await storage.write(
            key: 'email', value: userAPI['data']['email'].toString());
      }
    }
  }

  fetchSepcialEvent() async {
    int pageSE = 1;
    var responseSE = await feedprodukSepcialEvent(pageSE);
    if (responseSE['code'] == 200) {
      if (responseSE['meta']['total_pages'] >
          responseSE['meta']['current_page']) {
        var response =
            await feedprodukSepcialEvent(responseSE['meta']['total_pages']);

        List specialEventa = response['data'];
        int specialEventaLength = specialEventa.length;
        if (specialEventaLength < 9) {
          int a = responseSE['meta']['total_pages'] - 1;
          var response = await feedprodukSepcialEvent(a);
          specialEventa.addAll(response['data']);
          setState(() {
            specialEvent = specialEventa.reversed.toList();
          });
        } else {
          setState(() {
            specialEvent = specialEventa.reversed.toList();
          });
        }
      } else if (responseSE['meta']['current_page'] ==
          responseSE['meta']['current_page']) {
        List reverse = responseSE['data'];
        setState(() {
          specialEvent = reverse.reversed.toList();
        });
      }
    }
  }

  Future<Null> refreshList() async {
    setState(() {
      reload = true;
      imageloading = true;
      sliderLoading = true;
    });
    fetchData();
    fetchSlider();
    fetchSepcialEvent();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      reload = false;
    });
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                        fontSize: 14,
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

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    var jumlahkotak = (MediaQuery.of(context).size.width > 1200)
        ? 2
        : (MediaQuery.of(context).size.width > 600)
            ? 4
            : 2;

    double height2 = 308;
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        primary: false,
        key: _scaffoldKey,
        endDrawer: SideAppbar(
          uName: uName,
          uEmail: uEmail,
          storage: storage,
          image: sideImage,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Background(),
            Container(
              // color: Colors.blue,
              child: Column(
                children: [
                  Column(
                    children: [
                      appBar(context),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 0.0),
                      //   child: Container(
                      //     padding: EdgeInsets.only(bottom: 8),
                      //     //    color: Colors.red.withOpacity(0.5),
                      //     height: 55,
                      //     width: MediaQuery.of(context).size.width,
                      //     child: ScrollConfiguration(
                      //       behavior: MyBehavior(),
                      //       child: ListView(
                      //         scrollDirection: Axis.horizontal,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     right: 14.0, left: 13.0),
                      //                 child: imageloading
                      //                     ? Shimmer.fromColors(
                      //                         baseColor: Color.fromRGBO(
                      //                             156, 223, 255, 1),
                      //                         highlightColor: Colors.white,
                      //                         child: TextButton(
                      //                           style: ButtonStyle(
                      //                             backgroundColor:
                      //                                 MaterialStateProperty.all<
                      //                                     Color>(
                      //                               Colors.white,
                      //                             ),
                      //                             shape:
                      //                                 MaterialStateProperty.all<
                      //                                     RoundedRectangleBorder>(
                      //                               RoundedRectangleBorder(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         50.0),
                      //                                 side: BorderSide(
                      //                                   color: Colors.white,
                      //                                   width: 2,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           onPressed: () {},
                      //                           child: Container(
                      //                             height: (MediaQuery.of(context)
                      //                                     .size
                      //                                     .height *
                      //                                 0.022),
                      //                             width: MediaQuery.of(context)
                      //                                     .size
                      //                                     .width /
                      //                                 4.5,
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.center,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.center,
                      //                               children: [
                      //                                 Icon(
                      //                                   Icons.toc,
                      //                                   color: Colors.white,
                      //                                   size: 20,
                      //                                 ),
                      //                                 Text(
                      //                                   "Filter",
                      //                                   style: TextStyle(
                      //                                       color: Colors.white,
                      //                                       fontSize: 13,
                      //                                       fontWeight:
                      //                                           FontWeight.bold),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       )
                      //                     : TextButton(
                      //                         style: ButtonStyle(
                      //                           backgroundColor:
                      //                               MaterialStateProperty.all<
                      //                                   Color>(
                      //                             Colors.transparent,
                      //                           ),
                      //                           shape: MaterialStateProperty.all<
                      //                               RoundedRectangleBorder>(
                      //                             RoundedRectangleBorder(
                      //                               borderRadius:
                      //                                   BorderRadius.circular(
                      //                                       50.0),
                      //                               side: BorderSide(
                      //                                 color: Colors.white,
                      //                                 width: 2,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         onPressed: () {
                      //                           showDialog(
                      //                             context: context,
                      //                             builder: (context) {
                      //                               // double popUpPadding =
                      //                               //     MediaQuery.of(context).size.width *
                      //                               //         0.0338;
                      //                               return Filter(
                      //                                 biaya: "",
                      //                                 kategori: [],
                      //                                 lokasi: [],
                      //                                 month: [],
                      //                                 year: [],
                      //                                 status: "",
                      //                                 totalPage: totalPageA,
                      //                                 page: currentPage,
                      //                                 pData: produk,
                      //                                 //    loadingLKS: loadingLKS,
                      //                                 //   pvs: pvs,
                      //                                 //    ctg: ctg,
                      //                                 //   data: prd,
                      //                               );
                      //                             },
                      //                           );
                      //                         },
                      //                         child: Container(
                      //                           height: (MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.022),
                      //                           width: MediaQuery.of(context)
                      //                                   .size
                      //                                   .width /
                      //                               4.5,
                      //                           child: Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.center,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.center,
                      //                             children: [
                      //                               Icon(
                      //                                 Icons.toc,
                      //                                 color: Colors.white,
                      //                                 size: 20,
                      //                               ),
                      //                               Text(
                      //                                 "Filter",
                      //                                 style: TextStyle(
                      //                                     color: Colors.white,
                      //                                     fontSize: 13,
                      //                                     fontWeight:
                      //                                         FontWeight.bold),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //               ),
                      //               //  Populer(),
                      //               //   Terbaru(),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 14.0),
                      //   child: TextButton(
                      //     onPressed: () async {
                      //       NotificationAPI.cancel(301);
                      //       var elementASD = [
                      //         {
                      //           "id": 156,
                      //           "product_name":
                      //               "Give Your Best, Let Allah Do The Rest",
                      //           "slug": "give-your-best-let-allah-do-the-rest",
                      //           "tgl": "2021-11-13T08:50",
                      //           "status": "Online",
                      //           "featured_image":
                      //               "https://webino.id/storage/uploads/images/medium/give-your-best-let-allah-do-the-rest_1635921012.jpg",
                      //           "notification_1": null,
                      //           "notification_2": "null",
                      //           "notification_3": "2021-11-13 08:50:00"
                      //         }
                      //       ];
                      //       elementASD.forEach((element) {
                      //         DateTime now = DateTime.now();
                      //         DateTime activate = new DateTime(
                      //             now.year,
                      //             now.month,
                      //             now.day,
                      //             now.hour,
                      //             now.minute,
                      //             now.second + 10);
                      //         //  String lesgo = "2021-11-08 12:03:30";
                      //         var body1 = element['product_name'].toString();
                      //         //var dateParse1 = DateTime.tryParse(lesgo);
                      //         String? paylord = jsonEncode(element);

                      //         NotificationAPI.showScheduledNotification(
                      //           id: 301,
                      //           title:
                      //               'Reminder - Yuk, Jangan Lewatkan Acara pilihanmu',
                      //           body: body1,
                      //           payload: paylord,
                      //           scheduledDate: activate,
                      //         );
                      //       });
                      //     },
                      //     style: ButtonStyle(
                      //       backgroundColor: MaterialStateProperty.all<Color>(
                      //         Colors.white,
                      //       ),
                      //       shape: MaterialStateProperty.all<
                      //           RoundedRectangleBorder>(
                      //         RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(50.0),
                      //           side: BorderSide(
                      //             color: Colors.white,
                      //             width: 2,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     child: Container(
                      //       height:
                      //           (MediaQuery.of(context).size.height * 0.022),
                      //       width: MediaQuery.of(context).size.width / 4.5,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Rekomendasi",
                      //             style: TextStyle(
                      //                 color: Color.fromRGBO(105, 191, 233, 1),
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      //    height: MediaQuery.of(context).size.height - ((20)),
                      child: NotificationListener(
                        onNotification: (t) {
                          if ((t is ScrollEndNotification &&
                                  scrollController
                                          .position.userScrollDirection ==
                                      ScrollDirection.reverse &&
                                  scrollController.position.pixels ==
                                      scrollController
                                          .position.maxScrollExtent) ||
                              (t is ScrollEndNotification &&
                                  scrollController.position.pixels ==
                                      scrollController
                                          .position.maxScrollExtent &&
                                  isLoading == false &&
                                  feedLength < 12)) {
                            onNotificatin(t);

                            //   return false;
                          }

                          return true;
                        },
                        child: RefreshIndicator(
                          onRefresh: refreshList,
                          child: ScrollConfiguration(
                            behavior: MyBehavior(),
                            child: ListView(
                              padding: EdgeInsets.only(
                                  bottom: ((MediaQuery.of(context).size.height *
                                      0.1))),
                              controller: scrollController,
                              shrinkWrap: true,
                              children: [
                                Sliderver2(
                                  newData: newData,
                                  jumlahkotak: jumlahkotak,
                                  sliderapiList: apiList,
                                  sliderLoading: sliderLoading,
                                  sliderData: apiresult,
                                ),
                                //  special.length > 0
                                //  ?
                                Container(
                                  height: height2,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment
                                                      .topCenter, // 10% of the width, so there are ten blinds.
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                    //  Colors.blueGrey.shade200,
                                                  ], // red to yellow
                                                  // tileMode: TileMode
                                                  //     .repeated, // repeats the gradient over the canvas
                                                ),
                                              ),
                                              height: height2 / 2,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  // Alignment(0.9,
                                                  //     0.0), // 10% of the width, so there are ten blinds.
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.white,
                                                    //    Colors.blueGrey.shade200,
                                                    Color.fromRGBO(
                                                        79, 198, 255, 1),
                                                  ], // red to yellow
                                                  // tileMode: TileMode
                                                  //     .repeated, // repeats the gradient over the canvas
                                                ),
                                              ),
                                              height: height2 / 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 7,
                                                left: 13.0,
                                                right: 13.0,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Special Event",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'AvenirNextRoundedPro',
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SpecialEventPage(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Lihat Semua",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromRGBO(
                                                            79, 198, 255, 1),
                                                        // fontWeight:
                                                        //     FontWeight.w500,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 8,
                                            ),
                                            (specialEvent.length > 0 &&
                                                    !reload &&
                                                    !sliderLoading)
                                                ? Expanded(
                                                    child: Container(
                                                      height: 100,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: (specialEvent
                                                                    .length <
                                                                9)
                                                            ? specialEvent
                                                                .length
                                                            : 9,
                                                        itemBuilder: (context,
                                                            indexList) {
                                                          return AspectRatio(
                                                            aspectRatio:
                                                                160 / 250,
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: cardProduk(
                                                                    specialEvent[
                                                                        indexList],
                                                                    indexList)),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : Expanded(
                                                    child: Container(
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: 10,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return AspectRatio(
                                                            aspectRatio:
                                                                160 / 250,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Shimmer
                                                                    .fromColors(
                                                                  baseColor: Color
                                                                      .fromRGBO(
                                                                          156,
                                                                          223,
                                                                          255,
                                                                          1),
                                                                  highlightColor:
                                                                      Colors
                                                                          .white,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      top: 2,
                                                                      bottom: 5,
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.2)),
                                                                        color: Colors
                                                                            .red,
                                                                        //  borderRadius: BorderRadius.circular(10),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(1.0),
                                                                            spreadRadius:
                                                                                1,
                                                                            blurRadius:
                                                                                5,
                                                                            offset:
                                                                                Offset(0, 0),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //    : Container(),
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          //    mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 13,
                                                top: 10,
                                                //   bottom: 13,
                                              ),
                                              child: Text(
                                                'Semua Event',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'AvenirNextRoundedPro',
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  //   fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.zero,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              var jumlahkotak =
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .width >
                                                          1200)
                                                      ? 2
                                                      : (MediaQuery.of(context)
                                                                  .size
                                                                  .width >
                                                              600)
                                                          ? 4
                                                          : 2;
                                              //   var length = produk.le;
                                              if (imageloading == true) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 14,
                                                    right: 14,
                                                  ),
                                                  child: GridView.count(
                                                    padding: EdgeInsets.zero,
                                                    childAspectRatio:
                                                        ((MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    jumlahkotak) -
                                                                26) /
                                                            248,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    crossAxisCount: jumlahkotak,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 10,
                                                    children: List.generate(
                                                      feedLength,
                                                      (index) {
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Shimmer
                                                              .fromColors(
                                                            baseColor:
                                                                Color.fromRGBO(
                                                                    156,
                                                                    223,
                                                                    255,
                                                                    1),
                                                            highlightColor:
                                                                Colors.white,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: 2,
                                                                bottom: 5,
                                                              ),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2)),
                                                                  color: Colors
                                                                      .red,
                                                                  //  borderRadius: BorderRadius.circular(10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              1.0),
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }

                                              return Container(
                                                child: new ListView.builder(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    shrinkWrap: true,
                                                    itemCount: estimasiPanjang,
                                                    physics: ScrollPhysics(),
                                                    itemBuilder:
                                                        (context, indexList) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                          right: 14,
                                                        ),
                                                        child: Container(
                                                          //height: 500,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2),
                                                          child: ((estimasiPanjang -
                                                                          indexList) !=
                                                                      1 ||
                                                                  sisa != 0)
                                                              ? Column(
                                                                  children: [
                                                                    GridView
                                                                        .count(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      childAspectRatio:
                                                                          ((MediaQuery.of(context).size.width - 36) / jumlahkotak) /
                                                                              270,
                                                                      shrinkWrap:
                                                                          true,
                                                                      primary:
                                                                          false,
                                                                      crossAxisCount:
                                                                          jumlahkotak,
                                                                      crossAxisSpacing:
                                                                          10,
                                                                      mainAxisSpacing:
                                                                          10,
                                                                      children:
                                                                          List.generate(
                                                                        (estimasiPanjang - indexList) !=
                                                                                1
                                                                            ? 8
                                                                            : sisa +
                                                                                (newData
                                                                                    ? (sisa.isOdd
                                                                                        ? 1
                                                                                        : sisa.isEven
                                                                                            ? 2
                                                                                            : 0)
                                                                                    : 0),
                                                                        (index) {
                                                                          if (imageloading ==
                                                                              true) {
                                                                            return ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: Shimmer.fromColors(
                                                                                baseColor: Color.fromRGBO(156, 223, 255, 1),
                                                                                highlightColor: Colors.white,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: 2,
                                                                                    bottom: 5,
                                                                                    // left: 14,
                                                                                    // right: 14,
                                                                                  ),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                                                                      //    color: Colors.yellow,
                                                                                      //  borderRadius: BorderRadius.circular(10),
                                                                                      boxShadow: [
                                                                                        BoxShadow(
                                                                                          color: Colors.grey.withOpacity(1.0),
                                                                                          spreadRadius: 1,
                                                                                          blurRadius: 5,
                                                                                          offset: Offset(0, 0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }

                                                                          var index2 =
                                                                              ((8 * indexList) + index);
                                                                          if (index2 <
                                                                              produk.length) {
                                                                            return cardProduk(produk[index2],
                                                                                index2);
                                                                          }
                                                                          return ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child:
                                                                                Shimmer.fromColors(
                                                                              baseColor: Color.fromRGBO(156, 223, 255, 1),
                                                                              highlightColor: Colors.white,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  top: 2,
                                                                                  bottom: 5,
                                                                                  // left: 14,
                                                                                  // right: 14,
                                                                                ),
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                                                                    color: Colors.blue,
                                                                                    //  borderRadius: BorderRadius.circular(10),
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        color: Colors.grey.withOpacity(1.0),
                                                                                        spreadRadius: 1,
                                                                                        blurRadius: 5,
                                                                                        offset: Offset(0, 0),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    // ((estimasiPanjang - //iklan
                                                                    //             indexList) !=
                                                                    //         1)
                                                                    //     ? Padding(
                                                                    //         padding: const EdgeInsets
                                                                    //                 .only(
                                                                    //             top:
                                                                    //                 4.0,
                                                                    //             bottom:
                                                                    //                 8.0),
                                                                    //         child:
                                                                    //             Container(
                                                                    //           child: Text(
                                                                    //               "test"),
                                                                    //           height:
                                                                    //               50,
                                                                    //           width: MediaQuery.of(context)
                                                                    //               .size
                                                                    //               .width,
                                                                    //           color:
                                                                    //               element,
                                                                    //         ),
                                                                    //       )
                                                                    //     : Container(), //iklan
                                                                  ],
                                                                )
                                                              : Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 10,
                                                                  width: 10,
                                                                ),
                                                        ),
                                                      );
                                                    }),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14,
            //left: 16.0,
            right: 10,
            bottom: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 14.0, left: 13.0),
                child: imageloading
                    ? Shimmer.fromColors(
                        baseColor: Color.fromRGBO(156, 223, 255, 1),
                        highlightColor: Colors.white,
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                top: 2,
                                left: 12,
                                right: 12,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Container(
                            height:
                                (MediaQuery.of(context).size.height * 0.032),
                            width: MediaQuery.of(context).size.width / 6.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.toc,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.only(
                              top: 2,
                              left: 12,
                              right: 12,
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // double popUpPadding =
                              //     MediaQuery.of(context).size.width *
                              //         0.0338;
                              return Filter(
                                biaya: "",
                                kategori: [],
                                lokasi: [],
                                month: [],
                                year: [],
                                status: "",
                                totalPage: totalPageA,
                                page: currentPage,
                                pData: produk,
                                //    loadingLKS: loadingLKS,
                                //   pvs: pvs,
                                //    ctg: ctg,
                                //   data: prd,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: (MediaQuery.of(context).size.height * 0.032),
                          width: MediaQuery.of(context).size.width / 6.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(
                                  Icons.toc,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 10,
              //     left: 16.0,
              //   ),
              //   child: Container(
              //     child: Image.asset(
              //       "assets/images/Logo Webino.png",
              //       width: 80,
              //     ),
              //   ),
              // ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      //   top: 10,
                      left: 16.0,
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //  color: Colors.white,
                    //     width: MediaQuery.of(context).size.width / 1.9,
                    child: Row(
                      children: [
                        Icon(
                          MyFlutterApp.search,
                          // size: 20,
                          color: Colors.grey,
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.space,
                    children: [
                      // GestureDetector(
                      //   onTap: () async {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Search(),
                      //       ),
                      //     );
                      //   },
                      //   behavior: HitTestBehavior.translucent,
                      //   child: Container(
                      //     color: Colors.transparent,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         top: 17,
                      //         bottom: 18,
                      //         right: 15.0,
                      //       ),
                      //       child: Icon(
                      //         MyFlutterApp.search,
                      //         color: Colors.white,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Reminderbutton(
                        token: token,
                        pB: 18,
                        pL: 18,
                        pR: 8,
                        pT: 0,
                        size: 32,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: token == "Guest" ||
                                token.toString().isEmpty ||
                                token.toString() == 'null'
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StartPage(
                                      tokenAB: token,
                                    ),
                                  ),
                                );
                              }
                            : !imageloading
                                ? () =>
                                    _scaffoldKey.currentState!.openEndDrawer()
                                : () {},
                        child: Container(
                          color: Colors.transparent,
                          child: Icon(
                            MyFlutterApp.profilehp,
                            color: Colors.white,
                            size: 32,
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
    );
  }

  Widget cardProduk(index, indexList) {
    String name = index['name'].toString();
    String image = index['featured_image'].toString();
    String tanggal = index['tanggal_acara'].split('_')[0].toString();
    String status = index['status'].toString();
    String waktu = index['waktu'].toString();
    String jenispembayaran = index['jenis_pembayaran'].toString();
    String slug = index['slug'].toString();

    return Padding(
      padding: EdgeInsets.only(
        top: 2,
        bottom: 5,
        // left: 14,
        // right: 14,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailFeed(
                from: false,
                date: index['tgl'],
                slug: slug,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            // borderRadius:
            //     BorderRadius.circular(
            //         20),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 15 / 9,
                  child: Container(
                    //height: 115,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: image != ""
                          ? FadeInImage(
                              image: CachedNetworkImageProvider(image),

                              //         NetworkImage(image),
                              placeholder: AssetImage(
                                "assets/images/load.jpg",
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    'assets/images/Picture not found.jpg',
                                    fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 300),
                            )
                          : Image.asset(
                              "assets/images/Picture not found.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              name.isNotEmpty ? name : "Coming Soon",
                              maxLines: 2,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      //   height: 5,
                                      ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            tanggal.isNotEmpty
                                                ? tanggal
                                                : "Coming Soon",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            waktu.isNotEmpty
                                                ? waktu
                                                : "Coming Soon",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            status.isNotEmpty
                                                ? ((status == "Both")
                                                    ? "Online & Offline"
                                                    : status)
                                                : "Coming Soon",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(),
                                        Text(
                                          jenispembayaran.isNotEmpty
                                              ? (jenispembayaran == "Both"
                                                  ? "Gratis & Berbayar"
                                                  : jenispembayaran)
                                              : "Coming Soon",
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              162,
                                              199,
                                              60,
                                              1,
                                            ),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: 374,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Frame 320.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
