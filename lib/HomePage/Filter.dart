import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webino/API/Models/ProdukModels.dart';
import 'package:webino/API/SetApi.dart';

import 'package:collection/collection.dart';

import '../my_flutter_app_icons.dart';
import 'Filter/FilterPage.dart';

class Filter extends StatefulWidget {
  const Filter({
    Key? key,
    required this.page,
    required this.pData,
    required this.totalPage,
    required this.status,
    required this.lokasi,
    required this.kategori,
    required this.month,
    required this.year,
    required this.biaya,

//    @required this.pvs,
  }) : super(key: key);
  final List lokasi;
  final List kategori;
  final List month;
  final List year;
  final String biaya;

  final String status;
  final int page;
  final List pData;
  final int totalPage;
  // final pvs;
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  DateTime now = new DateTime.now();
  //late Future<Category> futureCategory;
  final controller = TextEditingController();
  String status = "";
  String biaya = "";
  List filterData = [];
  List ctt = [];
  List kota = [];
  bool _isSearching = false,
      _isSearchingLKS = false,
      loadingData = true,
      // loadingData2 = true,
      loadingLKS = true,
      loadingCTG = true;
  List<bool> monthBol = [];
  List<bool> yearBol = [];
  List<bool> pvsBol = [];
  int datalength = 0;
  String _searchText = "";
  String _searchLKSText = "";
  List searchresult = [];
  List lkssearchresult = [];
  List monthSet = [];
  List month = [
    {'id': "01", 'month': 'Januari', 'ac': 'Jan', 'totalDay': 31},
    {'id': "02", 'month': 'Februari', 'ac': 'Feb', 'totalDay': 28 / 29},
    {'id': "03", 'month': 'Maret', 'ac': 'Mar', 'totalDay': 31},
    {'id': "04", 'month': 'April', 'ac': 'Apr', 'totalDay': 30},
    {'id': "05", 'month': 'Mei', 'ac': 'Mei', 'totalDay': 31},
    {'id': "06", 'month': 'Juni', 'ac': 'Jun', 'totalDay': 30},
    {'id': "07", 'month': 'Juli', 'ac': 'Jul', 'totalDay': 31},
    {'id': "08", 'month': 'Agustus', 'ac': 'Aug', 'totalDay': 31},
    {'id': "09", 'month': 'September', 'ac': 'Sep', 'totalDay': 30},
    {'id': "10", 'month': 'Oktober', 'ac': 'Okt', 'totalDay': 31},
    {'id': "11", 'month': 'November', 'ac': 'Nov', 'totalDay': 30},
    {'id': '12', 'month': 'Desember', 'ac': 'Des', 'totalDay': 31}
  ];
  List year = [2021, 2022, 2023];
  List yearSet = [];
  List kategoriType = [];
  List lksSet = [];
  TextEditingController _ctgController = TextEditingController();
  TextEditingController _lksController = TextEditingController();
  List<bool> _isRadioSelected = [];
  List data = [];
  List data2 = [];

  @override
  void initState() {
    super.initState();
    this.fetchLKS();
    this.fetchDatalast();
    //  futureCategory = fetchCategory2();
    this.fetchCtg();
    this.setRadioList();
    this.cekValue();
    _isSearching = false;
    this._searchListExampleState();
    this._searchListLKSExampleState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  cekValue() {
    if (widget.status.isNotEmpty) {
      setState(() {
        status = widget.status;
      });
    }

    if (widget.year.length > 0) {
      year.forEachIndexed((index, element) {
        for (final i in widget.year) {
          if (element == i) {
            // print("${yearBol[index]}");
            setState(() {
              yearBol[index] = true;
            });
          }
        }
      });
    }
    if (widget.biaya.isNotEmpty) {
      setState(() {
        biaya = widget.biaya;
      });
    }

    if (widget.month.length > 0) {
      month.forEachIndexed((index, element) {
        for (final i in widget.month) {
          if (element['id'] == i) {
            setState(() {
              monthBol[index] = true;
            });
          }
        }
      });
    }
  }

  fetchDatalast() async {
//    if (!(widget.totalPage >= 10)) {
    //    print(!(widget.totalPage >= 2));
    var bol4 = List.generate(widget.totalPage, (i) => i + 1);
    var bol5 = List.generate(widget.totalPage, (i) => false);

    bol4.forEachIndexed((index, element) async {
      var getdata = await feedprodukPlus(element);
      if (getdata['code'] == 200) {
        data.addAll(getdata['data']);

        bol5[index] = true;
        //    print(bol5);
      }
      if (!bol5.contains(false)) {
        setState(() {
          datalength = data.length;

          //   print(datalength);
          loadingData = false;
        });
      }
    });
    // } else {
    //   //    print(widget.totalPage);
    //   var bol4 = List.generate(widget.totalPage, (i) => i + 1);
    //   var bol5 = List.generate(widget.totalPage, (a) => false);
    //   var n = (widget.totalPage / 3).round();
    //   var m = (bol4.length / n).round();
    //   var lists = List.generate(
    //       n,
    //       (i) => bol4.sublist(
    //           m * i, (i + 1) * m <= bol4.length ? (i + 1) * m : null));

    //   var bol = List.generate(
    //       n,
    //       (i) => bol5.sublist(
    //           m * i, (i + 1) * m <= bol4.length ? (i + 1) * m : null));
    //   print(bol);

    //   for (int i = 0; i < lists.length; i++) {
    //     print(i);
    //     //     print(lists[i]);

    //     if (bol[i].contains(false)) {
    //       //  print("lesgo ${bol[i]}");
    //       lists[i].forEachIndexed((index, element) async {
    //         // print("i : $i");
    //         // print("index : $index");
    //         // print("element : $element");
    //         var getdata = await feedprodukPlus(element);
    //         print(getdata);
    //         if (getdata['code'] == 200) {
    //           data2.addAll(getdata['data']);
    //           print(data2.length);
    //           bol[i][index] = true;
    //           print(bol);
    //         }
    //         //   if (!bol5.contains(false)) {
    //         //     setState(() {
    //         //       datalength = data.length;
    //         //       loadingData = false;
    //         //     });
    //         //   }
    //       });
    //     }
    //     print("end $i");
    //     //     print("periode ${i + 1}");
    //     //     print((2 * i + 2) / (2 * (i + 1)));
    //     //     print("sisa = ${widget.totalPage - 2 * (i + 1)}");
    //     //     print("c = $c");
    //     //     print("b = $b");
    //     //     int length = perPage;

    //     //     var bol4 = List.generate(length, (a) => ((a + i) + i) + 1);

    //     //   print(bol5);
    //     // lists[i].forEachIndexed((index, element) async {
    //     //   var getdata = await feedprodukPlus(element);
    //     //   if (getdata['code'] == 200) {
    //     //     data2.addAll(getdata['data']);
    //     //     print(data2.length);
    //     //     bol5[index] = true;
    //     //     print(bol5);
    //     //   }
    //     //     //   if (!bol5.contains(false)) {
    //     //     //     setState(() {
    //     //     //       datalength = data.length;
    //     //     //       loadingData = false;
    //     //     //     });
    //     //     //   }
    //     //  });

    //     //     //   var bol5 = List.generate(widget.totalPage, (i) => false);

    //   }
    //  }
  }

  // fetchData3Last() async {
  //   int a = 1;
  //   var getdata = await feedprodukPlus(a);
  //   if (getdata['code'] == 200) {
  //     int totalPageA = getdata['meta']['total_pages'];

  //     for (int i = 1; i < totalPageA; i++) {
  //       print(i);
  //       var getdataB = await feedprodukPlus(i);
  //       if (getdataB['code'] == 200) {
  //         data2.addAll(widget.pData);
  //         data2.addAll(getdataB['data']);

  //         setState(() {
  //           datalength = data2.length;
  //         });
  //       }
  //     }
  //     print('full data done @ ${now.toString().split(" ")[1]}');
  //   }
  //   setState(() {
  //     loadingData2 = false;
  //   });
  // }

  fetchCtg() async {
    var cttrsp = await fetchCategory();
    if (cttrsp['code'] == 200) {
      ctt = cttrsp['data'];

      var bol1 = List.generate(ctt.length, (i) => false);
      _isRadioSelected = bol1;

      if (widget.kategori.length > 0) {
        setState(() {
          kategoriType = widget.kategori;
        });
      }
    }

    setState(() {
      loadingCTG = false;
    });
  }

  fetchLKS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String b = prefs.getString("webinoLocationRongkir") ?? "";
    List asd = jsonDecode(b);

    if (asd.length > 0) {
      kota = asd;
      if (widget.lokasi.length > 0) {
        setState(() {
          lksSet = widget.lokasi;
        });
      }
    }

    setState(() {
      loadingLKS = false;
    });
  }

  _searchListExampleState() {
    _ctgController.addListener(() {
      if (_ctgController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _ctgController.text;
        });
      }
    });
  }

  _searchListLKSExampleState() {
    _lksController.addListener(() {
      if (_lksController.text.isEmpty) {
        setState(() {
          _isSearchingLKS = false;
          _searchLKSText = "";
        });
      } else {
        setState(() {
          _isSearchingLKS = true;
          _searchLKSText = _lksController.text;
        });
      }
    });
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchLKSStart() {
    setState(() {
      _isSearchingLKS = true;
    });
  }

  setRadioList() {
    var bol2 = List.generate(month.length, (i) => false);
    var bol3 = List.generate(year.length, (i) => false);

    monthBol = bol2;
    yearBol = bol3;
  }

  final focus = FocusNode();

  var currentFocus;
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: unfocus,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Dialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height * 0.76),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 14,
                  ),
                  child: DefaultTabController(
                    length: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //      color: Colors.green,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 24.0, left: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Text(
                                            'Filter',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        setState(() {
                                          status = '';
                                          biaya = '';
                                          lksSet.clear();
                                          kategoriType.clear();
                                          pvsBol
                                              .forEachIndexed((index, element) {
                                            setState(() {
                                              pvsBol[index] = false;
                                            });
                                          });
                                          _isRadioSelected
                                              .forEachIndexed((index, element) {
                                            setState(() {
                                              _isRadioSelected[index] = false;
                                            });
                                          });

                                          monthBol
                                              .forEachIndexed((index, element) {
                                            setState(() {
                                              monthBol[index] = false;
                                            });
                                          });
                                          yearBol
                                              .forEachIndexed((index, element) {
                                            setState(() {
                                              yearBol[index] = false;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Reset",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                255, 92, 92, 0.5),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.yellow,
                                child: Column(
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      labelPadding: EdgeInsets.only(
                                        top: 10,
                                        left: 2,
                                        right: 2,
                                      ),
                                      // indicatorPadding: EdgeInsets.only(
                                      //   // left: 30,
                                      //   // right: 30,
                                      //   top: 40,
                                      // ),
                                      indicatorColor:
                                          Color.fromRGBO(105, 191, 233, 1),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      labelColor:
                                          Color.fromRGBO(105, 191, 233, 1),
                                      unselectedLabelColor:
                                          Color.fromRGBO(154, 154, 154, 1),
                                      unselectedLabelStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            // height: 1000,
                                            // padding: EdgeInsets.only(
                                            //     top: 100, bottom: 100),
                                            //   color: Colors.red,
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Text(
                                              "STATUS",
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            //   color: Colors.red,
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Text(
                                              "LOKASI",
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            // color: Colors.red,
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Text(
                                              "KATEGORI",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            //    color: Colors.red,
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            child: Text(
                                              "WAKTU",
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            //   color: Colors.red,
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6.7,
                                            child: Text(
                                              "BIAYA",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 20),
                            child: Container(
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: ListView(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0, bottom: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 2.0,
                                                      right: 6.0,
                                                    ),
                                                    child: MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        side: BorderSide(
                                                          color: status ==
                                                                      "Online" ||
                                                                  status ==
                                                                      "Both"
                                                              ? Color.fromRGBO(
                                                                  156,
                                                                  223,
                                                                  255,
                                                                  1,
                                                                )
                                                              : Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        if (status == "Both") {
                                                          setState(() {
                                                            status = "Offline";
                                                          });
                                                        } else if (status ==
                                                            "Offline") {
                                                          setState(() {
                                                            status = "Both";
                                                          });
                                                        } else if (status ==
                                                            "") {
                                                          setState(() {
                                                            lksSet.clear();
                                                            status = "Online";
                                                          });
                                                        } else {
                                                          setState(() {
                                                            status = "";
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 7,
                                                          bottom: 6,
                                                          left: 22,
                                                          right: 22,
                                                        ),
                                                        child: Text(
                                                          "Online",
                                                          style: TextStyle(
                                                            color: status ==
                                                                        "Online" ||
                                                                    status ==
                                                                        "Both"
                                                                ? Color
                                                                    .fromRGBO(
                                                                    156,
                                                                    223,
                                                                    255,
                                                                    1,
                                                                  )
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 6.0,
                                                    ),
                                                    child: MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        side: BorderSide(
                                                          color: status ==
                                                                      "Offline" ||
                                                                  status ==
                                                                      "Both"
                                                              ? Color.fromRGBO(
                                                                  156,
                                                                  223,
                                                                  255,
                                                                  1,
                                                                )
                                                              : Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        if (status == "Both") {
                                                          setState(() {
                                                            status = "Online";
                                                            lksSet.clear();
                                                          });
                                                        } else if (status ==
                                                            "Online") {
                                                          setState(() {
                                                            status = "Both";
                                                          });
                                                        } else if (status ==
                                                            "") {
                                                          setState(() {
                                                            status = "Offline";
                                                          });
                                                        } else {
                                                          setState(() {
                                                            status = "";
                                                          });
                                                        }
                                                        //   print(status);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 7,
                                                          bottom: 6,
                                                          left: 22,
                                                          right: 22,
                                                        ),
                                                        child: Text(
                                                          "Offline",
                                                          style: TextStyle(
                                                            color: status ==
                                                                        "Offline" ||
                                                                    status ==
                                                                        "Both"
                                                                ? Color
                                                                    .fromRGBO(
                                                                    156,
                                                                    223,
                                                                    255,
                                                                    1,
                                                                  )
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                            top: 12,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Lokasi",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(status ==
                                                                  "Offline" ||
                                                              status == "Both"
                                                          ? 1
                                                          : 0.1),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: status == "Offline" ||
                                                        status == "Both"
                                                    ? () {
                                                        List a = kota;

                                                        if (a.length !=
                                                            lksSet.length) {
                                                          a.forEach((element) {
                                                            var city = element[
                                                                'city_name'];
                                                            var type =
                                                                element['type'];
                                                            var nameCall = type ==
                                                                    'Kabupaten'
                                                                ? "Kab. $city"
                                                                : '$city';

                                                            if (!lksSet
                                                                .contains(
                                                                    nameCall)) {
                                                              lksSet.add(
                                                                  nameCall);
                                                            }
                                                          });
                                                          setState(() {
                                                            lksSet = lksSet;
                                                          });
                                                        } else {
                                                          lksSet.clear();
                                                          setState(() {
                                                            lksSet = lksSet;
                                                          });
                                                        }
                                                      }
                                                    : () {},
                                                child: Container(
                                                  child: Text(
                                                    "Select All",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          105,
                                                          191,
                                                          233,
                                                          status == "Offline" ||
                                                                  status ==
                                                                      "Both"
                                                              ? 1
                                                              : 0.5),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        status == "Offline" || status == "Both"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 12.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              MyFlutterApp
                                                                  .search,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.9,
                                                              child: TextField(
                                                                onTap:
                                                                    _handleSearchLKSStart,
                                                                controller:
                                                                    _lksController,
                                                                onChanged:
                                                                    searchOperationLKS,
                                                                decoration:
                                                                    InputDecoration
                                                                        .collapsed(
                                                                  hintText:
                                                                      "Lokasi",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              15,

                                                                          // height: 0.5,
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      height: 30,
                                                      minWidth: 64,
                                                      color: Color.fromRGBO(
                                                        156,
                                                        223,
                                                        255,
                                                        1,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(55),
                                                        side: BorderSide(
                                                          color: Color.fromRGBO(
                                                            156,
                                                            223,
                                                            255,
                                                            1,
                                                          ).withOpacity(0.5),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {},
                                                      child: Text(
                                                        "Search",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        status == "Offline" || status == "Both"
                                            ? Expanded(
                                                child: loadingLKS
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Container(
                                                        color: Colors.yellow,
                                                        child: lkssearchresult
                                                                        .length !=
                                                                    0 ||
                                                                _lksController.text
                                                                    .isNotEmpty
                                                            ? ListView.builder(
                                                                physics:
                                                                    ClampingScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    lkssearchresult
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int
                                                                            index) {
                                                                  return lksLayout(
                                                                    lkssearchresult[
                                                                        index],
                                                                    index,
                                                                    true,
                                                                  );
                                                                })
                                                            : ListView.builder(
                                                                physics:
                                                                    ClampingScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    kota.length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  //   print(index);
                                                                  return lksLayout(
                                                                    kota[index],
                                                                    index,
                                                                    false,
                                                                  );
                                                                }),
                                                      ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: categorey(context),
                                  ),
                                  //waktu
                                  Container(
                                    color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height /
                                            //     3,
                                            child: ListView(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Tahun",
                                                    ),
                                                    Container(
                                                      // color: Colors.red,
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              year.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 2.0,
                                                                right: 6.0,
                                                              ),
                                                              child:
                                                                  MaterialButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  side:
                                                                      BorderSide(
                                                                    color: yearBol[
                                                                            index]
                                                                        ? Color
                                                                            .fromRGBO(
                                                                            156,
                                                                            223,
                                                                            255,
                                                                            1,
                                                                          )
                                                                        : Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                  ),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed: () {
                                                                  if (yearBol[
                                                                          index] ==
                                                                      false) {
                                                                    setState(
                                                                        () {
                                                                      yearSet.add(
                                                                          year[
                                                                              index]);
                                                                    });
                                                                  } else if (yearBol[
                                                                          index] ==
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      yearSet.remove(
                                                                          year[
                                                                              index]);
                                                                    });
                                                                  }
                                                                  setState(() {
                                                                    yearBol[index] =
                                                                        !yearBol[
                                                                            index];
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 7,
                                                                    bottom: 6,
                                                                    left: 22,
                                                                    right: 22,
                                                                  ),
                                                                  child: Text(
                                                                    "${year[index]}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: yearBol[
                                                                              index]
                                                                          ? Color
                                                                              .fromRGBO(
                                                                              156,
                                                                              223,
                                                                              255,
                                                                              1,
                                                                            )
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                                Text("Bulan"),
                                                Wrap(
                                                  spacing:
                                                      8.0, // gap between adjacent chips
                                                  // runSpacing:
                                                  //     4.0, // gap between lines
                                                  children:
                                                      _generateChildren(12),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //biaya
                                  Container(
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 2,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 2.0,
                                                right: 6.0,
                                              ),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                    color: biaya == "Gratis" ||
                                                            biaya ==
                                                                "Berbayar & Gratis"
                                                        ? Color.fromRGBO(
                                                            156, 223, 255, 1)
                                                        : Colors.grey
                                                            .withOpacity(0.5),
                                                  ),
                                                ),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  if (biaya ==
                                                      "Berbayar & Gratis") {
                                                    setState(() {
                                                      biaya = "Berbayar";
                                                    });
                                                  } else if (biaya ==
                                                      "Berbayar") {
                                                    setState(() {
                                                      biaya =
                                                          "Berbayar & Gratis";
                                                    });
                                                  } else if (biaya == "") {
                                                    setState(() {
                                                      biaya = "Gratis";
                                                    });
                                                  } else {
                                                    setState(() {
                                                      biaya = "";
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 6,
                                                    left: 22,
                                                    right: 22,
                                                  ),
                                                  child: Text(
                                                    "Gratis",
                                                    style: TextStyle(
                                                      color: biaya ==
                                                                  "Gratis" ||
                                                              biaya ==
                                                                  "Berbayar & Gratis"
                                                          ? Color.fromRGBO(
                                                              156,
                                                              223,
                                                              255,
                                                              1,
                                                            )
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 6.0,
                                              ),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                    color: biaya ==
                                                                "Berbayar" ||
                                                            biaya ==
                                                                "Berbayar & Gratis"
                                                        ? Color.fromRGBO(
                                                            156,
                                                            223,
                                                            255,
                                                            1,
                                                          )
                                                        : Colors.grey
                                                            .withOpacity(0.5),
                                                  ),
                                                ),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  if (biaya ==
                                                      "Berbayar & Gratis") {
                                                    setState(() {
                                                      biaya = "Gratis";
                                                    });
                                                  } else if (biaya ==
                                                      "Gratis") {
                                                    setState(() {
                                                      biaya =
                                                          "Berbayar & Gratis";
                                                    });
                                                  } else if (biaya == "") {
                                                    setState(() {
                                                      biaya = "Berbayar";
                                                    });
                                                  } else {
                                                    setState(() {
                                                      biaya = "";
                                                    });
                                                  }
                                                  //     print(status);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 6,
                                                    left: 22,
                                                    right: 22,
                                                  ),
                                                  child: Text(
                                                    "Berbayar",
                                                    style: TextStyle(
                                                      color: biaya ==
                                                                  "Berbayar" ||
                                                              biaya ==
                                                                  "Berbayar & Gratis"
                                                          ? Color.fromRGBO(
                                                              156,
                                                              223,
                                                              255,
                                                              1,
                                                            )
                                                          : Colors.grey,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              loadingData == true
                                  ? Colors.grey
                                  : (status.isNotEmpty ||
                                              kategoriType.length > 0 ||
                                              yearSet.length > 0 ||
                                              monthSet.length > 0 ||
                                              biaya.isNotEmpty) &&
                                          loadingData == false
                                      ? Color.fromRGBO(0, 173, 255, 1)
                                      : Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                  color: loadingData == false
                                      ? Color.fromRGBO(105, 191, 233, 1)
                                      : Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          onPressed: (status.isNotEmpty ||
                                      kategoriType.length > 0 ||
                                      yearSet.length > 0 ||
                                      monthSet.length > 0 ||
                                      biaya.isNotEmpty) &&
                                  loadingData == false
                              ? () {
                                  filterData.clear();

                                  refineData(
                                    status,
                                    lksSet,
                                    kategoriType,
                                    yearSet,
                                    monthSet,
                                    biaya,
                                    data,
                                  );
                                  //  print(lksSet);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterPage(
                                        totalPage: widget.totalPage,
                                        biaya: biaya,
                                        kategori: kategoriType,
                                        lokasi: lksSet,
                                        month: monthSet,
                                        year: yearSet,
                                        status: status,
                                        datab: filterData,
                                        ctg: ctt,
                                        pvs: kota,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => FilterPage(
                                  //       biaya: biaya,
                                  //       kategori: kategoriType,
                                  //       lokasi: lksSet,
                                  //       month: yearSet,
                                  //       year: monthSet,
                                  //       status: status,
                                  //       datab: filterData,
                                  //       ctg: ctt,
                                  //       pvs: kota,
                                  //     ),
                                  //   ),
                                  // );
                                },
                          child: Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  loadingData == false
                                      ? "Tampilkan"
                                      : "Loading data...",
                                  style: TextStyle(
                                      color: loadingData == true ||
                                              (status.isNotEmpty ||
                                                  kategoriType.length > 0 ||
                                                  yearSet.length > 0 ||
                                                  monthSet.length > 0 ||
                                                  biaya.isNotEmpty)
                                          ? Colors.white
                                          : Color.fromRGBO(105, 191, 233, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
            ],
          ),
        ),
      ),
    );
  }

  Column categorey(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            //  top: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  List a = ctt;
                  if (_isRadioSelected.contains(false)) {
                    _isRadioSelected.forEachIndexed((index, element) {
                      setState(() {
                        _isRadioSelected[index] = true;
                      });
                    });
                    a.forEachIndexed((index, element) {
                      if (!kategoriType.contains(element['category'])) {
                        kategoriType.add(element['category']);
                      }
                    });

                    //     print(kategoriType);
                  } else if (_isRadioSelected.contains(true)) {
                    _isRadioSelected.forEachIndexed((index, element) {
                      setState(() {
                        _isRadioSelected[index] = false;
                      });
                      kategoriType.clear();
                      //   print(kategoriType);
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Text(
                    "Select All",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(
                          105, 191, 233, status == "Offline" ? 1 : 0.5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 0.0,
            //  top: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 34,
                child: Row(
                  children: [
                    Icon(
                      MyFlutterApp.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: TextField(
                        onTap: _handleSearchStart,
                        controller: _ctgController,
                        onChanged: searchOperation,
                        decoration: InputDecoration.collapsed(
                          hintText: "Kategori",
                          hintStyle: TextStyle(
                              fontSize: 15,

                              // height: 0.5,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 2.0,
                  right: 3.0,
                ),
                child: MaterialButton(
                  minWidth: 80,
                  color: Color.fromRGBO(
                    156,
                    223,
                    255,
                    1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: Color.fromRGBO(
                        156,
                        223,
                        255,
                        0.5,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      //  lokasi = "Online";
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: loadingCTG
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : searchresult.length != 0 || _ctgController.text.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchresult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return categoryLayout(
                            searchresult[index],
                            index,
                            true,
                          );
                        })
                    : ListView.builder(
                        itemCount: ctt.length,
                        itemBuilder: (BuildContext context, int index) {
                          return categoryLayout(
                            ctt[index],
                            index,
                            false,
                          );
                        }),
          ),
        ),
      ],
    );
  }

  // Widget categorry(BuildContext context) {
  //   return FutureBuilder<Category>(
  //     future: futureCategory,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text(snapshot.data!.message);
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }

  //       // By default, show a loading spinner.
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }

  Widget _generateItem(index) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: monthBol[index]
              ? Color.fromRGBO(
                  156,
                  223,
                  255,
                  1,
                )
              : Colors.grey.withOpacity(0.5),
        ),
      ),
      padding: EdgeInsets.zero,
      onPressed: () {
        if (monthBol[index] == false) {
          setState(() {
            monthSet.add(month[index]['id']);
          });
        } else if (monthBol[index] == true) {
          setState(() {
            monthSet.remove(month[index]['id']);
          });
        }
        setState(() {
          monthBol[index] = !monthBol[index];
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          //   top: 7,
          //   bottom: 6,
          left: 22,
          right: 22,
        ),
        child: Text(
          "${month[index]['month']}",
          style: TextStyle(
            color: monthBol[index]
                ? Color.fromRGBO(
                    156,
                    223,
                    255,
                    1,
                  )
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  List<Widget> _generateChildren(int count) {
    List<Widget> items = [];

    for (int i = 0; i < count; i++) {
      items.add(_generateItem(i));
    }

    return items;
  }

  void searchOperation(String searchText) {
    searchresult.clear();

    if (_isSearching == true) {
      for (int i = 0; i < ctt.length; i++) {
        String data = ctt[i]['category'];
        if (data.toLowerCase().contains(_searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }

  void searchOperationLKS(String searchText) {
    lkssearchresult.clear();

    if (_isSearchingLKS == true) {
      for (int i = 0; i < kota.length; i++) {
        //   print(kota);
        String kotas = kota[i]['city_name'];
        String kabu = kota[i]['type'];
        bool space = _searchLKSText.contains(" ");
        String singkatan = _searchLKSText.split(" ")[0];
        String maybeKota = space ? _searchLKSText.split(" ")[1] : "";

        if (kotas.toLowerCase().contains(_searchLKSText.toLowerCase()) ||
            kabu.toLowerCase().contains(_searchLKSText.toLowerCase()) ||
            (space &&
                (kabu.toLowerCase().contains(singkatan.toLowerCase()) &&
                    kotas.toLowerCase().contains(maybeKota.toLowerCase())))) {
          lkssearchresult.add(kota[i]);
        }
      }
    }
  }

  categoryLayout(index, indox, search) {
    var nameCall = search ? index.toString() : index['category'].toString();
    return GestureDetector(
      onTap: () {
        if (kategoriType.contains(nameCall) == false) {
          kategoriType.add(nameCall);
          kategoriType.toSet();
          setState(() {
            kategoriType = kategoriType;
          });
        } else if (kategoriType.contains(nameCall) == true) {
          kategoriType.toSet();
          kategoriType.remove(nameCall);
          setState(() {
            kategoriType = kategoriType;
          });
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text(
                nameCall,
              ),
              trailing: Icon(
                  kategoriType.contains(nameCall)
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 18,
                  color: kategoriType.contains(nameCall)
                      ? Colors.blue
                      : Colors.black),
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  lksLayout(index, indox, search) {
    var city = index['city_name'];
    var type = index['type'];
    var nameCall = type == 'Kabupaten' ? "Kab. $city" : '$city';

    return GestureDetector(
      onTap: () async {
        if (lksSet.contains(nameCall) == false) {
          lksSet.add(nameCall);
          lksSet.toSet();
          setState(() {
            lksSet = lksSet;
          });
        } else if (lksSet.contains(nameCall) == true) {
          lksSet.toSet();
          lksSet.remove(nameCall);
          setState(() {
            lksSet = lksSet;
          });
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            ListTile(
              title: Text(nameCall //+ pvsBol[indox].toString(),
                  ),
              trailing: Icon(
                  lksSet.contains(nameCall) // kota[indox]['pick']
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 18,
                  color:
                      lksSet.contains(nameCall) ? Colors.blue : Colors.black),
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Function deepEq = const DeepCollectionEquality().equals;
  refineData(
    status,
    lokasi,
    kategori,
    year,
    month,
    biaya,
    data,
  ) {
    List categore = kategori;
    List statusList = [];
    List lokasiFilt = [];
    List lokasiList = lokasi;
    List mergeLokasi = [];
    List allLokasi = [];
    List kategoriList = [];
    List mergeKategori = [];
    List kategoriListsum = [];
    List biayaList = [];
    List dateEXP = [];

    List listMonthsame = [];
    List yearSame = [];
    List inverseYear = [];
    List inverseMonth = [];

    List allCompare = [];
    List mergeAll = [];

    //#1 status
    if (status.toString().isNotEmpty) {
      statusList = data.where((b) => b['status'] != status).toList();
    }
    //#2 biaya
    if (biaya.toString().isNotEmpty) {
      biayaList = data.where((b) => b['jenis_pembayaran'] != biaya).toList();
    }
    //#3 kategori
    if (kategori.length > 0) {
      categore.forEach((element) {
        for (final i in data) {
          if (i['categori'][0]['nameb'].toString().contains(element)) {
            kategoriListsum.add(i);
          }
        }
      });

      mergeKategori = kategoriListsum.toSet().toList();

      data.forEach((element) {
        if (!mergeKategori.contains(element)) {
          kategoriList.add(element);
        }
      });
    }

    //#4 lokasi
    if (lokasi.length > 0) {
      lokasi.toSet().toList();
      lokasiList.forEach((element) {
        if (element.toString().contains("Kab.")) {
          for (final i in data) {
            if (i['status'] == status) {
              //  String city = element.toString().split(" ")[1];

              String city = element.toString().replaceAll("Kab.", "Kabupaten");

              if (i['city'].toString().contains(city)) {
                lokasiFilt.add(i);
              }
            }
          }
        } else {
          for (final i in data) {
            if (i.toString().contains(element)) {
              lokasiFilt.add(i);
            }
          }
        }
      });

      mergeLokasi = lokasiFilt.toSet().toList();

      data.forEach((element) {
        if (!mergeLokasi.contains(element)) {
          allLokasi.add(element);
        }
      });

      //  print(allLokasi.length);
    }
    // #5 waktu Year

    if (year.length > 0) {
      year.forEach((element) {
        for (final i in data) {
          if (i['tgl']
              .toString()
              .split("T")[0]
              .split("-")[0]
              .contains(element.toString())) {
            yearSame.add(i);
          }
        }
        //   print(element);
      });

      data.forEach((element) {
        if (!yearSame.contains(element)) {
          inverseYear.add(element);
        }
      });
    }
    // #5 waktu Month
    if (month.length > 0) {
      month.forEach((element) {
        for (final i in data) {
          if (i['tgl']
              .toString()
              .split("T")[0]
              .split("-")[1]
              .contains(element.toString())) {
            listMonthsame.add(i);
          }
        }
      });

      data.forEach((element) {
        if (!listMonthsame.contains(element)) {
          inverseMonth.add(element);
        }
      });
      //  print("inverse month ${inverseMonth.length}");
    }

    for (final i in data) {
      if (!now.isBefore(DateTime.tryParse(i['tgl'])!) == true) {
        dateEXP.add(i);
      }
    }
    // if duedate + 1
//  for (final i in data) {
//       var others = DateTime.tryParse(i['tgl'])!.toString().split('T')[0];
//       var other = DateTime.tryParse(others)!;
//       var limitData = new DateTime(other.year, other.month, other.day + 1);
//       print("limit : $limitData");
//       print("other : $other");
//       if (!now.isBefore(limitData) == true) {
//         dateEXP.add(i);
//       }
//     }
    //   print(waktuList.length);
    allCompare = statusList +
        biayaList +
        kategoriList +
        allLokasi +
        inverseYear +
        inverseMonth +
        dateEXP;
    mergeAll = allCompare.toSet().toList();

    data.forEach((element) {
      if (!mergeAll.contains(element)) {
        filterData.add(element);
      }
    });

    // int? todayDay = int.tryParse(today[0].toString());
    // int? todayMonth = int.tryParse(today[1].toString());
    // int? todayYear = int.tryParse(today[2].toString());

    // print("stat ${statusList.length}");
    // print("biaya ${biayaList.length}");
    // print("ktg ${kategoriList.length}");
    // print("waktuList ${mergeAllWaktu.length}");
    // print("lokalisasi ${allLokasi.length}");
    // print("otw ${waktuList.length}");
  }
}
