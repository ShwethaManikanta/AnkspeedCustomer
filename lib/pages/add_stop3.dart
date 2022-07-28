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
import 'package:new_ank_customer/pages/bookPage/book_vehicle.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class AddStop3 extends StatefulWidget {
  final String? pickupLoction, dropLocation, stop1Location, stop2Location;
  const AddStop3(
      {Key? key,
      this.pickupLoction,
      this.dropLocation,
      this.stop1Location,
      this.stop2Location})
      : super(key: key);

  @override
  State<AddStop3> createState() => _AddStop3State();
}

class _AddStop3State extends State<AddStop3> {
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
                                                    AddStop3Map(
                                                      dropAddress: widget
                                                          .dropLocation
                                                          .toString(),
                                                      latitude: locaiton.lat!,
                                                      longitude: locaiton.lng!,
                                                      stp1Address: widget
                                                          .stop1Location
                                                          .toString(),
                                                      stop2Address: widget
                                                          .stop2Location
                                                          .toString(),
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
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }
}

class AddStop3Map extends StatefulWidget {
  const AddStop3Map({
    Key? key,
    this.latitude,
    this.longitude,
    this.initialScreen = false,
    required this.dropAddress,
    required this.stp1Address,
    required this.stop2Address,
  }) : super(key: key);
  final double? latitude, longitude;
  final bool initialScreen;
  final String dropAddress;
  final String stp1Address;
  final String stop2Address;

  @override
  State<AddStop3Map> createState() => _AddStop3MapState();
}

class _AddStop3MapState extends State<AddStop3Map> {
  Location location = Location();

  TextEditingController stop3Address = TextEditingController();
  TextEditingController stop3area = TextEditingController();

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
                  : AddStop3ReverseGeoCodingTextFormField(
                      addstop1latitude: latLngCamera.latitude,
                      addstop1longitude: latLngCamera.longitude,
                      addstop1administrativeArea: stop3area,
                      stop3Address: stop3Address,
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
                        builder: (context) => AddStop3ShowDetails());

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
                            return AddStop3VerifyAddressBottomSheet(
                              stop3Address: stop3Address.text,
                              stop2Address: widget.stop2Address,
                              dropAddres: widget.dropAddress,
                              stop1Address: widget.stp1Address,
                              toLatitude: latLngCamera.latitude,
                              toState: stop3area.text,
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
}

class AddStop3VerifyAddressBottomSheet extends StatefulWidget {
  AddStop3VerifyAddressBottomSheet(
      {Key? key,
      required this.stop1Address,
      required this.stop2Address,
      required this.stop3Address,
      required this.dropAddres,
      required this.toLatitude,
      required this.toLongitude,
      required this.toState,
      required this.pickUpContactName,
      required this.pickUpContactNumber})
      : super(key: key);
  final String dropAddres,
      stop1Address,
      stop2Address,
      stop3Address,
      toState,
      pickUpContactName,
      pickUpContactNumber;
  final double toLatitude, toLongitude;

  @override
  _AddStop3VerifyAddressBottomSheetState createState() =>
      _AddStop3VerifyAddressBottomSheetState();
}

class _AddStop3VerifyAddressBottomSheetState
    extends State<AddStop3VerifyAddressBottomSheet> {
  List<Model> list = [];

  @override
  void initState() {
    super.initState();
    addLocationMethod();
    //   initialize();
  }

/*  initialize() {
    list.clear();
    list.add(Model(SharedPreference.currentAddress!, Colors.green));
    list.add(Model(widget.stop1Address, Colors.red));
  }*/

  List<String> addLocationList = [];

  addLocationMethod() {
    addLocationList.add(SharedPreference.currentAddress!);
    addLocationList.add(widget.dropAddres);
    addLocationList.add(widget.stop1Address);
    addLocationList.add(widget.stop2Address);
    addLocationList.add(widget.stop3Address);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ReorderableListView(
                children: /*List.generate(addedLocations.length, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2, child: Icon(Icons.location_history)),
                          Expanded(
                            flex: 5,
                            child: Text(
                              addedLocations[index],
                              style: CommonStyles.blue14900(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(index.toString(),
                                style: CommonStyles.blue14900()),
                          ),
                        ],
                      ),
                    ),
                  );
                }),*/

                    addLocationList
                        .map((task) => Container(
                              key: ValueKey(task),
                              /* decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.green)),*/
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8),
                                  leading: const Icon(Icons.location_history),
                                  title: Text(
                                    task,
                                    style: CommonStyles.blue14900(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  //   trailing: Text(addedLocations.),
                                ),
                              ),
                            ))
                        .toList(),
                // The reorder function
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final element = addLocationList.removeAt(oldIndex);
                    addLocationList.insert(newIndex, element);
                  });
                }),
          ),
          /* Padding(
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
          ),*/

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
                          builder: (context) => AddStop3(
                                dropLocation: widget.dropAddres,
                                pickupLoction: SharedPreference.currentAddress,
                                stop1Location: widget.stop1Address,
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
                                fromAddress:
                                    SharedPreference.currentAddress.toString(),
                                toLatitude: widget.toLatitude,
                                toLongitude: widget.toLongitude,
                                toAddress: widget.stop1Address,
                                toState: widget.toState,
                                pickupContactName: widget.pickUpContactName,
                                pickupContactPhone: widget.pickUpContactNumber,
                                stop1: widget.stop1Address,
                                stop2: widget.stop2Address,
                                stop3: widget.stop3Address,
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
  }

  String? fromAddress;
}

class AddStop3ShowDetails extends StatefulWidget {
  AddStop3ShowDetails({Key? key}) : super(key: key);

  @override
  _AddStop3ShowDetailsState createState() => _AddStop3ShowDetailsState();
}

class _AddStop3ShowDetailsState extends State<AddStop3ShowDetails> {
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

class AddStop3ReverseGeoCodingTextFormField extends StatefulWidget {
  AddStop3ReverseGeoCodingTextFormField(
      {Key? key,
      required this.addstop1latitude,
      required this.addstop1longitude,
      required this.stop3Address,
      required this.addstop1administrativeArea,
      this.addStop = false})
      : super(key: key);
  final double addstop1latitude, addstop1longitude;
  final TextEditingController stop3Address;

  final TextEditingController addstop1administrativeArea;
  bool addStop;

  @override
  _AddStop3ReverseGeoCodingTextFormFieldState createState() =>
      _AddStop3ReverseGeoCodingTextFormFieldState();
}

class _AddStop3ReverseGeoCodingTextFormFieldState
    extends State<AddStop3ReverseGeoCodingTextFormField> {
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
        widget.stop3Address.text.toString());
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
                  widget.stop3Address.text = snapshot.data!.first.street! +
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
                  widget.stop3Address.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.stop3Address.text,
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
