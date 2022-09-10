import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/custom_divider.dart';
import 'package:new_ank_customer/pages/bookPage/booking_success.dart';
import 'package:new_ank_customer/pages/orderPage/order_page.dart';
import 'common_styles.dart';

CustomDividerView buildDivider() => CustomDividerView(
      dividerHeight: 1.0,
      color: Colors.grey[400],
    );

class Utils {
  static getSizedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static thinDivider() {
    return const Divider(
      color: Colors.black26,
      height: 1,
      thickness: 0.7,
    );
  }

  static getCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: Colors.black45,
      ),
    );
  }

  static getThinCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: Colors.blue,
      ),
    );
  }

  static Widget showErrorMessage(String errMessage) {
    return Center(
        child: Text(
      errMessage,
      style: CommonStyles.red12(),
    ));
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSendingOTP(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Sending OTP...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showBookingVehicle(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Booking Vehicle...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget dividerThin() {
    return const Divider(
      color: Colors.black,
      height: 5,
      thickness: 0.5,
    );
  }

  static showSnackBar({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: CommonStyles.whiteText12BoldW500(),
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Error Occured',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          message,
          style: CommonStyles.errorTextStyleStyle(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }

  static bookingSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Booking Successful!',
          style: CommonStyles.black11(),
        ),
        content: Text(
          " You can check this booking staus on Orders Page!!",
          style: CommonStyles.green12(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BookingSuccessfull()));
            },
            child: const Text('OK!'),
          )
        ],
      ),
    );
  }
}

showLoadDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text("Loading...")),
      ],
    ),
  );
  return showDialog(
    barrierDismissible: false,
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget ownContainer(Widget title,
    {Color? borderColor, Color? color, bool borderEnable = true}) {
  return Container(
    alignment: Alignment.bottomCenter,
    //  color: borderEnable ? null : color,
    /*  decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: borderEnable ? Border.all(color: borderColor!) : null,
        color: borderEnable ? null : color),*/
    child: Card(
        color: color,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.blue,
        child: Padding(padding: const EdgeInsets.all(20.0), child: title)),
  );
}

ownBottomSheet(BuildContext context, Widget title, {Color? color}) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
    backgroundColor: color ?? Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: title),
        ],
      ),
    ),
  );
}
