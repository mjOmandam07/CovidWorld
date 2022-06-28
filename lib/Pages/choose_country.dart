import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:covid_tracker/services/getCases.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class countries extends StatefulWidget {
  const countries({Key? key}) : super(key: key);

  @override
  _countriesState createState() => _countriesState();
}

class _countriesState extends State<countries> {

  Map data = {};
  var loaded = false;
  TextEditingController editingController = TextEditingController();
  var items = [];
  bool hideUI = false;



  Future getData() async {
      worldCases instance = worldCases();
      await instance.getCountry();
      data = {
        'countries': instance.countries
      };
      if (!loaded){
        items.addAll(data['countries']);
        loaded = true;
      }else{
        null;
      }

      return data;
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(data['countries']);
    if(query.isNotEmpty) {
      List dummyListData = [];
      dummySearchList.forEach((item) {
        if((item.toLowerCase()).contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(data['countries']);
      });
    }
  }

  setupCases(country) async {
    worldCases instance = worldCases(inputCountry: '${country}');
    await instance.getCountryCases();
    Navigator.of(context).pop();
    Navigator.pop(context, {
      'country' : instance.inputCountry,
      'total' : instance.total,
      'active' : instance.active,
      'recovered' : instance.recovered,
      'deaths' : instance.deaths,
    });

  }

  @override
  void initState() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            hideUI = false;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            hideUI = true;
          });
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Sizer(builder:(context, orientation, deviceType) {
      return WillPopScope(
          onWillPop: () async {
            Navigator
                .of(context)
                .pop;
            return true;
          },
        child: hideUI ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(164, 22, 26, 1),
              automaticallyImplyLeading: false,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_connected_no_internet_4_outlined, color: Color.fromRGBO(164, 22, 26, 1), size:100.sp,),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                            color: Color.fromRGBO(164, 22, 26, 1),
                            fontFamily: 'Montserrat',
                            fontSize: 20
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),

              ],
            )
        )


        : Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Color.fromRGBO(164, 22, 26, 1),
                  expandedHeight: 20.h,
                  title:  Text('Select Country',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight
                            .w700,
                        fontSize: 20.sp
                    ),
                  ),
                  pinned: true,
                  bottom: PreferredSize(                       // Add this code
                    preferredSize: Size.fromHeight(9.h),      // Add this code
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 5.h),
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: editingController,
                                onChanged: (value) {
                                  filterSearchResults(value);
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: Icon(Icons.search, color: Colors.white)
                                ),
                              ),
                            ),
                          ],
                        ),// Add this code
                  ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(

                    background: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(164, 22, 26, .80),
                      ),
                    ),
                  ),
                ),
                FutureBuilder <dynamic> (builder: (context, snapshot) {
                  if (ConnectionState.active != null && !snapshot.hasData)
                  {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only (top: 20.h),
                        child: Center(
                          child: Column(
                            children: [
                              SpinKitRing(
                                color: Color.fromRGBO(164, 22, 26, 1),
                                size: 20.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context,index){
                            return Padding(
                              padding: EdgeInsets.fromLTRB(3.w, 0.5.h, 3.w, 0.5.h),
                              child: SizedBox(
                                height: 15.h,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: const [
                                                    CircularProgressIndicator(
                                                      color: Color.fromRGBO(164, 22, 26, 1),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text('Loading...')
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                      await setupCases(items[index]);

                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        primary: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${index + 1}.',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Color.fromRGBO(164, 22, 26, 1),
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight
                                                  .w700,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${items[index]}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),

                            );
                          },
                          childCount: items.length,
                          addAutomaticKeepAlives: false,
                        )
                    );

                  }
                },
                  future: getData() ,

                )
              ],
            )
        ),
      );
    });

  }
}


