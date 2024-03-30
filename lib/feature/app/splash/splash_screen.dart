

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/app/welcom/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
      Timer( const Duration(seconds: 2), () {
        if(mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const WelcomePage(),), (route) => false);
        // Navigator.pushNamedAndRemoveUntil(context, PageConst.welcomePage, (route) => false);

        }
       });
       
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Image.asset("assets/whats_app_logo.png", color: Colors.white, width: 100, height: 100,),
            Column(
              children: [
                Text("from", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: greyColor.withOpacity(.6)),),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/meta.png", color: Colors.white, width: 35, height: 35,),
                    const SizedBox(width: 5,),
                    const Text("Meta", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 30,),
              ],
            )
          ],
        )
    );
  }
}