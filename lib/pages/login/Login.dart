import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/image_const.dart';
import 'package:new_ank_customer/common/maths.dart';
import 'package:new_ank_customer/pages/login/phoneVerification/verifyScreen.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';
import 'package:provider/provider.dart';

import '../../backend/service/firebase_auth_service.dart';
import '../../common/common_styles.dart';
import '../../common/utils.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(
              1.92085269161402e-9,
              0.44843749717110765,
            ),
            end: Alignment(
              1.0000000019208526,
              0.44843749108295017,
            ),
            colors: [
              ColorConstant.blue800Cc,
              ColorConstant.purple800Cc,
            ],
          ),
        ),
        height: deviceHeight(context),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                  //  height: deviceHeight(context) * 0.85,
                  child: const PhoneLoginFragment()),
              /* SizedBox(
                  height: deviceHeight(context) * 0.15,
                  child: const TermsAndConditionsSegment())*/
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneLoginFragment extends StatefulWidget {
  const PhoneLoginFragment({Key? key}) : super(key: key);

  @override
  _PhoneLoginFragmentState createState() => _PhoneLoginFragmentState();
}

class _PhoneLoginFragmentState extends State<PhoneLoginFragment> {
  String? deviceToken;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  String phoneNo = "Your number here";
  String? smsCode;

  TextEditingController _phoneController = TextEditingController();

  MobileNumberPicker mobileNumber = MobileNumberPicker();
  static MobileNumber mobileNumberObject = MobileNumber();

  TextEditingController mobileNumberController = TextEditingController();
  final mobileNumberKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WidgetsBinding.instance
          .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
      mobileNumber.getMobileNumberStream.listen((MobileNumber? event) {
        if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
          setState(() {
            mobileNumberObject = event!;
            _phoneController = TextEditingController(
                text: mobileNumberObject.phoneNumber!.toString());
          });
        }
      });
    }
    super.initState();
  }

  verifyPhone(BuildContext context) async {
    final firebaseAuthServiceProvider =
        Provider.of<FirebaseAuthService>(context, listen: false);

    try {
      Utils.showSendingOTP(context);
      await firebaseAuthServiceProvider
          .signInWithPhoneNumberAutoVerify(
              "+91", "+91" + _phoneController.text.toString(), context,
              pushWidget: const GetLoginUser())
          .catchError((e) {
        print("eroor" + e.toString());
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }

        Utils.showErrorDialog(context, errorMsg);
      });
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyScreen(
                phoneNumber: _phoneController.text,
                userName: "",
              )));
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: getVerticalSize(
                0.00,
              ),
              right: getHorizontalSize(
                28.40,
              ),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: getHorizontalSize(
                      331.60,
                    ),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            //  color: Colors.red,
                            height: getVerticalSize(
                              593.00,
                            ),
                            width: getHorizontalSize(
                              331.60,
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgRectangle12,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: size.width,
                            margin: EdgeInsets.only(
                              left: getHorizontalSize(
                                12.00,
                              ),
                              right: getHorizontalSize(
                                12.00,
                              ),
                              bottom: getVerticalSize(
                                10.00,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Login",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      33,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        10.00,
                      ),
                      top: getVerticalSize(
                        122.00,
                      ),
                      right: getHorizontalSize(
                        10.00,
                      ),
                      bottom: getVerticalSize(
                        122.00,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: getHorizontalSize(
                              10.00,
                            ),
                          ),
                          child: Text(
                            "Get started with ANK Speed",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(
                                17,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(
                              2.00,
                            ),
                            top: getVerticalSize(
                              12.00,
                            ),
                            right: getHorizontalSize(
                              10.00,
                            ),
                          ),
                          child: Text(
                            "Enter your mobile number",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(
                                15,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: getVerticalSize(
                              12.00,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                20.00,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.black900,
                              width: getHorizontalSize(
                                0.10,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.black900,
                                spreadRadius: getHorizontalSize(
                                  2.00,
                                ),
                                blurRadius: getHorizontalSize(
                                  2.00,
                                ),
                                offset: Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLength: 10,
                            cursorColor: Colors.teal[800],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: "+91    ",
                              counterText: "",
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            controller: _phoneController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: getVerticalSize(
                              21.00,
                            ),
                            right: getHorizontalSize(
                              10.00,
                            ),
                          ),
                          width: getHorizontalSize(
                            190.00,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: checkBoxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      checkBoxValue = value!;
                                      print(checkBoxValue);
                                    });
                                  }),
                              Expanded(
                                child: Text(
                                  "I accept the Tems of Use & Privacy Policy",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      9,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                190.00,
                              ),
                              top: getVerticalSize(
                                100.00,
                              ),
                              right: getHorizontalSize(
                                20.00,
                              ),
                            ),
                            child: Container(
                              height: getSize(
                                40.00,
                              ),
                              width: getSize(
                                40.00,
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    if (_phoneController.text.isNotEmpty &&
                                        checkBoxValue == true) {
                                      verifyPhone(context);
                                      ApiServices.userId = "1";
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 30,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool checkBoxValue = true;
}

class TermsAndConditionsSegment extends StatefulWidget {
  const TermsAndConditionsSegment({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsSegmentState createState() =>
      _TermsAndConditionsSegmentState();
}

class _TermsAndConditionsSegmentState extends State<TermsAndConditionsSegment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "By continuing, you agree to our ",
          style: CommonStyles.blackw54s9Thin(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(
                      context: context, text: "Terms Of Service");
                },
                child: Text(
                  "Terms of Service",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                )),
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(context: context, text: "Privacy Policy");
                },
                child: Text(
                  "Privacy Policy",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                )),
            TextButton(
                onPressed: () {
                  Utils.showSnackBar(context: context, text: "Content Policy");
                },
                child: Text(
                  "Content Policy",
                  style: CommonStyles.blackw54s9ThinUnderline(),
                ))
          ],
        )
      ],
    );
  }
}
