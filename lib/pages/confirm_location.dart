import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:location/location.dart';

class ConfirmLocation extends StatefulWidget {
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  // GoogleMapController _controller;
  // Location _location = Location();

  // void _onMapCreated(GoogleMapController _cntlr) {
  //   _controller = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
  //       ),
  //     );
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        buildWelcome(),
        buildMap(),
        buildBShhet(),
      ],
    );
  }

  buildWelcome() {
    return Container(
      // color: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Text(
                  'Confirm Location',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'GJC Madanahalli cross,kolar,karnataka,India',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildMap() {
    return Container(
      height: 590,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        onMapCreated: null,
        myLocationEnabled: true,
      ),
    );
  }

  buildBShhet() {
    return Container(
      // height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Driver Will Call This Contact At Delivery Location',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Please add receiver contact',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Dialog(
                                insetPadding: EdgeInsets.all(0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  // height: 250,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Receiver contact',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.green.shade800,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Text(
                                        'Driver Will Call This Contact At Delivery Location',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          child: TextFormField(
                                            cursorColor: Colors.black,
                                            readOnly: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: '  Mobile Number',
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          child: TextFormField(
                                            cursorColor: Colors.black,
                                            readOnly: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: ' Name',
                                              labelStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
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
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Text(
                                            'Update',
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
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[50]),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.0,
                        ),
                      ),
                    )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'ReviewAddStops');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 380,
                  decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Confirm & Proceed',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
