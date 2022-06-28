import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:covid_tracker/services/getCases.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class global_cases extends StatefulWidget {
  const global_cases({Key? key}) : super(key: key);

  @override
  _global_casesState createState() => _global_casesState();
}

class _global_casesState extends State<global_cases> {

  Map data = {};
  bool hideUI = false;

  Future getData() async {
    worldCases instance = worldCases();
    await instance.getGlobalCases();
    data = {
      'total' : instance.total,
      'recovered' : instance.recovered,
      'deaths' : instance.deaths,
    };
    return data;
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

    return Sizer(builder:(context, orientation, deviceType)
    {
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
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(164, 22, 26, 1),
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(164, 22, 26, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            0.0,
                            4.0,
                          ),
                          blurRadius: 4.0,
                          spreadRadius: 1,
                        ),
                      ]
                  ),
                  constraints: BoxConstraints.expand(),
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(2.w, 0, 2.w, 2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(
                              'World Cases',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Container(
                            child: Text(
                              'Covid-19 Cases around the Globe',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 13.sp,

                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: FutureBuilder <dynamic> (builder: (context, snapshot) {
                    if (ConnectionState.active != null && !snapshot.hasData){
                      return Padding(
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
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey, width: 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            height: 8.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/active.png'),
                                                    fit: BoxFit.fitHeight
                                                )
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 14,
                                            child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      '${data['total']}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontSize: 18.sp
                                                      ),
                                                    ),
                                                    Text(
                                                      'Total Cases',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Montserrat',
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                )

                                            )
                                        )
                                      ],
                                    )
                                ),
                              )
                          ),
                          Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey, width: 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            height: 8.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/recovered.png'),
                                                    fit: BoxFit.fitHeight
                                                )
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 14,
                                            child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      '${data['recovered']}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 18.sp
                                                      ),
                                                    ),
                                                    Text(
                                                      'Recovered',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Montserrat',
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                )

                                            )
                                        )
                                      ],
                                    )
                                ),
                              )
                          ),
                          Expanded(
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey, width: 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            height: 8.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/dead.png'),
                                                    fit: BoxFit.fitHeight
                                                )
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                            flex: 14,
                                            child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      '${data['deaths']}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontSize: 18.sp
                                                      ),
                                                    ),
                                                    Text(
                                                      'Deceased',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Montserrat',
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                )

                                            )
                                        )
                                      ],
                                    )
                                ),
                              )
                          ),
                        ],
                      );
                    }
                  },
                  future: getData())
                ),
              ),
            ],
          )
      )
      );
    }
    );
  }
}
