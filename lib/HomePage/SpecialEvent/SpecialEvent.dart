import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:shimmer/shimmer.dart';
import 'package:webino/API/SetApi.dart';
import 'package:webino/HomePage/Detail.dart';
import 'package:webino/setting/scrollbehavior.dart';

import '../../my_flutter_app_icons.dart';
import '../Search.dart';

final storage = new FlutterSecureStorage();

class SpecialEventPage extends StatefulWidget {
  const SpecialEventPage({Key? key}) : super(key: key);
  @override
  _SpecialEventPageState createState() => _SpecialEventPageState();
}

class _SpecialEventPageState extends State<SpecialEventPage> {
  List specialEvent = [];
  List specialInc = [];
  List sev1 = [];
  DateTime now = new DateTime.now();
  bool isLoading = true, imageloading = true, newData = false;
  bool reload = false;
  bool sort = false;
  int feedLength = 12;
  int currentPage = 0;
  int totalPageA = 0;
  int estimasiPanjang = 0;
  int? c = 0;
  int sisa = 0;
  int feeder = 0;
  ScrollController scrollController = new ScrollController();
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

  @override
  void initState() {
    super.initState();
    this.fetchSpecialEvent(true);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool onNotificatin(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !imageloading &&
          currentPage != 1) {
        setState(() {
          newData = true;
        });
        fetchSpecialEventB();
      }
    }
    return true;
  }

  fetchSpecialEvent(reload) async {
    int a = 1;
    var specialRSP = await feedprodukSepcialEventPlus(a);
    if (specialRSP['code'] == 200) {
      List sEvent = specialRSP['data'];

      setState(() {
        totalPageA = specialRSP['meta']['total_pages'];
      });
      if (sEvent.length < 9) {
        setState(() {
          currentPage = specialRSP['meta']['total_pages'];
          sev1 = sEvent;
          specialEvent = sev1.reversed.toList();
        });

        fetchSpecialEventB();
      } else {
        print("asd");
        setState(() {
          currentPage = specialRSP['meta']['total_pages'];
          sev1 = sEvent;
          specialEvent = sev1.reversed.toList();
          feedLength = specialEvent.length;
        });

        var b = specialEvent.length;
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

  fetchSpecialEventB() async {
    int a = currentPage - 1;
    if (a != 0) {
      setState(() {
        currentPage = a;
      });

      var responsa = await feedprodukSepcialEvent(a);

      if (responsa['code'] == 200) {
        var gemA = responsa['data'];

        setState(() {
          specialInc = gemA;
          specialEvent.addAll(specialInc.reversed.toSet().toList());
          feedLength = specialEvent.length;
        });

        var b = specialEvent.length;
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
    } else {
      setState(() {
        currentPage = a;
      });

      // var responsa = await feedprodukSepcialEvent(a);

      // if (responsa['code'] == 200) {
      // var gemA = responsa['data'];

      setState(() {
        //  specialInc = gemA;
        // specialEvent.addAll(specialInc.reversed.toSet().toList());
        feedLength = specialEvent.length;
      });

      var b = specialEvent.length;
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
      // }
    }
  }

  Future<Null> refreshList() async {
    setState(() {
      reload = true;
      imageloading = true;
    });
    fetchSpecialEvent(true);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      reload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: GestureDetector(
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
                        specialEvent.sort((a, b) {
                          var adate = a['tgl'];
                          var bdate = b['tgl'];
                          return adate.compareTo(bdate);
                        });
                        //   print(filteredData);
                        sort = false;
                      })
                    : value == 'Furthest Date'
                        ? setState(() {
                            specialEvent.sort((b, a) {
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
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView(
                        children: [
                          Container(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                var jumlahkotak = (MediaQuery.of(context)
                                            .size
                                            .width >
                                        1200)
                                    ? 2
                                    : (MediaQuery.of(context).size.width > 600)
                                        ? 4
                                        : 2;

                                if (imageloading == true) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                      right: 14,
                                    ),
                                    child: GridView.count(
                                      padding: EdgeInsets.zero,
                                      childAspectRatio:
                                          ((MediaQuery.of(context).size.width /
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
                                          //loading1
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Shimmer.fromColors(
                                              baseColor: Color.fromRGBO(
                                                  156, 223, 255, 1),
                                              highlightColor: Colors.white,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 5,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.2)),
                                                    color: Colors.red,
                                                    //  borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(1.0),
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
                                  );
                                }

                                return Container(
                                  child: new ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: estimasiPanjang,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, indexList) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 14.0,
                                            right: 14,
                                          ),
                                          child: Container(
                                            //height: 500,
                                            padding: EdgeInsets.only(bottom: 2),
                                            child:
                                                ((estimasiPanjang -
                                                                indexList) !=
                                                            1 ||
                                                        sisa != 0)
                                                    ? Column(
                                                        children: [
                                                          GridView.count(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            childAspectRatio:
                                                                ((MediaQuery.of(context).size.width -
                                                                            36) /
                                                                        jumlahkotak) /
                                                                    270,
                                                            shrinkWrap: true,
                                                            primary: false,
                                                            crossAxisCount:
                                                                jumlahkotak,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 10,
                                                            children:
                                                                List.generate(
                                                              (estimasiPanjang -
                                                                          indexList) !=
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
                                                                //loading2
                                                                if (imageloading ==
                                                                    true) {
                                                                  return loadingCard();
                                                                }

                                                                var index2 =
                                                                    ((8 * indexList) +
                                                                        index);

                                                                if (index2 <
                                                                    specialEvent
                                                                        .length) {
                                                                  return cardProduk(
                                                                      specialEvent[
                                                                          index2],
                                                                      index2);
                                                                }
                                                                //loading3
                                                                return ClipRRect(
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
                                                                        bottom:
                                                                            5,
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          border:
                                                                              Border.all(color: Colors.grey.withOpacity(0.2)),
                                                                          color:
                                                                              Colors.blue,
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
                                                        ],
                                                      )
                                                    : Container(
                                                        color: Colors.white,
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
                          Container(
                            height: 10,
                          ),
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
    );
  }

  ClipRRect loadingCard() {
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
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(156, 223, 255, 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
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
