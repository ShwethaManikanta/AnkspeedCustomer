import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_ank_customer/Services/apiProvider/coupon_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/order_history_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/common/loading_widget.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/common_styles.dart';
import '../../common/utils.dart';
import '../bookPage/book_vehicle.dart';
import 'googleMaps/maps_widget.dart';

class OrderPageListView extends StatefulWidget {
  const OrderPageListView({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<OrderPageListView> createState() => _OrderPageListViewState();
}

class _OrderPageListViewState extends State<OrderPageListView> {
  Timer? waitingTime;
  String displayTime = "0";

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void dispose() {
    super.dispose();
    waitingTime?.cancel();
  }

  String getStartingTime() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context, listen: false);

    if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.index].orderStatus ==
        "5") {
      // return "2022-03-27 11:47:00";

      //Return Starting trip time (loading time)

      return orderHistoryAPIProvider.orderHistoryResponse!
          .orderHistory![widget.index].tripDetails!.startLoadingTime!;
    } else if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.index].orderStatus ==
        "7") {
      return orderHistoryAPIProvider.orderHistoryResponse!
          .orderHistory![widget.index].tripDetails!.startUnloadingTime!;

      //Return Starting trip time (unloading time)

    } else {
      return DateTime.now().toString();
    }
  }

  @override
  void initState() {
    if (mounted) {
      waitingTime = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          Duration diff =
              DateTime.now().difference(DateTime.parse(getStartingTime()));
          displayTime = formatTime(diff.inSeconds);
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return orderpagelistview(index: widget.index);
  }

  Widget orderpagelistview({required int index}) {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);

    List<Model> list = [];

    list.add(Model(
        orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![index]
            .tripDetails!.fromAddress!,
        Colors.green));
    list.add(Model(
        orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![index].tripDetails!.toAddress!,
        Colors.red));
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /*     if (orderHistoryAPIProvider
                          .orderHistoryResponse!
                          .orderHistory![index]
                          .vechileDetails!
                          .image!
                          .isNotEmpty)
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: 30,
                            height: 30,
                            imageUrl: orderHistoryAPIProvider
                                    .orderHistoryResponse!.vehicleBaseurl! +
                                orderHistoryAPIProvider
                                    .orderHistoryResponse!
                                    .orderHistory![index]
                                    .vechileDetails!
                                    .image!,
                          ),
                        ),*/
                      Utils.getSizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              orderHistoryAPIProvider.orderHistoryResponse!
                                  .orderHistory![index].bookedDate!,
                              style: CommonStyles.black12()),
                          Text(
                            "Order ID  : 0000010${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![index].id!}",
                            style: CommonStyles.black12(),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "₹ " +
                        orderHistoryAPIProvider.orderHistoryResponse!
                            .orderHistory![index].tripDetails!.total!,
                    style: CommonStyles.black12(),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          child: Container(
                              child: ListView.builder(
                                  itemCount: list.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (con, ind) {
                                    return ind != 0
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Row(children: [
                                                  Column(
                                                    children: List.generate(
                                                      2,
                                                      (ii) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 9,
                                                                  right: 10,
                                                                  top: 5,
                                                                  bottom: 5),
                                                          child: Container(
                                                            height: 3,
                                                            width: 2,
                                                            color: Colors.grey,
                                                          )),
                                                    ),
                                                  ),
                                                ]),
                                                Row(children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: list[ind].color,
                                                    size: 20,
                                                  ),
                                                  Utils.getSizedBox(width: 10),
                                                  Flexible(
                                                    child: Text(
                                                        list[ind].address,
                                                        maxLines: 3,
                                                        style: CommonStyles
                                                            .red9()),
                                                  )
                                                ]),
                                              ])
                                        : Row(children: [
                                            Icon(
                                              Icons.location_on,
                                              color: list[ind].color,
                                              size: 20,
                                            ),
                                            Utils.getSizedBox(width: 10),
                                            Flexible(
                                              child: Text(list[ind].address,
                                                  maxLines: 3,
                                                  style: CommonStyles.green9()),
                                            )
                                          ]);
                                  })),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          if (orderHistoryAPIProvider.orderHistoryResponse!
                                  .orderHistory![index].orderStatus ==
                              "2")
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 50,
                              child: Image.asset("assets/images/cancel.png"),
                            ),
                          /*  CachedNetworkImage(
                              imageUrl:
                                  "${orderHistoryAPIProvider.orderHistoryResponse!.vehicleBaseurl}${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![index].driverDetails!.profileImage}"),
                       */
                        ],
                      )),
                ],
              ),
              Utils.getSizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (orderHistoryAPIProvider.orderHistoryResponse!
                              .orderHistory![index].orderStatus !=
                          "1" &&
                      orderHistoryAPIProvider.orderHistoryResponse!
                              .orderHistory![index].orderStatus !=
                          "2" &&
                      orderHistoryAPIProvider.orderHistoryResponse!
                              .orderHistory![index].orderStatus !=
                          "3")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Trip OTP : ",
                          style: CommonStyles.black12(),
                        ),
                        Utils.getSizedBox(width: 5),
                        Text(
                            orderHistoryAPIProvider.orderHistoryResponse!
                                .orderHistory![index].customerOtp!,
                            style: CommonStyles.black13thin()),
                      ],
                    ),
                  if (orderHistoryAPIProvider.orderHistoryResponse!
                          .orderHistory![index].orderStatus !=
                      "2")
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            builder: (context) {
                              return ShowDetailedTransaction(index: index);
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 2, // Space between underline and text
                        ),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.blue,
                          width: 1.0, // Underline thickness
                        ))),
                        child: Text(
                          "View Details",
                          style: CommonStyles.blue12(),
                        ),
                      ),
                    )
                ],
              ),
              Utils.getSizedBox(height: 10),
              Visibility(
                  visible: orderHistoryAPIProvider.orderHistoryResponse!
                          .orderHistory![index].orderStatus! ==
                      "1",
                  child: const LinearProgressIndicator()),
              Utils.getSizedBox(height: 10),
              if (orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].orderStatus !=
                  "2")
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Status : ",
                          style: CommonStyles.black1154(),
                        ),
                        Utils.getSizedBox(width: 5),
                        getIconAccordingToStatus(orderHistoryAPIProvider
                            .orderHistoryResponse!
                            .orderHistory![index]
                            .orderStatus!),
                        Utils.getSizedBox(width: 5),
                        Text(
                            orderHistoryAPIProvider.orderHistoryResponse!
                                .orderHistory![index].orderLabel!,
                            style: CommonStyles.black10thin()),
                        Utils.getSizedBox(width: 5),
                      ],
                    ),

                    // Text(
                    //   "₹ " +
                    //       orderHistoryAPIProvider
                    //           .orderHistoryResponse!
                    //           .orderHistory![index]
                    //           .tripDetails!
                    //           .payedAmt!,
                    //   style: CommonStyles.black12(),
                    // )
                  ],
                ),
              Visibility(
                visible: orderHistoryAPIProvider.orderHistoryResponse!
                            .orderHistory![index].orderLabel! ==
                        "5" ||
                    orderHistoryAPIProvider.orderHistoryResponse!
                            .orderHistory![index].orderLabel! ==
                        "7",
                child: Column(
                  children: [
                    Row(
                      children: [
                        orderHistoryAPIProvider.orderHistoryResponse!
                                    .orderHistory![index].orderLabel ==
                                "5"
                            ? Text(
                                "Loading time : ",
                                style: CommonStyles.black11(),
                              )
                            : orderHistoryAPIProvider.orderHistoryResponse!
                                        .orderHistory![index].orderLabel ==
                                    "7"
                                ? Text(
                                    "Unloading time : ",
                                    style: CommonStyles.black11(),
                                  )
                                : const SizedBox(),
                        Utils.getSizedBox(width: 10),
                        Text(
                          displayTime,
                          style: CommonStyles.black11(),
                        ),
                      ],
                    ),
                    Utils.getSizedBox(height: 5),
                    getWidgetStatus(orderHistoryAPIProvider
                        .orderHistoryResponse!
                        .orderHistory![index]
                        .orderStatus!),
                  ],
                ),
              ),
              Visibility(
                  visible: orderHistoryAPIProvider.orderHistoryResponse!
                          .orderHistory![index].orderStatus! ==
                      "1",
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 40,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight:
                                                      Radius.circular(8))),
                                          builder: (context) {
                                            return cancelAlertDialog(index);
                                          });
                                    },
                                    child: GlassContainer(
                                      height: 40,
                                      opacity: 0.5,
                                      width: 300,
                                      blur: 4,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Cancel My Booking",
                                              style: CommonStyles.red12(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),

        // InkWell(
        //   onTap: () {
        //     Navigator.pushNamed(context, 'OrderDetiles');
        //   },
        //   child: const ListTile(
        //     title: Text(
        //       ' Yesterday,09:01pm',
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w600),
        //     ),
        //     subtitle: Text(
        //       ' Booked',
        //       style: TextStyle(
        //           color: Color.fromARGB(255, 88, 26, 22),
        //           fontSize: 15,
        //           fontWeight: FontWeight.w800),
        //     ),
        //     trailing: Text(
        //       '₹150.00',
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w800),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget getIconAccordingToStatus(status) {
    switch (status) {
      case "1":
        return const Icon(
          Icons.timelapse,
          color: Colors.blue,
          size: 18,
        );
      case "2":
        return const Icon(
          Icons.cancel_presentation_outlined,
          color: Colors.red,
          size: 18,
        );
      case "3":
        return const Icon(
          Icons.done_all_sharp,
          color: Colors.green,
          size: 18,
        );
      case "4":
        return const Icon(
          Icons.delivery_dining_rounded,
          color: Colors.yellow,
          size: 18,
        );
    }
    return const Icon(
      Icons.keyboard_capslock_outlined,
      color: Colors.green,
      size: 18,
    );
  }

  Widget getWidgetStatus(status) {
    switch (status) {
      case "1":
        return const Padding(
          padding: EdgeInsets.only(top: 4, left: 4),
          child: LinearProgressIndicator(
            backgroundColor: Colors.orange,
            color: Colors.white54,
            minHeight: 10,
            // value: linearProgressValue,
          ),
        );

      // const Icon(
      //   Icons.timelapse,
      //   color: Colors.blue,
      //   size: 18,
      // );
      // case "2":
      //   return const Icon(
      //     Icons.cancel_presentation_outlined,
      //     color: Colors.red,
      //     size: 18,
      //   );
      // case "3":
      //   return const Icon(
      //     Icons.done_all_sharp,
      //     color: Colors.green,
      //     size: 18,
      //   );
      // case "4":
      //   return const Icon(
      //     Icons.delivery_dining_rounded,
      //     color: Colors.yellow,
      //     size: 18,
      //   );
    }
    return const SizedBox();
  }

  cancelAlertDialog(int index) {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.black54,
                  )),
            ],
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.black54),
                Utils.getSizedBox(width: 10),
                Text(
                  "Are you sure you want to cancel the Booking?",
                  // style: CommonStyles.black14(),
                ),
              ],
            ),
          ),
          Utils.getSizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TextButton(
                  //     child: Text("No".toUpperCase(),
                  //         style: CommonStyles.green15()),
                  //     style: ButtonStyle(
                  //         padding: MaterialStateProperty.all<EdgeInsets>(
                  //             const EdgeInsets.all(8)),
                  //         foregroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.red),
                  //         shape: MaterialStateProperty.all<
                  //                 RoundedRectangleBorder>(
                  //             RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(18.0),
                  //                 side: const BorderSide(color: Colors.red)))),
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //     }),
                  ElevatedButton(
                      child: Text("No".toUpperCase(),
                          style: CommonStyles.whiteText15BoldW500()),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: Colors.white54)))),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      }),
                  ElevatedButton(
                      child: Text("Yes".toUpperCase(),
                          style: CommonStyles.whiteText15BoldW500()),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: Colors.white54)))),
                      onPressed: () async {
                        showLoading(context);
                        final result = await apiServices.cancelOrder(
                            orderId: orderHistoryAPIProvider
                                .orderHistoryResponse!.orderHistory![index].id!,
                            reasonID: "2",
                            reasonText: "");
                        if (result!.status == "1") {
                          Fluttertoast.showToast(msg: "Order Cancelled");
                          await orderHistoryAPIProvider.getOrders();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else {
                          Fluttertoast.showToast(msg: "Order Not Cancelled");
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      })
                ]),
          )
        ],
      ),
    );
  }
}

// class CustomTimerPainter extends CustomPainter {
//   CustomTimerPainter({
//     required this.animation,
//     required this.backgroundColor,
//     required this.color,
//   }) : super(repaint: animation);

//   final Animation<double> animation;
//   final Color backgroundColor, color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = backgroundColor
//       ..strokeWidth = 10.0
//       ..strokeCap = StrokeCap.butt
//       ..style = PaintingStyle.stroke;

//     canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
//     paint.color = color;
//     double progress = (1.0 - animation.value) * 2 * math.pi;
//     canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
//   }

//   @override
//   bool shouldRepaint(CustomTimerPainter old) {
//     return animation.value != old.animation.value ||
//         color != old.color ||
//         backgroundColor != old.backgroundColor;
//   }
// }

class ShowDetailedTransaction extends StatefulWidget {
  const ShowDetailedTransaction({Key? key, required this.index})
      : super(key: key);
  final int index;
  @override
  State<ShowDetailedTransaction> createState() =>
      _ShowDetailedTransactionState();
}

class _ShowDetailedTransactionState extends State<ShowDetailedTransaction> {
  @override
  void initState() {
    // if (mounted) {
    //   Timer.periodic(const Duration(seconds: 3), (timer) {
    //     context.read<OrderHistoryAPIProvider>().getOrders();
    //   });
    // }
    if (context.read<CouponAPIProvider>().couponModel == null) {
      context.read<CouponAPIProvider>().getCouponList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);
    final couponAPI = Provider.of<CouponAPIProvider>(context);

    if (orderHistoryAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (orderHistoryAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(orderHistoryAPIProvider.errorMessage),
      );
    } else if (orderHistoryAPIProvider.orderHistoryResponse == null ||
        orderHistoryAPIProvider.orderHistoryResponse!.status! == "0") {
      return Utils.showErrorMessage(
          orderHistoryAPIProvider.orderHistoryResponse!.message!);
    }
    List<Model> list = [];

    list.add(Model(
        orderHistoryAPIProvider.orderHistoryResponse!
            .orderHistory![widget.index].tripDetails!.fromAddress!,
        Colors.green));
    list.add(Model(
        orderHistoryAPIProvider.orderHistoryResponse!
            .orderHistory![widget.index].tripDetails!.toAddress!,
        Colors.red));
    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      "Trip Details",
                      style: CommonStyles.black15(),
                    ),
                  ],
                ),
                Text(
                  "Order ID  : 0000010${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].id!}",
                  style: CommonStyles.black12(),
                )
              ],
            ),
          ),
          orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].orderStatus ==
                  "1"
              ? Center(
                  child: SizedBox(
                      height: 200,
                      width: deviceWidth(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoadingRotating.square(
                            borderSize: 10,
                          ),
                          Utils.getSizedBox(height: 40),
                          Text(
                            'Waiting for Driver Response',
                            style: CommonStyles.black1254thin(),
                          )
                        ],
                      )))
              : orderHistoryAPIProvider.orderHistoryResponse!
                          .orderHistory![widget.index].orderStatus ==
                      "2"
                  ? Center(
                      child: SizedBox(
                          height: 200,
                          width: deviceWidth(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cancel_presentation,
                                size: 50,
                              ),
                              Utils.getSizedBox(height: 10),
                              Text(
                                'Cancelled Order',
                                style: CommonStyles.black1254thin(),
                              )
                            ],
                          )))
                  : SizedBox(
                      height: 250,
                      width: deviceWidth(context),
                      child: MapPage(orderId: widget.index
                          // sourceLocation: LatLng(
                          //     double.parse(orderHistoryAPIProvider
                          //         .orderHistoryResponse!
                          //         .orderHistory![widget.index]
                          //         .tripDetails!
                          //         .toLat!),
                          //     double.parse(orderHistoryAPIProvider
                          //         .orderHistoryResponse!
                          //         .orderHistory![widget.index]
                          //         .tripDetails!
                          //         .toLong!)),
                          // destinationLocation: LatLng(
                          //     double.parse(orderHistoryAPIProvider
                          //         .orderHistoryResponse!
                          //         .orderHistory![widget.index]
                          //         .tripDetails!
                          //         .fromLat!),
                          //     double.parse(orderHistoryAPIProvider
                          //         .orderHistoryResponse!
                          //         .orderHistory![widget.index]
                          //         .tripDetails!
                          //         .fromLong!)),
                          ),
                    ),

          // Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: 30,
                            height: 30,
                            imageUrl: orderHistoryAPIProvider
                                    .orderHistoryResponse!.vehicleBaseurl! +
                                orderHistoryAPIProvider
                                    .orderHistoryResponse!
                                    .orderHistory![widget.index]
                                    .vechileDetails!
                                    .image!,
                          ),
                        ),
                        Utils.getSizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                orderHistoryAPIProvider.orderHistoryResponse!
                                    .orderHistory![widget.index].bookedDate!,
                                style: CommonStyles.black12()),
                            /* Text(
                              orderHistoryAPIProvider
                                  .orderHistoryResponse!
                                  .orderHistory![widget.index]
                                  .vechileDetails!
                                  .wheeler!,
                              style: CommonStyles.black1254W700(),
                            )*/
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "₹ ${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.total!}",
                      style: CommonStyles.black15(),
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.speed_sharp,
                      color: Colors.black54,
                      size: 40,
                    ),
                    Text(
                      "₹  " +
                          orderHistoryAPIProvider
                              .orderHistoryResponse!
                              .orderHistory![widget.index]
                              .tripDetails!
                              .vehicleCharge!,
                      style: CommonStyles.black15(),
                    ),
                    Text(
                      "${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.totalDistance!}",
                      style: CommonStyles.black15(),
                    ),
                    Text(
                      "${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.totalDuration}",
                      style: CommonStyles.black15(),
                    )
                  ],
                ),
                Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (con, ind) {
                                return ind != 0
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Row(children: [
                                              Column(
                                                children: List.generate(
                                                  2,
                                                  (ii) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 9,
                                                              right: 10,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Container(
                                                        height: 3,
                                                        width: 2,
                                                        color: Colors.grey,
                                                      )),
                                                ),
                                              ),
                                              // Expanded(
                                              //     child: Container(
                                              //   color: Colors.grey.withAlpha(60),
                                              //   height: 0.5,
                                              //   padding: EdgeInsets.only(
                                              //     left: 10,
                                              //     right: 20,
                                              //   ),
                                              // ))
                                            ]),
                                            Row(children: [
                                              Icon(
                                                Icons.location_on,
                                                color: list[ind].color,
                                                size: 20,
                                              ),
                                              Utils.getSizedBox(width: 10),
                                              Flexible(
                                                child: Text(list[ind].address,
                                                    maxLines: 3,
                                                    style: CommonStyles
                                                        .black13thinW54()),
                                              )
                                            ]),
                                          ])
                                    : Row(children: [
                                        Icon(
                                          Icons.location_on,
                                          color: list[ind].color,
                                          size: 20,
                                        ),
                                        Utils.getSizedBox(width: 10),
                                        Flexible(
                                          child: Text(list[ind].address,
                                              maxLines: 3,
                                              style: CommonStyles
                                                  .black13thinW54()),
                                        )
                                      ]);
                              })),
                    ),
                  ],
                ),

                /*    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                            orderHistoryAPIProvider
                                .orderHistoryResponse!
                                .orderHistory![widget.index]
                                .tripDetails!
                                .transactionId!,
                            textAlign: TextAlign.start,
                            style: CommonStyles.black10thin()),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.map, size: 18, color: Colors.brown),
                        TextButton(
                            onPressed: () async {
                              launchMapsUrl(
                                  orderHistoryAPIProvider
                                      .orderHistoryResponse!
                                      .orderHistory![widget.index]
                                      .tripDetails!
                                      .fromLat,
                                  orderHistoryAPIProvider
                                      .orderHistoryResponse!
                                      .orderHistory![widget.index]
                                      .tripDetails!
                                      .fromLong!,
                                  orderHistoryAPIProvider
                                      .orderHistoryResponse!
                                      .orderHistory![widget.index]
                                      .tripDetails!
                                      .toLat,
                                  orderHistoryAPIProvider
                                      .orderHistoryResponse!
                                      .orderHistory![widget.index]
                                      .tripDetails!
                                      .toLong);
                            },
                            child: Text(
                              'Show In Map',
                              style: CommonStyles.blue12(),
                            )),
                      ],
                    )
                  ],
                ),*/
                Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Status : ",
                            style: CommonStyles.green12(),
                          ),
                          Utils.getSizedBox(width: 5),
                          getIconAccordingToStatus(orderHistoryAPIProvider
                              .orderHistoryResponse!
                              .orderHistory![widget.index]
                              .orderStatus),
                          Utils.getSizedBox(width: 5),
                          Text(
                              orderHistoryAPIProvider.orderHistoryResponse!
                                  .orderHistory![widget.index].orderLabel!,
                              style: CommonStyles.black11()),
                          /* Text(
                            "₹ " +
                                orderHistoryAPIProvider
                                    .orderHistoryResponse!
                                    .orderHistory![widget.index]
                                    .tripDetails!
                                    .tripOtp!,
                            style: CommonStyles.black12(),
                          )*/
                        ],
                      ),
                    ]),
                Utils.getSizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bill Details",
                    style: CommonStyles.black15(),
                  ),
                ),
                showBillScreen(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (discount == "0") {
                                buildShowModalBottomSheet(context, couponAPI,
                                    orderHistoryAPIProvider);
                              } else {
                                null;
                              }
                            },
                            icon: Icon(
                              Icons.local_offer_outlined,
                              color: orderHistoryAPIProvider
                                          .orderHistoryResponse!
                                          .orderHistory![widget.index]
                                          .tripDetails!
                                          .status !=
                                      "3"
                                  ? Colors.black
                                  : Colors.grey,
                            )),
                        Text(
                          "Use Coupon".toUpperCase(),
                          style: CommonStyles.black12reg(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                assignEmail();
                                showAlertDialog(context);
                              });
                            },
                            icon: Icon(Icons.mail_outline)),
                        Text(
                          "Mail Invoice".toUpperCase(),
                          style: CommonStyles.black12reg(),
                        )
                      ],
                    ),
                  ],
                )

                /* Utils.getSizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: okButton(),
                )*/
              ],
            ),
          )
        ],
      ),
    );
    // });
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context,
      CouponAPIProvider couponAPI,
      OrderHistoryAPIProvider orderHistoryAPIProvider) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: 600.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Promos".toUpperCase(),
                    style: CommonStyles.blue18900(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                        ),
                      ),
                      Expanded(
                          child: TextButton(
                        onPressed: () {},
                        child: Text("Apply", style: CommonStyles.black14()),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  couponAPI.ifLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 0.5,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            primary: true,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                couponAPI.couponModel!.couponList!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            couponAPI.couponModel!
                                                .couponList![index].couponName!,
                                            style: CommonStyles
                                                .whiteText16BoldW500(),
                                          ),
                                          Text(
                                            "${couponAPI.couponModel!.couponList![index].offer} %  OFF",
                                            style: CommonStyles
                                                .whiteText18BoldW500(),
                                          ),
                                          Text(
                                            "UPTO  ₹ ${couponAPI.couponModel!.couponList![index].upto} ",
                                            style: CommonStyles
                                                .whiteText20BoldW500(),
                                          ),
                                          Text(
                                            "${couponAPI.couponModel!.couponList![index].description}  ",
                                            style: CommonStyles
                                                .whiteText16BoldW500(),
                                          ),
                                          Text(
                                            "Valid Till ${couponAPI.couponModel!.couponList![index].validDate} ",
                                            style: CommonStyles
                                                .whiteText16BoldW500(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Coupon ${couponAPI.couponModel!.couponList![index].couponName}  ${couponAPI.couponModel!.couponList![index].upto}",
                                              style: CommonStyles.black13(),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Coupon ${couponAPI.couponModel!.couponList![index].offer} % Off  Upto ₹ ${couponAPI.couponModel!.couponList![index].upto}",
                                              style: CommonStyles.black13(),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              discount =
                                                  "${((double.parse(orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.total!) - double.parse(couponAPI.couponModel!.couponList![index].upto!)))}";

                                              print("discont -----" +
                                                  discount.toString());

                                              if (discount != "0") {
                                                saveMoney = couponAPI
                                                    .couponModel!
                                                    .couponList![index]
                                                    .upto;

                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Promo Code Applied Successfully  !!");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Promo Code is not Valid!!");
                                              }
                                            },
                                            child: Text(
                                              "APPLY",
                                              style: CommonStyles.black13(),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                ],
              ));
        });
  }

  String discount = "0";
  String? saveMoney;

  final emailController = TextEditingController();

  assignEmail() {
    emailController.text = context
        .read<ProfileViewAPIProvider>()
        .profileViewResponse!
        .userDetails!
        .email
        .toString();
    print("email Controller ---------" + emailController.text);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          "Cancel".toUpperCase(),
          style: CommonStyles.whiteText15BoldW500(),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          "Send".toUpperCase(),
          style: CommonStyles.whiteText15BoldW500(),
        ),
      ),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Enter Mail Address ",
        style: CommonStyles.black12reg(),
      ),
      content: TextFormField(
        style: CommonStyles.black14(),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value!)) {
            return "Enter Valid email";
          }
          return null;
        },
        decoration: InputDecoration(
            //   errorText: "Enter E-Mail ID",
            /*hintText: context
              .read<ProfileViewAPIProvider>()
              .profileViewResponse!
              .userDetails!
              .email!,*/
            ),
      ),
      actions: [
        cancelButton,
        SizedBox(
          width: 0,
        ),
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 0), child: alert);
      },
    );
  }

  Widget getIconAccordingToStatus(status) {
    switch (status) {
      case "1":
        return const Icon(
          Icons.timelapse,
          color: Colors.blue,
          size: 18,
        );
      case "2":
        return const Icon(
          Icons.cancel_presentation_outlined,
          color: Colors.red,
          size: 18,
        );
      case "3":
        return const Icon(
          Icons.done_all_sharp,
          color: Colors.green,
          size: 18,
        );
      case "4":
        return const Icon(
          Icons.delivery_dining_rounded,
          color: Colors.yellow,
          size: 18,
        );
    }
    return const Icon(
      Icons.keyboard_capslock_outlined,
      color: Colors.green,
      size: 18,
    );
  }

  Widget okButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        "Ok!",
        style: CommonStyles.white12(),
      )),
    );
  }

  static void launchMapsUrl(sourceLatitude, sourceLongitude,
      destinationLatitude, destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'travelmode=driving',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showBillScreen() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Vehicle Charges",
              style: CommonStyles.black12reg(),
            ),
            Text(
              "₹ " +
                  orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].tripDetails!.vehicleCharge!,
              style: CommonStyles.black14thinW54(),
            ),
          ],
        ),
        Utils.getSizedBox(height: 10),
        Visibility(
          visible: orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.index].tripDetails!.labourPrice !=
              "0",
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Helper Charges (${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.labourQty} Helpers)",
                    style: CommonStyles.black12reg(),
                  ),
                  Text(
                    "₹ " +
                        orderHistoryAPIProvider
                            .orderHistoryResponse!
                            .orderHistory![widget.index]
                            .tripDetails!
                            .labourPrice!,
                    style: CommonStyles.black14thinW54(),
                  ),
                ],
              ),
              Utils.getSizedBox(height: 10),
            ],
          ),
        ),
        Visibility(
          visible: orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.index].tripDetails!.stateStatus !=
              "0",
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Outstation Charges",
                    style: CommonStyles.black12reg(),
                  ),
                  Text(
                    "₹ " +
                        orderHistoryAPIProvider
                            .orderHistoryResponse!
                            .orderHistory![widget.index]
                            .tripDetails!
                            .statePrice!,
                    style: CommonStyles.black14thinW54(),
                  ),
                ],
              ),
              Utils.getSizedBox(height: 10),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GST Amount ",
              style: CommonStyles.black12reg(),
            ),
            Text(
              "₹ " +
                  getGstPercerntage(
                      double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                          .orderHistory![widget.index].tripDetails!.gst!),
                      (double.parse(orderHistoryAPIProvider
                                  .orderHistoryResponse!
                                  .orderHistory![widget.index]
                                  .tripDetails!
                                  .vehicleCharge!) +
                              double.parse(orderHistoryAPIProvider
                                  .orderHistoryResponse!
                                  .orderHistory![widget.index]
                                  .tripDetails!
                                  .statePrice!) +
                              double.parse(orderHistoryAPIProvider
                                  .orderHistoryResponse!
                                  .orderHistory![widget.index]
                                  .tripDetails!
                                  .labourPrice!))
                          .toString()),
              style: CommonStyles.black14thinW54(),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Gst Tax (${ orderHistoryAPIProvider.orderHistoryResponse!
        //               .orderHistory![widget.index].tripDetails!.gst!} %)",
        //       style: CommonStyles.blue12thin(),
        //     ),
        //     Text(
        //       "₹ " +
        //           (double.parse( orderHistoryAPIProvider.orderHistoryResponse!
        //               .orderHistory![widget.index].tripDetails!.) -
        //                   double.parse(vehicleCategoriesAPIProvider
        //                       .vehicleCategoriesResponseModel!
        //                       .vehicleList![widget.index]
        //                       .withoutGst!))
        //               .toStringAsFixed(2),
        //       style: CommonStyles.blue12thin(),
        //     ),
        //   ],
        // ),
        // Utils.getSizedBox(height: 10),
        // buildDivider(),
        /*Utils.getSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Paid Amount", style: CommonStyles.black12()),
            Text(
                "₹ "
                "${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.paidAmt!}",
                style: CommonStyles.blue12())
          ],
        ),
        Utils.getSizedBox(height: 10),

        buildDivider(),*/
        Utils.getSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Total Amount", style: CommonStyles.black12reg()),
            discount == "0"
                ? Text(
                    "₹ "
                    "${orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.total!}",
                    style: CommonStyles.black14thinW54())
                : Text("₹ ${discount}", style: CommonStyles.black14thinW54())
          ],
        ),

        if (discount != "0")
          Column(
            children: [
              Utils.getSizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Saved Money", style: CommonStyles.black12reg()),
                  Text("₹ ${saveMoney}", style: CommonStyles.black14thinW54())
                ],
              ),
            ],
          ),

        Utils.getSizedBox(height: 10),

        buildDivider(),
        Utils.getSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Amount To Pay", style: CommonStyles.black12reg()),
            discount == "0"
                ? Text(
                    "₹ "
                    "${((double.parse(orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.total!) - double.parse(orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.paidAmt!)).toStringAsFixed(2))}",
                    style: CommonStyles.black14())
                : Text(
                    "₹ "
                    "${((double.parse(orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.total!) - double.parse(orderHistoryAPIProvider.orderHistoryResponse!.orderHistory![widget.index].tripDetails!.paidAmt!) - double.parse(saveMoney!)).toStringAsFixed(2))}",
                    style: CommonStyles.black14())
          ],
        ),
        Utils.getSizedBox(height: 10),
        Visibility(
          visible: orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].orderStatus !=
                  "1" &&
              orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].orderStatus !=
                  "2" &&
              orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].orderStatus !=
                  "3" &&
              orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].tripDetails!.total !=
                  orderHistoryAPIProvider.orderHistoryResponse!
                      .orderHistory![widget.index].tripDetails!.paidAmt!,
          child: RemainingPaymentAmount(
            toPayAmount: (double.parse(orderHistoryAPIProvider
                        .orderHistoryResponse!
                        .orderHistory![widget.index]
                        .tripDetails!
                        .total!) -
                    double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                        .orderHistory![widget.index].tripDetails!.paidAmt!))
                .toStringAsFixed(2),
          ),
        ),

        Utils.getSizedBox(height: 10),
        /*  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                  "*Waiting Charges (Only applicable when loading and unloading time exceeds 2 hrs) ",
                  // "₹ ${ orderHistoryAPIProvider
                  //           .orderHistoryResponse!
                  //           .orderHistory![widget.index]
                  //           .!}.",
                  maxLines: 3,
                  style: CommonStyles.blackw54s9Thin()),
            ),
          ],
        ),*/
      ]),
    );
  }

  String getGstPercerntage(double percentage, String amount) {
    return ((double.parse(amount) * percentage) / 100).toString();
  }
}

class RemainingPaymentAmount extends StatefulWidget {
  const RemainingPaymentAmount({Key? key, required this.toPayAmount})
      : super(key: key);
  final String toPayAmount;
  @override
  State<RemainingPaymentAmount> createState() => _RemainingPaymentAmountState();
}

class _RemainingPaymentAmountState extends State<RemainingPaymentAmount> {
  late Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();

    // list.add(Model("Vijayawada", Colors.blue));
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      color: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        "Payment of the Ride ₹ ${widget.toPayAmount} ",
        style: CommonStyles.white12(),
      )),
    );
  }

  Future openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': widget.toPayAmount,
      'name': 'ANK Speed',
      'description': 'Vehicle Boking',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.of(context).pop("success");
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.of(context).pop("failed");

    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  bool _paymentCompleted = false;

  buildPaymentFuture() async {
    // _animationController.reset();
    // await Future.delayed(const Duration(seconds: 2)).then((value) {
    //   setState(() {
    //     _paymentCompleted = true;
    //   });
    // });

    // print("=----" + categoryId);
    // print("=====" + categoryQuantity);

    openCheckout().whenComplete(() async {
      //Show Successful payed ramainging amount

      // final bookVehicleRequestModel = BookVehicleRequestModel(
      //     customerName: widget.pickupContactName,
      //     distance: widget.vehicleList.totalKm!,
      //     duration: widget.vehicleList.time!,
      //     fromAddress: SharedPreference.address!,
      //     vehicleCharge: widget.vehicleList.vehiclePrice!,
      //     fromLat: SharedPreference.latitude!.toString(),
      //     fromLong: SharedPreference.longitude!.toString(),
      //     labourQuantity: widget.vehicleList.labourQty!,
      //     labourPrice: widget.vehicleList.labourTotal!,
      //     categoryId: categoryId,
      //     categoryQuantity: categoryQuantity,
      //     gst: widget.vehicleList.gst!,
      //     statePrice: widget.vehicleList.outerCharge!,
      //     stateStatus: widget.vehicleList.outerState!,
      //     customerMobile: widget.pickupContactPhone,
      //     paidAmount: getPriceFromPercentage(
      //             vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
      //                 .vehicleList![widget.vehicleSelectedIndex].totalPrice!,
      //             30)
      //         .toStringAsFixed(2),
      //     toAddress: widget.toAddress,
      //     toLat: widget.toLatitude.toString(),
      //     toLong: widget.toLongitude.toString(),
      //     total: widget.vehicleList.totalPrice!,
      //     transactionId: "GYA000" + rand.nextInt(2000).toString(),
      //     userId: ApiServices.userId!,
      //     vehicleTypeId: widget.vehicleList.id!);
      // await context
      //     .read<BookVehicleAPIProvider>()
      //     .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
      //     .then((value) {
      //   // showAboutDialog(context: context)
      //   Utils.bookingSuccess(context);
      //   context.read<OrderHistoryAPIProvider>().getOrders();
      //   // Navigator.of(context).push(MaterialPageRoute(
      //   //     builder: (context) => SuccessfulBookingScreen(
      //   //           driverLatitude: double.parse(context
      //   //               .read<BookVehicleAPIProvider>()
      //   //               .vehicleCategoriesResponseModel!
      //   //               .tripDetails!
      //   //               .toLat!),
      //   //           driverLongitude: double.parse(context
      //   //               .read<BookVehicleAPIProvider>()
      //   //               .vehicleCategoriesResponseModel!
      //   //               .tripDetails!
      //   //               .toLong!),
      //   //         )));
      // });
    });
  }
}
