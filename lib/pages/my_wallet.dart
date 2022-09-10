import 'package:flutter/material.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  buildAppbar() {
    return AppBar(
      backgroundColor: Colors.green.shade800,
      leading: SizedBox(),
      centerTitle: true,
      title: Text(
        'My Wallet',
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [buildWallet(), buildAddMoney(), buildTransactionHistory()],
    );
  }

  buildWallet() {
    return Container(
      // height: 500,
      width: double.infinity,
      // color: Colors.black12,
      child: Column(
        children: [
          Container(
              height: 190,
              width: 190,
              child: Image.asset('assets/Wallets.png')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Your Wallet Amount Is',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '₹ 250',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  buildAddMoney() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Add Money',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        readOnly: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0),
                        decoration: InputDecoration(
                          hintText: '₹',
                          isDense: true,
                          labelStyle: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade800.withOpacity(0.2)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '₹ 199',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade800.withOpacity(0.2)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '₹ 599',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade800.withOpacity(0.2)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '₹ 1099',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade800.withOpacity(0.2)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '₹ 2099',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.green.shade800,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildTransactionHistory() {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Transaction History',
              style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0),
            ),
          ),
        ),
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, 'OrderDetiles');
                      },
                      child: ListTile(
                        title: Text(
                          ' Today,09:01pm',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          ' Added Successfully',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          '₹250.00',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
