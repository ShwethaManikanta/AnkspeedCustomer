import 'package:flutter/material.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/home/home.dart';
import '../../Services/location_services.dart/loaction_shared_preference.dart';

class MyBullet extends StatelessWidget {
  const MyBullet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  bool _showLoading = true;
  @override
  void initState() {
    loadHomePage().whenComplete(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainHomePage()));
    });
    super.initState();
  }

  Future loadHomePage() async {
    await SharedPreference.setValues();
    setState(() {
      _showLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFF),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/shift.gif'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 5,
            left: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // InkWell(
                    //     onTap: () async {
                    //       // Navigator.pushReplacementNamed(context, "Home");
                    //     },
                    //     child: const Text("CONFIRM YOUR LOCATION",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold,
                    //
                    //
                    Visibility(
                        visible: !_showLoading,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "" + SharedPreference.currentAddress.toString(),
                              style: CommonStyles.black10thin(),
                            ),
                          ),
                        )),

                    Visibility(
                        visible: _showLoading,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 0.8,
                            color: Colors.blueGrey,
                          ),
                        ))
                  ],
                ),

                // UIHelper.verticalSpaceMedium(),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     alignment: Alignment.bottomCenter,
                //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.redAccent),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         children: [
                //           InkWell(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(builder: (context) => MapSample()),
                //                 );
                //               },
                //               child: Text("CHANGE MY LOCATION",
                //                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
