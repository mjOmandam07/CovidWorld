import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_tracker/services/getCases.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';


class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  var net_status;
  Future checknet() async {
    await Future.delayed(Duration(seconds: 2), () async{
      var net = await InternetConnectionChecker().hasConnection;
      if (net) {
        setupCases();
        net_status = 1;
        return net_status;
      }
      else{
        net_status = 0;
        return net_status;
      }
    });

  }

  void setupCases() async {
    worldCases instance = worldCases(inputCountry: 'Philippines');
    await instance.getCountryCases();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
    'country' : instance.inputCountry,
    'total' : instance.total,
    'active' : instance.active,
    'recovered' : instance.recovered,
    'deaths' : instance.deaths,
    });

  }

  @override
  void initState() {
    super.initState();
    checknet();

  }


  @override
  Widget build(BuildContext context) {
    return Sizer(builder:(context, orientation, deviceType)
    {
      return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(164, 22, 26, 1)
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Covid World',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Montserrat-Black',
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'A Global Covid Cases Tracker',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 20
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder <dynamic> (builder: (context, snapshot) {
                      if (net_status ==  1){
                        return SpinKitFadingCube(
                          color: Colors.white,
                          size: 50.0,
                        );
                      } else if (net_status == 0){
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                'No Connection',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                              height: 5.h,
                              width: 40.w,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (_) {
                                          return Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  CircularProgressIndicator(
                                                    color: Color.fromRGBO(164, 22, 26, 1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                    await checknet();
                                    Navigator.pop(context);
                                    setState(() {
                                      net_status = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:  Color.fromRGBO(104, 13, 14, 1.0),
                                    elevation: 0,

                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Icon(Icons.refresh, color: Colors.white, size:20.sp,),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Reload',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        );
                      } else {
                        return SpinKitFadingCube(
                          color: Colors.white,
                          size: 50.0,
                        );
                      }
                    },
                        future: checknet()),

                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),

            ],
          )
      );
    });

  }
}
