import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:new_ank_customer/Services/apiProvider/cancel_reason_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/order_history_api_provider.dart';
import 'package:new_ank_customer/pages/cancel_reason_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingSuccessfull extends StatefulWidget {
  const BookingSuccessfull({Key? key}) : super(key: key);

  @override
  State<BookingSuccessfull> createState() => _BookingSuccessfullState();
}

class _BookingSuccessfullState extends State<BookingSuccessfull>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 5));
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              //  height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ANK Speed",
                    style: CommonStyles.blue18900(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "We have really proud to service you ..!!",
                    style: CommonStyles.blue18900(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/wait.gif"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Waiting For Driver Response  ",
                        style: CommonStyles.black13(),
                      ),
                      Countdown(
                        animation: StepTween(
                          begin: 5 * 60,
                          end: 0,
                        ).animate(_controller!),
                      ),
                      Text(
                        "  Mins",
                        style: CommonStyles.green12(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AvatarGlow(
                    endRadius: 100,
                    showTwoGlows: true,
                    glowColor: Colors.blue.shade900,
                    child: Container(
                      child: Image.asset("assets/anklogo.png",
                          height: 500, width: 500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CancelReasonScreen()));
                });

                //  await showAlertDialog(context);
              },
              child: Text(
                "Cancel",
                style: CommonStyles.whiteText15BoldW500(),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: ColorConstant.blue800Cc,
              onPressed: () => launch("tel://21213123123"),
              child: Text(
                "Support",
                style: CommonStyles.whiteText15BoldW500(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CountDown Class

class Countdown extends AnimatedWidget {
  Countdown({this.animation}) : super(listenable: animation!);
  Animation<int>? animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text("$timerText", style: CommonStyles.blue14900());
  }
}
