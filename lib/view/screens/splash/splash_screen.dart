import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/helper/network_info.dart';
import 'package:bed3avendor/provider/auth_provider.dart';
import 'package:bed3avendor/provider/splash_provider.dart';
import 'package:bed3avendor/utill/app_constants.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/screens/auth/auth_screen.dart';
import 'package:bed3avendor/view/screens/dashboard/dashboard_screen.dart';
import 'package:bed3avendor/view/screens/splash/widget/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  final int? orderId;

  const SplashScreen({Key? key, this.orderId}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((bool isSuccess) {
      if(isSuccess) {
        Provider.of<SplashProvider>(context, listen: false).initShippingTypeList(context,'');
        Timer(Duration(seconds: 1), () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Provider.of<AuthProvider>(context, listen: false).updateToken(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => AuthScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        clipBehavior: Clip.none, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: SplashPainter(),
          ),
        ),

        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                  tag:'logo',
                  child: Image.asset(Images.white_logo, height: 80.0,
                      fit: BoxFit.cover, width: 150.0)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
              Text(AppConstants.APP_NAME, style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_WALLET,
                  color: Colors.white),
              ),
            ],
          ),
        ),
      ],
      )
    );
  }

}
