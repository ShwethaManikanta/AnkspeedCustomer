import 'package:flutter/material.dart';
import 'package:new_ank_customer/backend/service/firebase_auth_service.dart';
import 'package:new_ank_customer/common/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../common/dialoges.dart';
import '../../main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController mobileNum = TextEditingController();
  final mobileNumKey = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();

  bool _isSentOTP = false;

  verifyPhone(BuildContext context) async {
    print(mobileNum.text);
    try {
      Provider.of<FirebaseAuthService>(context, listen: false)
          .signInWithPhoneNumber('+91', "+91" + mobileNum.text, context)
          .then((value) {
        setState(() {
          _isSentOTP = true;
        });
        Navigator.of(context).pop();
      }).catchError((e) {
        print('Error ' + e.toString());
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  verifyOTP(BuildContext context) {
    try {
      Provider.of<FirebaseAuthService>(context, listen: false)
          .verifyOTP(otp.text.toString())
          .then((_) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const GetLoginUser()));
      }).catchError((e) {
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: InkWell(
                //     onTap: () {
                //       // Navigator.pop(context);
                //     },
                //     child: Icon(
                //       Icons.arrow_back_outlined,
                //       color: Colors.green.shade800,
                //       size: 30,
                //     ),
                //   ),
                // ),
                Text(
                  'Hi, there',
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 35),
                    child: Text(
                      'Here To Get Welcome !',
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Form(
                        key: mobileNumKey,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          readOnly: false,
                          keyboardType: TextInputType.phone,
                          maxLines: null,
                          maxLength: 10,
                          controller: mobileNum,
                          validator: (value) {
                            if (value!.isEmpty || value.length != 10) {
                              return "Provide Valid Phone Number";
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0),
                          decoration: InputDecoration(
                            suffix: TextButton(
                              onPressed: () async {
                                if (mobileNumKey.currentState!.validate()) {
                                  showLoading(context);
                                  await verifyPhone(context);
                                }

                                // OtpRequest otpRequest = OtpRequest(
                                //   mobile: int.tryParse(mobileNum.value.text)!,
                                // );
                                // {
                                //   apiServices
                                //       .otpRequest(otpRequest)
                                //       .then((value) {});
                                // }
                              },
                              child: const Text('Send OTP'),
                            ),
                            isDense: true,
                            labelText: '  Mobile Number',
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        readOnly: false,
                        enabled: _isSentOTP,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: otp,
                        obscureText: true,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: _isSentOTP
                              ? " Please Enter OTP "
                              : ' Please Verify Phone Number ',
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            // ResentOtpRequest resentOtpRequest =
                            //     ResentOtpRequest(
                            //   mobile: int.tryParse(mobileNum.value.text)!,
                            // );
                            // {
                            //   apiServices
                            //       .resentOtpRequest(resentOtpRequest)
                            //       .then((value) {});
                            // }
                          },
                          child: Text(
                            'Resent The OTP',
                            style: TextStyle(
                                color: Colors.green.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        verifyOTP(context);
                        // LoginRequest loginRequest = LoginRequest(
                        //   mobile: int.tryParse(mobileNum.value.text)!,
                        //   otp: int.tryParse(otp.value.text)!,
                        // );
                        // apiServices.loginRequest(loginRequest).then((value) {
                        //   if (value != null) {
                        //     print(value);
                        //     Navigator.pushReplacementNamed(
                        //       context,
                        //       'ProfilePage',
                        //     );
                        //   }
                        // });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade800,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 25.0,
                              spreadRadius: 1.0,
                              offset: const Offset(
                                5.0,
                                10.0,
                              ),
                            )
                          ],
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
