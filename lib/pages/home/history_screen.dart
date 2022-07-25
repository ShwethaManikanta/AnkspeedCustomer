import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/color_const.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
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
              ColorConstant.blue800Cc,
              ColorConstant.purple800Cc,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "History",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: 27,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              //mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  height: MediaQuery.of(context).size.height * 0.8676,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      primary: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.indigoA700,
                                      borderRadius: BorderRadius.circular(
                                        10.00,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstant.black900,
                                          spreadRadius: 2.00,
                                          blurRadius: 2.00,
                                          offset: Offset(
                                            0,
                                            4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.arrow_forward)),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Paid to",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Elango Raja",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "₹ 1000",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorConstant.blue800Cc,
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Credited to  ",
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ColorConstant.black900,
                                                fontSize: 12,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Icon(Icons.food_bank_outlined)
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
