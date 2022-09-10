import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green.shade800,
      title: Text('Payment'),
      centerTitle: true,
      leading: SizedBox(),
    );
  }

  buildBody() {
    return Column(
      children: [
        buildPaymentlist(),
        // buildOrderHistory(),
        //  buildOrderList()
      ],
    );
  }

  buildPaymentlist() {
    return Card(
        elevation: 2,
        child: Container(
          // height: 70,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'MIO Credits',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  'Balance:₹250',
                  style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'MyWallet');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[100]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add Money',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
