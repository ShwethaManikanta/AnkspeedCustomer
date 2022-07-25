import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_ank_customer/Services/apiProvider/cancel_reason_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/nearby_driver_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/order_specific_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/unit_list_api_provider.dart';
import 'package:new_ank_customer/backend/auth/auth_widget.dart';
import 'package:new_ank_customer/backend/auth/auth_widget_builder.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/loading_widget.dart';
import 'package:new_ank_customer/pages/common_provider.dart';
import 'package:new_ank_customer/pages/fetchLocation/fetch_location.dart';
import 'package:new_ank_customer/pages/orderPage/maps_provider.dart';
import 'package:new_ank_customer/pages/profile_page.dart';
import 'package:new_ank_customer/pages/review_add_stops.dart';
import 'package:new_ank_customer/pages/search_page.dart';
import 'package:new_ank_customer/pages/select_vehical.dart';
import 'package:new_ank_customer/pages/splash_screen.dart';
import 'package:provider/provider.dart';
import 'Services/apiProvider/book_vehicle_api_provider.dart';
import 'Services/apiProvider/goods_types_api_provider.dart';
import 'Services/apiProvider/helper_list_api_provider.dart';
import 'Services/apiProvider/login_api_provider.dart';
import 'Services/apiProvider/order_history_api_provider.dart';
import 'Services/apiProvider/registration_api_provider.dart';
import 'Services/apiProvider/vehicle_categories_api_provider.dart';
import 'Services/api_services.dart';
import 'Services/location_services.dart/loaction_shared_preference.dart';
import 'Services/location_services.dart/location_polyline_notifier.dart';
import 'backend/service/firebase_auth_service.dart';
import 'common/common_styles.dart';
import 'common/image_picker_service.dart';
import 'common/utils.dart';
import 'pages/splash_screen.dart';
import 'pages/confirm_location.dart';
import 'pages/home/home.dart';
import 'pages/home/homepage.dart';
import 'pages/my_wallet.dart';
import 'pages/orderDetails/order_detiles.dart';
import 'pages/orderPage/order_page.dart';
import 'pages/packers_and_movers.dart';
import 'pages/payment_page.dart';
import 'pages/profile_setting.dart';
import 'pages/signIn/sign_in_page.dart';

//Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0, 49, 18, 18), // transparent status bar
      statusBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (BuildContext context) => FirebaseAuthService(),
        ),
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
        ChangeNotifierProvider<VehicleCategoriesAPIProvider>(
          create: (_) => VehicleCategoriesAPIProvider(),
        ),
        ChangeNotifierProvider<BookVehicleAPIProvider>(
            create: (_) => BookVehicleAPIProvider()),
        ChangeNotifierProvider<VerifyUserLoginAPIProvider>(
            create: (_) => VerifyUserLoginAPIProvider()),
        ChangeNotifierProvider<HelperListAPIProvider>(
            create: (_) => HelperListAPIProvider()),
        ChangeNotifierProvider<ListGoodTypeAPIProvider>(
            create: (_) => ListGoodTypeAPIProvider()),
        ChangeNotifierProvider<ProfileViewAPIProvider>(
            create: (_) => ProfileViewAPIProvider()),
        ChangeNotifierProvider<UnitListAPIProvider>(
            create: (_) => UnitListAPIProvider()),
        ChangeNotifierProvider<OrderHistoryAPIProvider>(
            create: (_) => OrderHistoryAPIProvider()),
        ChangeNotifierProvider<MapsPolyLineProvider>(
            create: (_) => MapsPolyLineProvider()),
        ChangeNotifierProvider<ViewDetailsMapProvider>(
            create: (_) => ViewDetailsMapProvider()),
        ChangeNotifierProvider<OrderSpecificAPIProvider>(
            create: (_) => OrderSpecificAPIProvider()),
        ChangeNotifierProvider<NearbyDriverListAPIProvider>(
            create: (_) => NearbyDriverListAPIProvider()),
        ChangeNotifierProvider<CancelReasonAPIProvider>(
            create: (_) => CancelReasonAPIProvider())
      ],
      child: AuthWidgetBuilder(
        builder:
            (BuildContext context, AsyncSnapshot<LoggedInUser?> userSnapshot) {
          return MaterialApp(
            title: "ANK Speed",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            routes: {
              'SplashScreen': (context) => const SplashScreen(),
              'SignInPage': (context) => const SignInPage(),
              'MainHomePage': (context) => const MainHomePage(),
              'OrderPage': (context) => const OrderPage(),
              'PaymentPage': (context) => const PaymentPage(),
              'ProfileSetting': (context) => const ProfileSetting(),
              'HomePage': (context) => const HomePage(),
              'PackersAndMovers': (context) => const PackersAndMovers(),
              // 'RentelPackages': (context) => const RentelPackages(),
              'OrderDetiles': (context) => const OrderDetiles(),
              'MyWallet': (context) => const MyWallet(),
              'SearchPage': (context) => const SearchPage(),
              'ConfirmLocation': (context) => ConfirmLocation(),
              'ReviewAddStops': (context) => const ReviewAddStops(),
              'SelectVehical': (context) => const SelectVehical(),
              'ProfilePage': (context) => const ProfilePage(),
            },
            // initialRoute: 'SplashScreen',
            debugShowCheckedModeBanner: false,
            home: AuthWidget(userSnapshot: userSnapshot),
          );
        },
      ),
    );
  }
}

class GetLoginUser extends StatefulWidget {
  const GetLoginUser({Key? key}) : super(key: key);

  @override
  _GetLoginUserState createState() => _GetLoginUserState();
}

class _GetLoginUserState extends State<GetLoginUser> {
  @override
  void initState() {
    if (mounted) {
      getVerifiedUser();
      // final loggedInUserProvider =
      //     Provider.of<LoggedInUser>(context, listen: false);
      // print("User id Phone no for user  - - -- - - " +
      //     loggedInUserProvider.phoneNo!.substring(
      //         loggedInUserProvider.phoneNo!.length - 10,
      //         loggedInUserProvider.phoneNo!.length));
      // if (context.read<VerifyUserLoginAPIProvider>().loginResponse == null)

      // {
      //    String? token =
      //                         await FirebaseMessaging.instance.getToken();
      //   context
      //       .read<VerifyUserLoginAPIProvider>()
      //       .getUser(
      //           deviceToken: ,
      //           userFirebaseID: loggedInUserProvider.uid!,
      //           phoneNumber: loggedInUserProvider.phoneNo!.substring(
      //               loggedInUserProvider.phoneNo!.length - 10,
      //               loggedInUserProvider.phoneNo!.length))
      //       .then((value) {
      //     setUserID();
      //     print("User id assigned for user  - - -- - - " +
      //         context
      //             .read<VerifyUserLoginAPIProvider>()
      //             .loginResponse!
      //             .userDetails!
      //             .id!);
      //   });
      // }
    }

    super.initState();
  }

  getVerifiedUser() async {
    final loggedInUserProvider =
        Provider.of<LoggedInUser>(context, listen: false);
    if (context.read<VerifyUserLoginAPIProvider>().loginResponse == null) {
      String? token = await FirebaseMessaging.instance.getToken();
      context
          .read<VerifyUserLoginAPIProvider>()
          .getUser(
              deviceToken: token ?? "NA",
              deviceType: "ANKCustomer",
              phoneNumber: loggedInUserProvider.phoneNo!.substring(
                  loggedInUserProvider.phoneNo!.length - 10,
                  loggedInUserProvider.phoneNo!.length))
          .then((value) {
        setUserID();
        /* print("User id assigned for user  - - -- - - " +
            context
                .read<VerifyUserLoginAPIProvider>()
                .loginResponse!
                .userDetails!
                .id!);*/
      });
    }
  }

  setUserID() async {
    ApiServices.userId = await context
        .read<VerifyUserLoginAPIProvider>()
        .loginResponse!
        .loginUserDetails!
        .id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: checkForUserNameAndEmail()
          // HomeBottomNavigationScreen()

          ),
    );
  }

  checkForUserNameAndEmail() {
    final verifyUserLoginAPIProvider =
        Provider.of<VerifyUserLoginAPIProvider>(context);

    if (verifyUserLoginAPIProvider.isLoading) {
      return ifLoading();
    } else if (verifyUserLoginAPIProvider.error) {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.errorMessage);
    } else if (verifyUserLoginAPIProvider.loginResponse!.status == "0") {
      return Utils.showErrorDialog(
          context, verifyUserLoginAPIProvider.loginResponse!.message!);
    }
    if (verifyUserLoginAPIProvider.loginResponse!.loginUserDetails!.email ==
            null ||
        verifyUserLoginAPIProvider.loginResponse!.loginUserDetails!.email ==
            "" ||
        verifyUserLoginAPIProvider.loginResponse!.loginUserDetails!.userName ==
            null ||
        verifyUserLoginAPIProvider.loginResponse!.loginUserDetails!.userName ==
            "") {
      return const GetUserNameAndEmail();
    } else {
      return const GetLocation();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}

class LocationInitialize extends StatefulWidget {
  const LocationInitialize({Key? key}) : super(key: key);

  @override
  _LocationInitializeState createState() => _LocationInitializeState();
}

class _LocationInitializeState extends State<LocationInitialize> {
  @override
  void initState() {
    super.initState();
    SharedPreference.setValues().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPreference.initializeSharedPreference ==
        InitializeSharedPreference.uninitialize) {
      return ifLoading();
    } else {
      return const HomePage();
    }
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}

class GetUserNameAndEmail extends StatefulWidget {
  const GetUserNameAndEmail({Key? key}) : super(key: key);

  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserNameAndEmail> {
  bool showNextScreen = false;
  String? deviceToken;

  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  bool isLocationInitialized = false;

  bool nameVerified = false, emailVerified = false, phoneNumberVerified = false;

  @override
  void initState() {
    initialize();
    initializeNameNumber();
    super.initState();
  }

  initializeNameNumber() {
    final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
    phoneNumberController.text = loggedInUser.phoneNo!.length > 9
        ? loggedInUser.phoneNo!.substring(3, loggedInUser.phoneNo!.length)
        : loggedInUser.phoneNo!;
    if (loggedInUser.phoneNo!.length > 10) {
      if (loggedInUser.phoneNo!
              .substring(3, loggedInUser.phoneNo!.length)
              .length ==
          10) {
        setState(() {
          phoneNumberVerified = true;
        });
      }
    }
    emailController.text = loggedInUser.email ?? "";
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (loggedInUser.email != null && loggedInUser.name != null) {
      if (regex.hasMatch(loggedInUser.email ?? "")) {
        setState(() {
          emailVerified = true;
        });
      }
      name.text = loggedInUser.name!;
      if (loggedInUser.name != "" && loggedInUser.name!.length > 3) {
        setState(() {
          nameVerified = true;
        });
      }
    }

    print(nameVerified.toString() +
        "-------" +
        emailVerified.toString() +
        "-------" +
        phoneNumberVerified.toString());
  }

  initialize() async {
    await SharedPreference.setValues().whenComplete(() {
      setState(() {
        isLocationInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customerName(),
    );
    // return PageView(
    //   physics: NeverScrollableScrollPhysics(),
    //   controller: pageController,
    //   children: [customerName(), selectLocationPage()],
    // );
  }

  customerName() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Utils.getSizedBox(height: 15),
            // Row(
            //   children: [
            //     InkWell(
            //         onTap: () {
            //           Navigator.of(context).pop();
            //         },
            //         child: const Icon(FontAwesomeIcons.arrowLeft))
            //   ],
            // ),
            Utils.getSizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Add Personal Details",
                style: CommonStyles.blue14900(),
              ),
            ),
            Utils.getSizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                "Adding these details is a one time process. Next time, you will be directly presented with home screen",
                maxLines: 2,
                style: CommonStyles.blackw54s9Thin(),
              ),
            ),
            Utils.getSizedBox(height: 15),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  readOnly: true,
                  onChanged: (value) {
                    if (value.length == 10) {
                      setState(() {
                        phoneNumberVerified = true;
                      });
                    } else {
                      setState(() {
                        phoneNumberVerified = false;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 10,
                  decoration: InputDecoration(
                      prefix: Text(
                        "+91  ",
                        style: CommonStyles.black15(),
                      ),
                      counterText: "",
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Phone Number",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                ),
              ),
              key: phoneNumberKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: name,
                  // autovalidateMode: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  onChanged: (value) {
                    if (value.length >= 3) {
                      setState(() {
                        nameVerified = true;
                      });
                      print("Is name verified" + nameVerified.toString());
                    } else {
                      setState(() {
                        nameVerified = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Name",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 2) {
                      return "Minimum Length is 3";
                    }
                    return null;
                  },
                ),
              ),
              key: nameKey,
            ),
            Utils.getSizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    RegExp regex = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    //   String pattern =
                    //       r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
                    // = RegExp(pattern);
                    if (regex.hasMatch(value)) {
                      setState(() {
                        emailVerified = true;
                      });
                    } else {
                      setState(() {
                        emailVerified = false;
                      });
                    }
                    print("email virified" + emailVerified.toString());
                  },
                  decoration: InputDecoration(
                      hintStyle: CommonStyles.blackw54s9Thin(),
                      hintText: "Email",
                      errorStyle: CommonStyles.green9()),
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value!)) {
                      return "Enter Valid email";
                    }
                    return null;
                  },
                ),
              ),
              key: emailKey,
            ),
            Utils.getSizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: MaterialButton(
                  elevation: 18.0,
                  //Wrap with Material
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  minWidth: 100.0,
                  height: 45,
                  color: nameVerified && emailVerified && phoneNumberVerified
                      ? ColorConstant.blue800Cc
                      : Colors.grey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Update', style: CommonStyles.whiteText12BoldW500()),
                      Utils.getSizedBox(width: 10),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed: nameVerified &&
                          emailVerified &&
                          phoneNumberVerified
                      ? () async {
                          if (nameKey.currentState!.validate() &&
                              emailKey.currentState!.validate() &&
                              phoneNumberKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            //call update api here
                            showLoadingWithCustomText(
                                context, "Creating Profile");
                            await apiServices
                                .updateProfile(
                                    userName: name.text,
                                    userEmail: emailController.text,
                                    userPhoneNumber: phoneNumberController.text)
                                .then((value) {
                              // context
                              //     .read<VerifyUserLoginAPIProvider>()
                              //     .getUser(
                              //         deviceToken: "deviceToken",
                              //         userFirebaseID: loggedInUser.uid!,
                              //         phoneNumber: loggedInUser.phoneNo!
                              //             .substring(
                              //                 3, loggedInUser.phoneNo!.length));
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const GetLocation()));
                            });
                          }
                        }
                      : () {
                          // pageController.nextPage(
                          //     duration: Duration(milliseconds: 150),
                          //     curve: Curves.ease);
                          print(nameVerified.toString() +
                              "-------" +
                              emailVerified.toString() +
                              "-------" +
                              phoneNumberVerified.toString());
                        },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
