import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_auth_flutter/constants/pref_key_value.dart';
import 'package:local_auth_flutter/screens/home/home_screen.dart';
import 'package:local_auth_flutter/services/shared_preferences_service.dart';
import 'package:flutter/scheduler.dart';

import 'login_screen.dart';

class SplashServiceView extends StatefulWidget {
  @override
  _SplashServiceViewState createState() => _SplashServiceViewState();
}

class _SplashServiceViewState extends State<SplashServiceView> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {
      getToken();
    });

  }

  void getToken() {
    //gerekli servisler cağırılır tokenlar kontrol edilir.
    //_token boşsa login sayfasına, değilse ama tokenlar eşleşmiyorsa login sayfasına.
    //_token boş değil ve eşleşiyorsa home sayfasına gider.
    //deneme token ı
    SharedPreferencesServices.instance.setStringValue("AUTHTOKEN", "ok");

    String _token = SharedPreferencesServices.instance.getStringValue("AUTHTOKEN") ?? "";

    if(_token.isEmpty || _token != AUTH_TOKEN){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
      });
    }else{
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => HomeView()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff20232B),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  SpinKitDualRing(
                    color: Color(0xff44A4D1),
                    size: 150.0,
                    lineWidth: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top : 0.0),
                    child: Center(
                      child: Image.asset(
                        "assets/ikon-1.png",
                        width: 85,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image.asset("assets/ikon-2.png", width: 145,),
          )
        ],
      ),
    );
  }
}
