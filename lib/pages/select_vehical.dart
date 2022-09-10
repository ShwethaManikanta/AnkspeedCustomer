import 'package:flutter/material.dart';
// import 'package:loadrunnr/colors.dart';
// import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';

class SelectVehical extends StatefulWidget {
  const SelectVehical({Key? key}) : super(key: key);

  @override
  _SelectVehicalState createState() => _SelectVehicalState();
}

class _SelectVehicalState extends State<SelectVehical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildBNB(),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height - 250),
            child: buildvehicalType(),
          ),
        )
      ],
    );
  }
  // buildBody() {
  //   return ExpandableBottomSheet(
  //       // animationCurveContract: Curves.easeInBack,
  //       // animationCurveExpand: Curves.bounceOut,
  //       // animationDurationExtend: Duration(milliseconds: 500),
  //       background: buildMap(),
  //       persistentHeader: buildvehicalType(),
  //       expandableContent: Container(
  //           // height: 500,
  //           // color: Colors.black,
  //           ));
  // }

  buildMap() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 1,
      width: double.infinity,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(
                    'https://static2.tripoto.com/media/filter/tst/img/466718/TripDocument/1514641199_2017_12_30_13_06_37_photos.png'),
                fit: BoxFit.cover)),
      ),
    );
  }

  buildvehicalType() {
    return SingleChildScrollView(
      child: Container(
        // height: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey[200],
                  ),
                  height: 5,
                  width: 50,
                ),
              ),
              Text(
                'Choose Your Vehicel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Open',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: Colors.green.shade800,
                    ),
                  ),
                  Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    'Any',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                color: Colors.white,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            // color: Colors.blueGrey[100],
                            child: Column(
                              children: [
                                Text(
                                  'Tata Ace',
                                  style: TextStyle(
                                      color: Colors.blueGrey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/veh1.png'))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('7 Mins',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3)),
                                Text('₹ 300',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey[200],
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Save 18% on this trip',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                      Row(
                        children: [
                          Icon(Icons.redeem, color: Colors.green.shade800),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'CouponPage');
                            },
                            child: Text(' Apply Coupon',
                                style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey[200],
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Pickup Contact',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0)),
                      Text('7848026262 Arun G',
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBNB() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.4),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(
              5.0,
              5.0,
            ),
          )
        ],
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.money_rounded,
                      color: Colors.green.shade800,
                    ),
                    InkWell(
                      onTap: () {
                        buildPay();
                      },
                      child: Text('Cash',
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Text(' Online Payment Applied',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0))
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Book Tata Ace',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildPay() {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Dialog(
                insetPadding: EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  // height: 320,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select Payment',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: Colors.green.shade800,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(' Online Payment',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0)),
                                ],
                              ),
                              Radio(
                                value: 0,
                                groupValue: 1,
                                onChanged: null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.green.shade800,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Cash',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0)),
                                ],
                              ),
                              Radio(
                                value: 0,
                                groupValue: 1,
                                onChanged: null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 380,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}



































































































































































































































//   buildSelectVehical() {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//           color: Colors.white,
//         ),
//         child: Expanded(
//           child: Column(
//             children: [
//               buildVehicelType(),
//               buildScrollVehical(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   buildVehicelType() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Text(
//             'Choose Your Vehicel',
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.3,
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Open',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.3,
//                   color: Colors.green.shade800,
//                 ),
//               ),
//               Text(
//                 'Close',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//               Text(
//                 'Any',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   buildScrollVehical() {
//     return ListView.builder(
//         itemCount: 3,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 250,
//             width: 200,
//             color: Colors.black12,
//           );
//         });
//   }

//   buildBody() {
//     return Stack(
//       children: [buildMap(), buildIcone(), buildScrollBSheet()],
//     );
//   }

//   buildIcone() {
//     return Positioned(
//         left: 15,
//         top: 50,
//         child: Container(
//           alignment: Alignment.topRight,
//           height: 35,
//           width: 35,
//           decoration: BoxDecoration(
//               color: Colors.green.shade800, borderRadius: BorderRadius.circular(50)),
//           child: Center(
//             child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 }),
//           ),
//         ));
//   }

//   buildMap() {
//     return Container(
//       alignment: Alignment.center,
//       height: MediaQuery.of(context).size.height / 1,
//       width: double.infinity,
//       color: Colors.white,
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(9),
//             color: Colors.grey,
//             image: DecorationImage(
//                 image: NetworkImage(
//                     'https://static2.tripoto.com/media/filter/tst/img/466718/TripDocument/1514641199_2017_12_30_13_06_37_photos.png'),
//                 fit: BoxFit.cover)),
//       ),
//     );
//   }

//   buildScrollBSheet() {
//     return Container();
//   }
// }
