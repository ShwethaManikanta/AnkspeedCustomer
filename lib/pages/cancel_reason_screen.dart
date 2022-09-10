import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/cancel_reason_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/order_history_api_provider.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/home/home.dart';
import 'package:provider/provider.dart';

class CancelReasonScreen extends StatefulWidget {
  const CancelReasonScreen({Key? key}) : super(key: key);

  @override
  State<CancelReasonScreen> createState() => _CancelReasonScreenState();
}

class _CancelReasonScreenState extends State<CancelReasonScreen> {
  String? selectedIndex;
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    if (context.read<CancelReasonAPIProvider>().cancelReasonModel == null) {
      context.read<CancelReasonAPIProvider>().fetchReasonList();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cancelReasonAPIProvider =
        Provider.of<CancelReasonAPIProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Choose a reason for Cancellation ...",
                  style: CommonStyles.blue13(),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                ),
                cancelReasonAPIProvider.ifLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 0.5,
                      )
                    : buildListView(cancelReasonAPIProvider),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText:
                              "You can add additional comments to improve us !! ",
                          hintStyle: CommonStyles.black11()),
                      controller: reasonController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "GO BACK",
                        style: CommonStyles.whiteText15BoldW500(),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      onPressed: () {
                        setState(() {
                          showAlertDialog(context);
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Confirm",
                        style: CommonStyles.whiteText15BoldW500(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: CommonStyles.green15(),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "YES",
        style: CommonStyles.red15(),
      ),
      onPressed: () async {
        await apiServices.cancelOrder(
            orderId: context
                .read<OrderHistoryAPIProvider>()
                .orderHistoryResponse!
                .orderHistory!
                .first
                .id!,
            reasonID: selectedIndex,
            reasonText: reasonController.text);

        await Navigator.of(context).pushNamedAndRemoveUntil(
            'MainHomePage', (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirm to Cancel !!",
        style: CommonStyles.blue14900(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Are sure do you want to cancel your Booking ?",
        style: CommonStyles.black14(),
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ListView buildListView(CancelReasonAPIProvider cancelReasonAPIProvider) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount:
            cancelReasonAPIProvider.cancelReasonModel!.reasonList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = cancelReasonAPIProvider
                          .cancelReasonModel!.reasonList![index].id;
                      print("Slected id ---------" + selectedIndex.toString());
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.blueAccent, width: 2)),
                        child: (selectedIndex ==
                                cancelReasonAPIProvider
                                    .cancelReasonModel!.reasonList![index].id)
                            ? Center(
                                child: Icon(Icons.check, color: Colors.green),
                              )
                            : null,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        cancelReasonAPIProvider
                            .cancelReasonModel!.reasonList![index].reason!,
                        style: CommonStyles.black15(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
