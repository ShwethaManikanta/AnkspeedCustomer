import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/Services/location_services.dart/local_notification_services.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/home/payment_screen.dart';
import 'package:new_ank_customer/pages/home/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'homepage.dart';
import '../orderPage/order_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool status = false;

  @override
  void initState() {
    LocalNotificationServices.initialize(context);

    //Gives you the message on which user taps
    //and it opened the app is killed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationServices.display(message);

        // final routeFromMessage = message.data['route'];
        // Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //When the app is in foreground
    FirebaseMessaging.onMessage.listen((event) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const HomePage()));
      LocalNotificationServices.display(event);
    });

    //When the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromMessage = message.data['route'];
      // print(routeFromMessage);
      // if (routeFromMessage != null || routeFromMessage != "") {
      //   Navigator.of(context).pushNamed(routeFromMessage);
      // }
      LocalNotificationServices.display(message);
    });

    if (context.read<ProfileViewAPIProvider>().profileViewResponse == null) {
      context.read<ProfileViewAPIProvider>().fetchData();
    }
    super.initState();
  }

  List<Widget> body = [
    const HomePage(),
    const OrderPage(),
    const PaymentScreen(),
    const ProfileScreenMain(),
  ];

  int bodyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: bodyIndex,
        children: body,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBody() {
    return body.elementAt(bodyIndex);
  }

  buildBottomNavigationBar() {
    return TitledBottomNavigationBar(
        activeColor: ColorConstant.blue800Cc,
        inactiveColor: Colors.blue.shade900,
        height: 65,
        currentIndex: bodyIndex,
        onTap: (index) {
          setState(() {
            bodyIndex = index;
          });
        },
        items: [
          TitledNavigationBarItem(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Home'.toUpperCase(),
                  style: CommonStyles.black13(),
                ),
              ],
            ),
            icon: const Icon(Icons.home),
          ),
          TitledNavigationBarItem(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_outlined),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Orders'.toUpperCase(),
                    style: CommonStyles.black13(),
                  ),
                ],
              ),
              icon: const Icon(Icons.access_time_outlined)),
          TitledNavigationBarItem(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Payment'.toUpperCase(),
                    style: CommonStyles.black13(),
                  ),
                ],
              ),
              icon: const Icon(Icons.account_balance_wallet)),
          TitledNavigationBarItem(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Account'.toUpperCase(),
                    style: CommonStyles.black13(),
                  ),
                ],
              ),
              icon: const Icon(Icons.person)),
        ]);
  }
}
