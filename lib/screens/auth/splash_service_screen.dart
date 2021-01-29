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
    getToken();
  }

  void getToken() {
    //gerekli servisler cağırılır tokenlar kontrol edilir.

    //_token boşsa login sayfasına, değilse ama tokenlar eşleşmiyorsa login sayfasına.
    //_token boş değil ve eşleşiyorsa home sayfasına gider.

    String _token = SharedPreferencesService.getString("AUTHTOKEN") ?? "";

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
      color: Color(0xff2F333C),
      child: Center(
        child: Stack(
          children: [
            SpinKitDualRing(
              color: Color(0xff44A4D1),
              size: 125.0,
            ),
            Center(
              child: PhysicalModel(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  shadowColor: Color(0xff44A4D1),
                  shape: BoxShape.circle,
                  elevation: 5,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 65,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
