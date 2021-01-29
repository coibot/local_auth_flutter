import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_flutter/screens/auth/login_screen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final LocalAuthentication auth = LocalAuthentication();

  //Önce biometric giriş destekleyip desteklemediğine bakılır, sonra varsa hangilerinin desteklediği liste halinde alınır.
  //En sonunda bu işlemlerden sırasıyla faceId-fingerprint denenir, başarılı ise giriş yapılır

  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      setState(() {
        _canCheckBiometrics = canCheckBiometrics;
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.length > 0) {}
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate to Coibot',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    //Burada eğer cancel a basılırsa kullanıcı kendisi kullanıcı adı ve şifre ile giriş yapabilir.
    authenticated
        ? print("ok")
        : Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  void initState() {
    _checkBiometrics();
    _getAvailableBiometrics();
    super.initState();
    _authenticate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Giriş Yapıldı.'),),
    );
  }
}
