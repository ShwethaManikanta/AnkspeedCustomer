import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:new_ank_customer/Services/apiProvider/registration_api_provider.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/add_stop2.dart';
import 'package:new_ank_customer/pages/add_stop3.dart';
import 'package:new_ank_customer/pages/bookPage/book_vehicle.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:new_ank_customer/pages/common_provider.dart';
import 'package:new_ank_customer/pages/pin_point_location.dart';
import 'package:provider/provider.dart';

class AddStop1 extends StatefulWidget {
  final String? pickupLoction, dropLocation;
  final double toLat, toLong;
  const AddStop1(
      {Key? key,
      this.pickupLoction,
      this.dropLocation,
      required this.toLat,
      required this.toLong})
      : super(key: key);

  @override
  State<AddStop1> createState() => _AddStop1State();
}

class _AddStop1State extends State<AddStop1> {
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
            ColorConstant.whiteA700,
            ColorConstant.whiteA700,
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
          Text('Enter Stop Location', style: CommonStyles.black57S17()),
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
                                                    AddStop1Map(
                                                      dropAddress: widget
                                                          .dropLocation
                                                          .toString(),
                                                      latitude: locaiton.lat!,
                                                      longitude: locaiton.lng!,
                                                      toLong: widget.toLong,
                                                      toLat: widget.toLat,
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
                                                style:
                                                    CommonStyles.black57S17(),
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
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }
}

class AddStop1Map extends StatefulWidget {
  const AddStop1Map(
      {Key? key,
      this.latitude,
      this.longitude,
      this.toLat,
      this.toLong,
      this.initialScreen = false,
      required this.dropAddress})
      : super(key: key);
  final double? latitude, longitude, toLat, toLong;
  final bool initialScreen;
  final String dropAddress;

  @override
  State<AddStop1Map> createState() => _AddStop1MapState();
}

class _AddStop1MapState extends State<AddStop1Map> {
  Location location = Location();

  TextEditingController stop1Address = TextEditingController();
  TextEditingController stop1area = TextEditingController();

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
                  : AddStop1ReverseGeoCodingTextFormField(
                      addstop1latitude: latLngCamera.latitude,
                      addstop1longitude: latLngCamera.longitude,
                      addstop1administrativeArea: stop1area,
                      stop1Address: stop1Address,
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
                        builder: (context) => AddStop1ShowDetails(
                              toAddress: widget.dropAddress,
                              toLatitude: widget.toLat!,
                              toLongitude: widget.toLong!,
                              toState: stop1area.text,
                              stop1Address: stop1Address.text,
                              stop1Lat: latLngCamera.latitude,
                              stop1Long: latLngCamera.longitude,
                            ));

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

                      /* showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          builder: (context) {
                            return AddStop1VerifyAddressBottomSheet(
                              dropAddres: widget.dropAddress,
                              toLat: widget.toLat!,
                              toLong: widget.toLong!,
                              stop1Address: stop1Address.text,
                              stop1Latitude: latLngCamera.latitude,
                              toState: stop1area.text,
                              stop1Longitude: latLngCamera.longitude,
                              pickUpContactName: result['name'],
                              pickUpContactNumber: result['phone'],
                            );
                          });*/
                    }
                  },
        tooltip: 'Press to Select Location',
        label: Text(
          "Select Location",
          style: CommonStyles.whiteText15BoldW500(),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class AddStop1ShowDetails extends StatefulWidget {
  AddStop1ShowDetails({
    Key? key,
    required this.toAddress,
    required this.stop1Address,
    required this.stop1Lat,
    required this.stop1Long,
    required this.toLatitude,
    required this.toLongitude,
    required this.toState,
  }) : super(key: key);

  final String toAddress, stop1Address, toState;
  final double toLatitude, toLongitude, stop1Lat, stop1Long;

  @override
  _AddStop1ShowDetailsState createState() => _AddStop1ShowDetailsState();
}

class _AddStop1ShowDetailsState extends State<AddStop1ShowDetails> {
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
                  "Driver will call this contact at Stop Location",
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddStop3PinMapLocation(
                            fromAddress: SharedPreference.currentAddress!,
                            fromLat: SharedPreference.latitude!,
                            fromLong: SharedPreference.longitude!,
                            stop1Lat: widget.stop1Lat,
                            stop1Long: widget.stop1Long,
                            stop1Address: widget.stop1Address,
                            toAddress: widget.toAddress,
                            toLatitude: widget.toLatitude,
                            toLongitude: widget.toLongitude,
                            toState: widget.toState,
                            pickUpContactName: nameController.text,
                            pickUpContactNumber: phoneNumberController.text)));
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

class AddStop1ReverseGeoCodingTextFormField extends StatefulWidget {
  AddStop1ReverseGeoCodingTextFormField(
      {Key? key,
      required this.addstop1latitude,
      required this.addstop1longitude,
      required this.stop1Address,
      required this.addstop1administrativeArea,
      this.addStop = false})
      : super(key: key);
  final double addstop1latitude, addstop1longitude;
  final TextEditingController stop1Address;

  final TextEditingController addstop1administrativeArea;
  bool addStop;

  @override
  _AddStop1ReverseGeoCodingTextFormFieldState createState() =>
      _AddStop1ReverseGeoCodingTextFormFieldState();
}

class _AddStop1ReverseGeoCodingTextFormFieldState
    extends State<AddStop1ReverseGeoCodingTextFormField> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await geocoding.GeocodingPlatform.instance.placemarkFromCoordinates(
        widget.addstop1longitude, widget.addstop1longitude);
  }

  @override
  Widget build(BuildContext context) {
    print("add stop --------Reverse Text--" + widget.addStop.toString());

    print("Address ----------- controllerAddress" +
        widget.stop1Address.text.toString());
    return Container(
      height: 100,
      width: deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.blue),
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
                  .placemarkFromCoordinates(
                      widget.addstop1latitude, widget.addstop1longitude),
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
                  widget.stop1Address.text = snapshot.data!.first.street! +
                      ", " +
                      snapshot.data!.first.subLocality! +
                      ", " +
                      snapshot.data!.first.locality! +
                      ", " +
                      snapshot.data!.first.postalCode! +
                      ", " +
                      snapshot.data!.first.administrativeArea!;
                  widget.addstop1administrativeArea.text =
                      snapshot.data!.first.administrativeArea!;
                  final url = "https://www.google.co.in/maps/@" +
                      widget.addstop1latitude.toString() +
                      "," +
                      widget.addstop1longitude.toString() +
                      ",19z";
                  print(url);
                } else {
                  widget.stop1Address.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.stop1Address.text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: CommonStyles.whiteText12BoldW500(),
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

class AddStop1PinMapLocation extends StatefulWidget {
  const AddStop1PinMapLocation(
      {Key? key,
      required this.toAddress,
      required this.stop1Address,
      required this.toLatitude,
      required this.toLongitude,
      required this.stop1Lat,
      required this.stop1Long,
      required this.toState,
      required this.pickUpContactName,
      required this.pickUpContactNumber})
      : super(key: key);
  final String toAddress,
      stop1Address,
      toState,
      pickUpContactName,
      pickUpContactNumber;
  final double toLatitude, toLongitude, stop1Lat, stop1Long;
  @override
  State<AddStop1PinMapLocation> createState() => _AddStop1PinMapLocationState();
}

class _AddStop1PinMapLocationState extends State<AddStop1PinMapLocation> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late BitmapDescriptor myLocation;
  late BitmapDescriptor endLocation;
  late BitmapDescriptor stopLocation;
  final Set<Marker> _markers = <Marker>{};

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> latlng = [];

  addLocation() {
    latlng.add(LatLng(SharedPreference.latitude!, SharedPreference.longitude!));
    latlng.add(LatLng(widget.toLatitude, widget.toLongitude));
    latlng.add(LatLng(widget.stop1Lat, widget.stop1Long));
  }

  List addAddressList = <String>[];

  addingAddressList() {
    addAddressList.add("${SharedPreference.currentAddress!}");
    addAddressList.add("${widget.toAddress}");
    addAddressList.add(widget.stop1Address);
  }

  List<dynamic> addAddressCoordinates = [];

  _addPolyLine() {
    setState(() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id,
          visible: true,
          width: 2,
          color: Colors.blue,
          points: latlng,
          startCap: Cap.squareCap,
          jointType: JointType.round);

      polylines[id] = polyline;
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));
    setState(() {
      getNearDriver();
    });

    homePageProvider.googleMapController = _cntlr;

    homePageProvider.getDistance(widget.toLatitude, widget.toLongitude);
  }

  Future<void> getNearDriver() async {
    var myLocationPostition =
        LatLng(latlng.first.latitude, latlng.first.longitude);

    print(
        "-------------------${SharedPreference.latitude!} ${SharedPreference.longitude!}");
    _markers.add(Marker(
        markerId: const MarkerId("MyPosition"),
        position: myLocationPostition,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: myLocation));

    var endLocationPostition =
        LatLng(latlng.last.latitude, latlng.last.longitude);
    _markers.add(Marker(
        markerId: const MarkerId("EndPosition"),
        position: endLocationPostition,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: endLocation));

    var stopLocationPostition = LatLng(latlng[1].latitude, latlng[1].longitude);
    _markers.add(Marker(
        markerId: const MarkerId("stopPosition"),
        position: stopLocationPostition,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: stopLocation));
    setState(() {});
  }

  getMarkerIcon() async {
    myLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/srtLoc.png');

    endLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/endLoc.png');
    stopLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/stopLoc.png');
  }

  @override
  void initState() {
    getMarkerIcon();
    addLocation();
    addingAddressList();
    //  toSeprateAddress();
    _addPolyLine();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildMap()),
      bottomSheet: Container(
          height: deviceHeight(context) * 0.5,
          child: Container(
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
                Expanded(
                  child: ReorderableListView.builder(
                    itemCount: latlng.length,
                    itemBuilder: (context, index) {
                      final productName = latlng[index];
                      return Container(
                        key: ValueKey(productName),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: const Icon(Icons.location_history),
                              title: Text(addAddressList[index],
                                  style: CommonStyles.blue14900(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis)
                              //   trailing: Text(addedLocations.),
                              ),
                        ),
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final latLngOrder = latlng.removeAt(oldIndex);
                        latlng.insert(newIndex, latLngOrder);
                        final element = addAddressList.removeAt(oldIndex);
                        addAddressList.insert(newIndex, element);
                        getNearDriver();
                        getMarkerIcon();
                        _addPolyLine();
                      });
                    },
                  ),
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
                                builder: (context) => AddStop2(
                                      fromLat: latlng.first.latitude,
                                      fromLong: latlng.first.longitude,
                                      dropLocation: addAddressList.last,
                                      pickupLoction: addAddressList.first,
                                      stop1Location: addAddressList[1],
                                      toLong: latlng.last.longitude,
                                      toLat: latlng.last.latitude,
                                      stop1Lat: latlng[1].latitude,
                                      stop1Long: latlng[1].longitude,
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
                            setState(() {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => BookVehiclePage(
                                            fromLat: latlng.first.latitude,
                                            fromLong: latlng.first.longitude,
                                            fromAddress: SharedPreference
                                                .currentAddress!,
                                            toLatitude: latlng.last.latitude,
                                            toLongitude: latlng.last.longitude,
                                            toAddress: widget.toAddress,
                                            toState: widget.toState,
                                            pickupContactName:
                                                widget.pickUpContactName,
                                            pickupContactPhone:
                                                widget.pickUpContactNumber,
                                            stop1: widget.stop1Address,
                                            stop1lat: latlng[1].latitude,
                                            stop1long: latlng[1].longitude,
                                          )));
                            });
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
          )),
    );
  }

  buildMap() {
    return SizedBox(
      height: deviceHeight(context) * 0.5,
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,

        polylines: Set<Polyline>.of(polylines.values),
        //polylines: Set<Polyline>.of(homePageProvider.polylines.values),
        onMapCreated: _onMapCreated,
        markers: _markers,
        // markers: Set<Marker>.of(homePageProvider.markerSet),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
      ),
    );
  }
}
