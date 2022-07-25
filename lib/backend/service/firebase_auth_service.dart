import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/pages/home/homepage.dart';

import '../../main.dart';

@immutable
class LoggedInUser {
  const LoggedInUser(
      {required this.uid,
      required this.phoneNo,
      required this.email,
      required this.name});
  final String? uid;
  final String? phoneNo;
  final String? email;
  final String? name;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  //VerificationId in when otp is generated
  String? verificationId;
  int? resendToken;

  LoggedInUser? _userFromFirebase(User? user) {
    return user == null
        ? null
        : LoggedInUser(
            uid: user.uid,
            phoneNo: user.phoneNumber,
            email: user.email,
            name: user.displayName);
  }

  Stream<LoggedInUser?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<LoggedInUser?> signInAnonymously() async {
    UserCredential authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signInWithPhoneNumber(
      String countryCode, String mobile, BuildContext context) async {
    // final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
    //   verificationId = verId;
    // };
    try {
      await _firebaseAuth.verifyPhoneNumber(
          forceResendingToken: resendToken,
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
          },
          codeSent: (String? verificationId, int? resendToken) async {
            verificationId = verificationId;
            resendToken = resendToken;
          },
          phoneNumber: mobile,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth
                .signInWithCredential(phoneAuthCredential)
                .then((value) {
              _userFromFirebase(value.user);
              print(
                  "SIgn in wiht credentisl - - - - - - ---  - - -- - -  - success");

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const GetLoginUser()));
            });
          },
          verificationFailed: (FirebaseAuthException error) {
            throw error;
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithPhoneNumberAutoVerify(
      String countryCode, String mobile, BuildContext context,
      {Widget? pushWidget}) async {
    var mobileToSend = mobile;
    PhoneCodeSent smsOTPSent(String verId, [int? forceCodeResend]) {
      verificationId = verId;
      resendToken = forceCodeResend;
      return ((verificationId, forceResendingToken) => verificationId);
    }

    try {
      print("The processing phone numbere is  - - - - - - - - - - " +
          mobileToSend);
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 30,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            print('Verification Complete');

            await _firebaseAuth
                .signInWithCredential(phoneAuthCredential)
                .then((value) {
              _userFromFirebase(value.user);
              print(
                  "SIgn in wiht credentisl - - - - - - ---  - - -- - -  - success");
              if (pushWidget != null) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => pushWidget));
              }
            });

            // });

            print("Verification Complete" + phoneAuthCredential.toString());
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? currentUser = _firebaseAuth.currentUser;
      print(userCredential.user);
      if (currentUser != null) {
        print(currentUser.uid);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Phone authentication implicitly.. when device reads auto code
  // Future<LoggedInUser> signInWithCredential(AuthCredential credential) async {
  //   UserCredential userCredential =
  //       await _firebaseAuth.signInWithCredential(credential);
  //   return _userFromFirebase(userCredential.user);
  // }

  // void signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
  //   _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential credential) async {
  //         return await signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException exception) {
  //         print(exception);
  //       },
  //       codeSent: (String verificationId, [int forceResendingToken]) {
  //         showDialogWidget(verificationId, context);
  //       },
  //       codeAutoRetrievalTimeout: null);
  // }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Future<void> signInWithPhoneNumber(String countryCode, String mobile) async {
  //   var mobileToSend = mobile;
  //   final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
  //     this.verificationId = verId;
  //   };
  //   try {
  //     await _firebaseAuth.verifyPhoneNumber(
  //         phoneNumber: mobileToSend,
  //         codeAutoRetrievalTimeout: (String verId) {
  //           //Starts the phone number verification process for the given phone number.
  //           //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
  //           this.verificationId = verId;
  //         },
  //         codeSent: smsOTPSent,
  //         timeout: const Duration(
  //           seconds: 120,
  //         ),
  //         verificationCompleted: (AuthCredential phoneAuthCredential) {
  //           print(phoneAuthCredential);
  //         },
  //         verificationFailed: (FirebaseAuthException exception) {
  //           throw exception;
  //         });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> verifyOTP(String otp) async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: otp,
  //     );
  //     final UserCredential user =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     final User? currentUser = _firebaseAuth.currentUser;
  //     print(user);

  //     if (currentUser!.uid != "") {
  //       print(currentUser.uid);
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
