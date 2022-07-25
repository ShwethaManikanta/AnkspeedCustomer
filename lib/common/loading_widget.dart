import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/common_buttons.dart';
import 'package:new_ank_customer/common/text_styles.dart';
import 'package:new_ank_customer/common/utils.dart';

showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Loading",
                  style: CommonTextSyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

showLoadingWithCustomText(BuildContext context, String text) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.brown[900],
                    backgroundColor: Colors.brown[100],
                  ),
                  Utils.getSizedBox(height: 20),
                  Text(
                    text,
                    style: CommonTextSyles.textw200BlueS14(),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showAuthenticating(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Authenticating",
                  style: CommonTextSyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

showValidating(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.brown[900],
                  backgroundColor: Colors.brown[100],
                ),
                Utils.getSizedBox(height: 20),
                Text(
                  "Validating",
                  style: CommonTextSyles.textw200BlueS14(),
                ),
              ],
            ),
          ),
        );
      });
}

showErrorMessage(BuildContext context, String message, VoidCallback function) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.info,
                      size: 60,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      message,
                      style: CommonTextSyles.textw200RedS16(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: materialButtonCommon(
                        fun: () {
                          Navigator.of(context).pop();
                        },
                        text: "OK!",
                        elevation: 0),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
