import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  bool hideUI = false;
  Map data = {};
  var result;


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

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;


    void setupCountries() async {
      Navigator.pop(context);
      result = await Navigator.pushNamed(context, '/countries');

      if (result != null) {
        setState(() {
          data = {
            'country' : result['country'],
            'total' : result['total'],
            'active' : result['active'],
            'recovered' : result['recovered'],
            'deaths' : result['deaths'],
          };
        });
      } else { null; };



    }

    void setupGlobal() async {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/global');

    }


    return Sizer(builder:(context, orientation, deviceType)
    {
      return hideUI ? Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(164, 22, 26, 1),
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
          drawer:  Drawer(
            child: Container(
              color: Color.fromRGBO(104, 13, 14, 1.0),
              child: Column(
                children: [
                  Expanded(
                    flex:1,
                    child: Container(
                      color: Color.fromRGBO(164, 22, 26, 1),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 9.5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Covid World',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:23.sp,
                                    fontFamily: 'Montserrat-Black',
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'A Global Covid Cases Tracker',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 10.sp
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 8.h,
                            width: 100.w,
                            child: ElevatedButton(
                                onPressed: (){
                                  setupGlobal();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:  Color.fromRGBO(104, 13, 14, 1.0),
                                  elevation: 0,

                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.public, color: Colors.white, size:25.sp,),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        'Global Cases',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.sp,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                            width: 100.w,
                            child: ElevatedButton(
                                onPressed: (){
                                  setupCountries();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:  Color.fromRGBO(104, 13, 14, 1.0),
                                  elevation: 0,

                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Icon(Icons.airplane_ticket, color: Colors.white, size:25.sp),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        'Choose Country',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.sp,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                        Row(
                          children: [
                            Text('${data['country']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 22.sp
                              ),
                            ),
                          ],
                        ),
                        Container(
                            child: Text(
                              '${data['total']}',
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
                              'Total Cases',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15.sp,

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
                  child: Column(
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
                                                  '${data['active']}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      fontSize: 18.sp
                                                  ),
                                                ),
                                                Text(
                                                  'Active Cases',
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
                  ),
                ),
              ),
            ],
          )
      );
    }
    );
  }
}
