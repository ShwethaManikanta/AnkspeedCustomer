import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/bookPage/book_vehicle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_place/google_place.dart';
import 'package:new_ank_customer/pages/multi_stop_screen.dart';
import 'package:provider/provider.dart';
import '../common/common_styles.dart';

// import 'ConfirmLocation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {Key? key, this.initialLogin = false, this.isPickupLocation = false})
      : super(key: key);

  final bool initialLogin;
  final bool isPickupLocation;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  final _autocompleteLocationController = TextEditingController();

  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyDgrOHeCPPtxJVF3GGQvkfZrXllj6Z4HTU');
    super.initState();
  }

  bool isvisible = true;

  void showToast() {
    setState(() {
      isvisible = isvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
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
        children: [
          buildWelcome(),
          // placesAutoCompleteTextField(context),
          buildSearch(),
          buildListOfLocality(),
          // buildRecentdrop(),
          // buildRecentdropList()
        ],
      ),
    );
  }

  bool _fetchingAutoComplete = false;

  void autoCompleteSearch(String value) async {
    setState(() {
      _fetchingAutoComplete = true;
    });
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = result.predictions!;
      _fetchingAutoComplete = false;
    }
    setState(() {});
  }

  buildWelcome() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          widget.isPickupLocation
              ? Text('Enter PickUp Location', style: CommonStyles.black57S17())
              : Text('Enter Drop Location', style: CommonStyles.black57S17()),
        ],
      ),
    );
  }

  buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: double.infinity,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 10,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.search_rounded,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  }
                },
                cursorColor: Colors.black,
                readOnly: false,
                controller: _autocompleteLocationController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: CommonStyles.black13thin(),
                decoration: const InputDecoration(
                    hintText: 'Search your area,street name.. ',
                    isDense: false,
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListOfLocality() {
    return Expanded(
      child: _autocompleteLocationController.text.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search your locaiton on search box",
                    style: CommonStyles.whiteText15BoldW500(),
                  )
                ],
              ),
            )
          : _fetchingAutoComplete
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 1,
                        backgroundColor: Colors.black12,
                        color: Colors.green[900],
                      ),
                      Utils.getSizedBox(height: 15),
                      Text(
                        "Loading...",
                        style: CommonStyles.blue12(),
                      )
                    ],
                  ),
                )
              : predictions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Oops! We could not find locaiton your searching.",
                            style: CommonStyles.red12(),
                          )
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Search Results",
                            style: CommonStyles.black16(),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: predictions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: deviceWidth(context) * 0.9,
                                  child: InkWell(
                                    onTap: () async {
                                      Utils.showLoaderDialog(context);
                                      DetailsResponse? result =
                                          await googlePlace.details
                                              .get(predictions[index].placeId!);
                                      Navigator.of(context).pop();
                                      if (result != null) {
                                        Location locaiton =
                                            result.result!.geometry!.location!;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlacePickGoogleMaps(
                                                      latitude: locaiton.lat!,
                                                      longitude: locaiton.lng!,
                                                      initialScreen:
                                                          widget.initialLogin,
                                                    )));
                                      } else {
                                        Utils.showSnackBar(
                                            context: context,
                                            text:
                                                "Oops! Something went wrong!!");
                                      }

                                      // if (result != null &&
                                      //     result.predictions != null &&
                                      //     mounted) {
                                      //   predictions = result.predictions!;
                                      //   _fetchingAutoComplete = false;
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_history,
                                          size: 28,
                                        ),
                                        Utils.getSizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                predictions[index].description!,
                                                maxLines: 2,
                                                style: CommonStyles
                                                    .whiteText16BoldW500(),
                                              ),
                                              Utils.getSizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                predictions[index]
                                                    .structuredFormatting!
                                                    .mainText!,
                                                style: CommonStyles.black14(),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              // return ListTile(
                              //   contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              //   dense: true,
                              //   leading: const Icon(
                              //     Icons.location_on,
                              //     color: Colors.black,
                              //   ),
                              //   title: Text(
                              //     predictions[index].description!,
                              //     style: CommonStyles.black13(),
                              //   ),
                              //   subtitle:  Text(
                              //     predictions[index].description!,
                              //     style: CommonStyles.black13(),
                              //   )
                              //   onTap: () {
                              //     debugPrint(predictions[index].placeId);
                              //     Navigator.pushNamed(context, "ConfirmLocation",
                              //         arguments: predictions[index].description);
                              //   },
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }

  // buildRecentdrop() {
  //   return Visibility(
  //     visible: isvisible,
  //     child: Container(
  //       alignment: Alignment.topLeft,
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 5, left: 15),
  //         child: Text(
  //           'Recent drops',
  //           style: TextStyle(
  //               fontSize: 12,
  //               color: Colors.black,
  //               fontWeight: FontWeight.w500,
  //               letterSpacing: 0),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // buildRecentdropList() {
  //   return Expanded(
  //     flex: 1,
  //     child: Container(
  //       child: ListView.builder(
  //           physics: BouncingScrollPhysics(),
  //           itemCount: 2,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.only(top: 0),
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, 'ConfirmLocation');
  //                 },
  //                 child: ListTile(
  //                     leading: Icon(
  //                       Icons.timelapse_rounded,
  //                       size: 35,
  //                     ),
  //                     title: Text('Govindraja Nagar',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w800,
  //                             letterSpacing: 0)),
  //                     subtitle: Text(
  //                       'CHBS LAYOUT, MC LAYOUT,VIJAYANAGAR',
  //                       style: TextStyle(
  //                           fontSize: 8,
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.w400,
  //                           letterSpacing: 0),
  //                     ),
  //                     trailing:
  //                         IconButton(icon: Icon(Icons.star), onPressed: () {})),
  //               ),
  //             );
  //           }),
  //     ),
  //   );
  // }
}

class PlacePickGoogleMaps extends StatefulWidget {
  const PlacePickGoogleMaps(
      {Key? key,
      this.latitude,
      this.longitude,
      this.initialScreen = false,
      this.addStop = false})
      : super(key: key);

  final double? latitude, longitude;
  final bool initialScreen;
  final bool addStop;

  @override
  _PlacePickGoogleMapsState createState() => _PlacePickGoogleMapsState();
}

class _PlacePickGoogleMapsState extends State<PlacePickGoogleMaps> {
  Location location = Location();

  TextEditingController controllerAddress = TextEditingController();
  TextEditingController administrativeArea = TextEditingController();

  late LatLng latLngCamera;

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  @override
  void initState() {
    print("Init state pronted");
    super.initState();
    if (widget.latitude == null || widget.longitude == null) {
      latLngCamera =
          LatLng(SharedPreference.latitude!, SharedPreference.longitude!);
    } else {
      latLngCamera = LatLng(widget.latitude!, widget.longitude!);
    }

    print(latLngCamera.latitude.toString() +
        "Lat long camera" +
        latLngCamera.longitude.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  bool _isWidgetLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              // padding: const EdgeInsets.only(top: 180),
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(latLngCamera.latitude, latLngCamera.longitude),
                  zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                getJsonFile("assets/mapStyle.json")
                    .then((value) => controller.setMapStyle(value));
                _controller.complete(controller);
                mapController = controller;
              },
              onCameraIdle: () {
                setState(() {
                  _isWidgetLoading = false;
                });
              },
              onCameraMove: (value) {
                latLngCamera = value.target;
              },
              onCameraMoveStarted: () {
                setState(() {
                  _isWidgetLoading = true;
                });
              },
            ),
          ),
          Positioned(
            top: (deviceHeight(context) - 70) / 2,
            right: (deviceWidth(context) - 35) / 2,
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.blue,
                size: 35,
              ),
            ),
          ),
          Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: _isWidgetLoading
                  ? Container(
                      height: 100,
                      width: deviceWidth(context) * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.amber),
                          color: Colors.blue),
                      child: const Center(
                        child: SizedBox(
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
                          ),
                          width: 25,
                        ),
                      ),
                    )
                  : ReverseGeoCodingTextFormField(
                      latitude: latLngCamera.latitude,
                      longitude: latLngCamera.longitude,
                      administrativeArea: administrativeArea,
                      controllerAddress: controllerAddress,
                    ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: _isWidgetLoading
            ? () {}
            : widget.initialScreen
                ? () async {
                    await SharedPreference.getLocationData(
                        latLngCamera.latitude, latLngCamera.longitude);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop("Hello");
                  }
                : () async {
                    final result = await showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        context: context,
                        builder: (context) => ShowDetails());

                    if (result['name'] == "" ||
                        result['name'] == null ||
                        result['phone'] == "" ||
                        result['phone'] == null) {
                      Utils.showSnackBar(
                          context: context, text: "Details not given");
                    } else {
                      selectedLongLat
                          .setSelectedLatitude(latLngCamera.latitude);
                      selectedLongLat
                          .setSelectedLongitude(latLngCamera.longitude);

                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          builder: (context) {
                            return VerifyAddressBottomSheet(
                              toAddress: controllerAddress.text,
                              toLatitude: latLngCamera.latitude,
                              toState: administrativeArea.text,
                              toLongitude: latLngCamera.longitude,
                              pickUpContactName: result['name'],
                              pickUpContactNumber: result['phone'],
                            );
                          });
                    }
                  },
        tooltip: 'Press to Select Location',
        label: Text(
          "Select Location",
          style: CommonStyles.whiteText15BoldW500(),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  final globalFormKey = GlobalKey<FormState>();

  enterNameAndPhoneNumber() {
    return Form(
      key: globalFormKey,
      child: Column(
        children: [
          TextFormField(),
          TextFormField(),
        ],
      ),
    );
  }
}

class VerifyAddressBottomSheet extends StatefulWidget {
  const VerifyAddressBottomSheet(
      {Key? key,
      required this.toAddress,
      required this.toLatitude,
      required this.toLongitude,
      required this.toState,
      required this.pickUpContactName,
      required this.pickUpContactNumber})
      : super(key: key);
  final String toAddress, toState, pickUpContactName, pickUpContactNumber;
  final double toLatitude, toLongitude;
  @override
  _VerifyAddressBottomSheetState createState() =>
      _VerifyAddressBottomSheetState();
}

// class _VerifyAddressBottomSheetState extends State<VerifyAddressBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           'Review Location',
//           style: CommonStyles.black13(),
//         )
//       ],
//     );
//   }
// }

class _VerifyAddressBottomSheetState extends State<VerifyAddressBottomSheet> {
  List<Model> list = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() {
    list.clear();
    list.add(Model(SharedPreference.currentAddress!, Colors.green));
    list.add(Model(widget.toAddress, Colors.red));
  }

  // void addNew() {
  //   setState(() {
  //     list.add(Model("Karnool", Colors.black));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Review Location",
              style: CommonStyles.blue18900(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (con, ind) {
                  return ind != 0
                      ? Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(children: [
                            Column(
                              children: List.generate(
                                4,
                                (ii) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Container(
                                      height: 3,
                                      width: 2,
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                          ]),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Row(children: [
                              Icon(Icons.location_on, color: list[ind].color),
                              Flexible(
                                child: Text(list[ind].address,
                                    maxLines: 3, style: CommonStyles.red12()),
                              )
                            ]),
                          )
                        ])
                      : InkWell(
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => const SearchPage(
                                          initialLogin: true,
                                          isPickupLocation: true,
                                        )));

                            if (result == "Hello") {
                              initialize();
                              setState(() {});
                            }
                          },
                          child: Row(children: [
                            Icon(Icons.location_on, color: list[ind].color),
                            Flexible(
                              child: Text(list[ind].address,
                                  maxLines: 3, style: CommonStyles.green12()),
                            )
                          ]),
                        );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.blue[900],
                    height: 40,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiStopScreen(
                                pickUpLocation: list[0].address,
                                dropLocation: widget.toAddress,
                              )));
                    },
                    child: Center(
                      child: Text(
                        "Add Stop",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                    )),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.blue[900],
                    height: 40,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BookVehiclePage(
                                fromAddress: list[0].address,
                                toLatitude: widget.toLatitude,
                                toLongitude: widget.toLongitude,
                                toAddress: widget.toAddress,
                                toState: widget.toState,
                                pickupContactName: widget.pickUpContactName,
                                pickupContactPhone: widget.pickUpContactNumber,
                              )));
                    },
                    child: Center(
                      child: Text(
                        "Confirm Location",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );

    // Scaffold(
    //     appBar: AppBar(
    //         backgroundColor: Colors.black,
    //         title:
    //             Text('Custom Stepper', style: TextStyle(color: Colors.white)),
    //         actions: [
    //           IconButton(
    //               icon: Icon(Icons.add_circle, color: Colors.white),
    //               onPressed: addNew)
    //         ]),
    //     body:

    //     );
  }

  String? fromAddress;
}

class ShowDetails extends StatefulWidget {
  const ShowDetails({Key? key}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  final nameController = TextEditingController();
  final nameKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController();
  final phoneNumberKey = GlobalKey<FormState>();

  bool? _isSelectedUseMyMobile;

  @override
  Widget build(BuildContext context) {
    final profileViewAPIProvider =
        Provider.of<ProfileViewAPIProvider>(context, listen: false);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        // height: 255,
        // width: deviceWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 8, bottom: 8),
              child: Center(
                child: Text(
                  "Driver will call this contact at Drop Location",
                  style: CommonStyles.blue14900(),
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Form(
                        key: nameKey,
                        child: TextFormField(
                          autofocus: true,
                          style: CommonStyles.black13thin(),
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "Enter valid name";
                            }
                            return null;
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              //   enabledBorder: InputBorder.none,
                              hintText: 'Enter The Name',
                              hintStyle: CommonStyles.black10thin(),
                              //  border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(
                                  left: 10, top: 5, bottom: 5)),
                          cursorColor: (ColorConstant.deepPurpleA200),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: phoneNumberKey,
                child: TextFormField(
                  autofocus: true,
                  style: CommonStyles.black13thin(),
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return "Enter valid phone number";
                    }
                    return null;
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            openContactBook();
                          },
                          icon: Icon(
                            Icons.contacts_rounded,
                            color: _fromPhoneBook
                                ? Colors.blue[900]
                                : Colors.black54,
                          )),
                      counterText: "",
                      hintText: 'Enter The Phone Number',
                      hintStyle: CommonStyles.black10thin(),
                      //  border: const OutlineInputBorder(),
                      contentPadding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5)),
                  cursorColor: (Colors.orange[900])!,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      if (value != null && value) {
                        nameController.text = profileViewAPIProvider
                            .profileViewResponse!.userDetails!.userName!;
                        phoneNumberController.text = profileViewAPIProvider
                            .profileViewResponse!.userDetails!.mobile!;
                      } else if (value != null && !value) {
                        nameController.clear();
                        phoneNumberController.clear();
                      }
                      setState(() {
                        _useUserDetails = value!;
                      });
                      // final loggenInUser =
                      //Get Details From usermodel from api and use it in name and phone number controller.
                      //
                    },
                    value: _useUserDetails,
                  ),
                  Utils.getSizedBox(width: 4),
                  RichText(
                      text: TextSpan(
                          text: "Use my mobile number :",
                          style: CommonStyles.black11(),
                          children: [
                        TextSpan(
                            text:
                                "  +91 ${profileViewAPIProvider.profileViewResponse!.userDetails!.mobile!}",
                            style: CommonStyles.black1154())
                      ]))
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  if (nameKey.currentState!.validate() &&
                      phoneNumberKey.currentState!.validate()) {
                    Map<String, dynamic> map = {
                      'name': nameController.text,
                      'phone': phoneNumberController.text,
                    };
                    Navigator.of(context).pop(map);
                  }
                },
                minWidth: deviceWidth(context) * 0.8,
                height: 40,
                color: const Color.fromARGB(255, 0, 102, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Save & Proceed",
                    style: CommonStyles.whiteText12BoldW500(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _fromPhoneBook = false;
  bool _useUserDetails = false;
  Future<String> openContactBook() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    if (contact.phoneNumber == null && contact.fullName == null) {
      Utils.showSnackBar(context: context, text: "Phone Number not selected");
    } else {
      if (contact.fullName != null) {
        nameController.text = contact.fullName!;
      }
      if (contact.phoneNumber != null) {
        PhoneNumber contactPhoneNumber = contact.phoneNumber!;

        // print("contact phone number " + contactPhoneNumber.number!.toString());
        // var phoneNumberString =
        //     contact.phoneNumber.toString().replaceAll(RegExp(r"\s+"), "");
        phoneNumberController.text = contactPhoneNumber.number!.toString();
      }
      setState(() {
        _fromPhoneBook = true;
      });
    }
    return "";
  }

  // Future<String> openContactBook() async {
  //   Contact contact = await ContactPicker().selectContact();
  //   if (contact != null) {

  //     return phoneNumber;
  //   }
  //   return "";
  // }
}

class ReverseGeoCodingTextFormField extends StatefulWidget {
  const ReverseGeoCodingTextFormField(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.controllerAddress,
      required this.administrativeArea})
      : super(key: key);
  final double latitude, longitude;
  final TextEditingController controllerAddress;
  final TextEditingController administrativeArea;

  @override
  _ReverseGeoCodingTextFormFieldState createState() =>
      _ReverseGeoCodingTextFormFieldState();
}

class _ReverseGeoCodingTextFormFieldState
    extends State<ReverseGeoCodingTextFormField> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await geocoding.GeocodingPlatform.instance
        .placemarkFromCoordinates(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.amber),
          color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location From Map",
              style: CommonStyles.whiteText15BoldW500(),
            ),
          ),
          FutureBuilder<List<geocoding.Placemark>>(
              future: geocoding.GeocodingPlatform.instance
                  .placemarkFromCoordinates(widget.latitude, widget.longitude),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                if (snapshot.data != null) {
                  widget.controllerAddress.text = snapshot.data!.first.street! +
                      ", " +
                      snapshot.data!.first.subLocality! +
                      ", " +
                      snapshot.data!.first.locality! +
                      ", " +
                      snapshot.data!.first.postalCode! +
                      ", " +
                      snapshot.data!.first.administrativeArea!;
                  widget.administrativeArea.text =
                      snapshot.data!.first.administrativeArea!;
                  final url = "https://www.google.co.in/maps/@" +
                      widget.latitude.toString() +
                      "," +
                      widget.longitude.toString() +
                      ",19z";
                  print(url);
                } else {
                  widget.controllerAddress.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.controllerAddress.text,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: CommonStyles.whiteText12BoldW500(),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class ChangeMapsStateProvider with ChangeNotifier {
  double _latitude = 0.00;
  double _longitude = 0.00;

  void setLatitudeLongitude(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
  }

  double get latitude => _latitude;

  double get longitude => _longitude;
}

class LocationReviewPage extends StatefulWidget {
  const LocationReviewPage({Key? key}) : super(key: key);

  @override
  _LocationReviewPageState createState() => _LocationReviewPageState();
}

class _LocationReviewPageState extends State<LocationReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
