import 'package:flutter/material.dart';

class OrderDetiles extends StatefulWidget {
  const OrderDetiles({Key? key}) : super(key: key);

  @override
  _OrderDetilesState createState() => _OrderDetilesState();
}

class _OrderDetilesState extends State<OrderDetiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  buildAppbar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 88, 26, 22),
      centerTitle: true,
      title: const Text(
        'Trip Details',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        buildDetiles(),
        buildMap(),
      ],
    );
  }

  buildMap() {
    return Container(
      height: 800,
      color: Colors.black26,
      child: const Center(child: Text('Map')),
    );
  }

  buildDetiles() {
    return Container(
      // height: 150,
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Yesterday, 09:01 Pm',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            trailing: Text(
              '₹ 0.00',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Row(
              children: [
                Text(
                  'CRN59882041',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.navigate_next),
                Text(
                  'Cancelled',
                  style: TextStyle(
                      color: Colors.red[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          ListTile(
            leading: Image.asset('assets/veh1.png'),
            title: const Text(
              'Jagadish V',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            subtitle: Row(
              children: const [
                Text(
                  'TataAce',
                  style: TextStyle(
                      color: Color.fromARGB(255, 88, 26, 22),
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                Icon(Icons.navigate_next),
                Text(
                  'Ka-02-AH-2502',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          SizedBox(
              width: double.infinity,
              // color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 30,
                    ),
                    Expanded(
                      child: Text(
                        '6/8, cholourpala, binnipet, bengaluru,karnataka 560009',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )),
          Container(
              width: double.infinity,
              // color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                    Expanded(
                      child: Text(
                        'Govindraja Nagar,CHBS layout,MCLayOut,vijayangar,bengaluru',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          Container(
            height: 50,
            width: double.infinity,
            // color: Colors.black12,
            child: Center(
              child: Container(
                width: 150,
                color: const Color.fromARGB(255, 88, 26, 22),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Total Fare',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Cancellation charges',
                  style: TextStyle(
                      color: Color.fromARGB(255, 88, 26, 22),
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  '₹ 0.00',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '₹ 0.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            height: 3,
            color: Colors.black12,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: 45,
          //     width: 380,
          //     decoration: BoxDecoration(
          //         color: Colors.green.shade800, borderRadius: BorderRadius.circular(50)),
          //     child: Text(
          //       'MAIL INVOICE',
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //           letterSpacing: 0),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
