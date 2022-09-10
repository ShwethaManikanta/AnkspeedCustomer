import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Services/apiProvider/order_history_api_provider.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/orderPage/order_page_list_view.dart';
import 'package:provider/provider.dart';
import '../../common/utils.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Timer? timer;

  @override
  void initState() {
    if (context.read<OrderHistoryAPIProvider>().orderHistoryResponse == null) {
      context.read<OrderHistoryAPIProvider>().getOrders().whenComplete(() {});
    }
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (mounted) {
          context.read<OrderHistoryAPIProvider>().getOrders();
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    // waitingTime?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 88, 26, 22),
      title: Text(
        'Order History',
        style: CommonStyles.whiteText16BoldW500(),
      ),
      centerTitle: true,
      leading: const SizedBox(),
    );
  }

  buildBody() {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(
              0,
              0.5,
            ),
            end: Alignment(
              0.9999999999999999,
              0.4999999910767653,
            ),
            colors: [
              ColorConstant.whiteA700,
              ColorConstant.whiteA700,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Text(
                'Your Rides',
                style: CommonStyles.blackS18(),
              ),
            ),

            // buildOrderHistory(),
            buildOrderlist(),
          ],
        ),
      ),
    );
  }

  buildOrderlist() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);

    if (orderHistoryAPIProvider.ifLoading) {
      print("Loading -----------  = = = == = = == = = = ");
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (orderHistoryAPIProvider.error) {
      print("error -----------  = = = == = = == = = = ");

      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(
            orderHistoryAPIProvider.errorMessage.toUpperCase()),
      );
    } else if (orderHistoryAPIProvider.orderHistoryResponse == null ||
        orderHistoryAPIProvider.orderHistoryResponse!.status! == "0") {
      print("Order History Status -----------  = = = == = = == = = =  0");

      return Expanded(
        child: Utils.showErrorMessage(orderHistoryAPIProvider
            .orderHistoryResponse!.message!
            .toUpperCase()),
      );
    }

    return Expanded(
      child: SizedBox(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<OrderHistoryAPIProvider>().getOrders();
          },
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: false,
              itemCount: orderHistoryAPIProvider
                  .orderHistoryResponse!.orderHistory!.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return OrderPageListView(index: index);
              }),
        ),
      ),
    );
  }
}
