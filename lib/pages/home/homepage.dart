import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/pages/search_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import '../../common/utils.dart';
import 'package:marquee/marquee.dart';
import '../rentalPackages/rental_packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  final loc.Location _location = loc.Location();
  final CarouselController controller = CarouselController();

  bool selectRideScreen = false;

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));
    _controller = _cntlr;
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(SharedPreference.latitude!, SharedPreference.longitude!),
            zoom: 16.5),
      ),
    );
  }

  List<String> imageBanner = [
    "assets/b1.jpg",
    "assets/b2.jpg",
    "assets/b3.jpg",
  ];

  bool isvisible = false;
  void showToast() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  showSelectRide() {
    setState(() {
      selectRideScreen = !selectRideScreen;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: buildBody(),
    );
  }

  final colorizeColors = [
    Colors.blue.shade900,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        buildMapPickLocation(),
        DraggableScrollableSheet(
            minChildSize: 0.37,
            maxChildSize: 0.37,
            initialChildSize: 0.37,
            expand: true,
            snap: false,
            builder: (context, ScrollController scrollController) {
              return SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
/* Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: DefaultTextStyle(
                              style: CommonStyles.blue18900(),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'No. 1 Leading Logistics Online Services ',
                                    textStyle: CommonStyles.black15(),
                                    colors: colorizeColors,
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),*/
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: buildTab()),
/* SizedBox(
                          height: 2,
                        ),*/
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10),
                          child: Card(
//   color: Colors.lightBlue[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 15,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
/* SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  //  color: Colors.lightBlue.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "OUR SERVICES",
                                      style: CommonStyles.blue18900(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),*/
                                CarouselSlider.builder(
                                    carouselController: controller,
                                    itemCount: imageBanner.length,
                                    itemBuilder:
                                        (context, currentIndex, realIndex) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        height: 150,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              imageBanner[currentIndex],
                                              fit: BoxFit.fill,
                                            )),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 200,
                                      autoPlay: true,
                                      pageSnapping: true,
                                      autoPlayCurve: Curves.easeInOut,
// enableInfiniteScroll: false,
//  enlargeStrategy: CenterPageEnlargeStrategy.height,
//   viewportFraction: 1,
                                      enlargeCenterPage: true,
//    initialPage: 0,
// aspectRatio: 16/9,
                                      autoPlayInterval: Duration(seconds: 2),
                                      onPageChanged: (index, reason) =>
                                          setState(() => activeIndex = index),
                                    )),

/*   Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "assets/b1.jpg",
                                      height: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "assets/b2.jpg",
                                      height: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      "assets/b3.jpg",
                                      height: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),*/
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
/* Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/anklogo.png",
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  "ANK Speed \nOnline Logistics Services",
                                  style: CommonStyles.blue14900(),
                                )
                              ],
                            ),
                          ),
                        ),*/
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ));
            }),
        buildMapSelectDifferentLocaiton(),
        goToLocationMap()
      ],
    );
  }

  late LatLng latLngCamera;

  int activeIndex = 1;
  bool _isWidgetLoading = false;

  buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialcameraposition),
      mapType: MapType.terrain,
      myLocationButtonEnabled: false,
      // polylines: Set<Polyline>.of(homePageProvider.polylines.values),
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,

      mapToolbarEnabled: false,
      onCameraIdle: () {
        setState(() {
          _isWidgetLoading = false;
        });
      },
      onCameraMove: (value) {
        SharedPreference.selectedLatitude = value.target.latitude;
        SharedPreference.selectedLongitude = value.target.longitude;
      },
      onCameraMoveStarted: () {
        setState(() {
          _isWidgetLoading = true;
        });
      },
    );
  }

  buildMapPickLocation() {
    return Positioned(
      top: (deviceHeight(context) - 33 - 33 - 50) / 2,
      right: (deviceWidth(context) - 33) / 2,
      child: const Align(
        alignment: Alignment.center,
        child: Icon(
          FontAwesomeIcons.mapPin,
          color: Colors.green,
          size: 28,
        ),
      ),
    );
  }

  goToLocationMap() {
    return Positioned(
      top: (deviceHeight(context) - 35 - 35 - 60) / 2,
      right: 10,
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            _controller!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(SharedPreference.latitude!,
                        SharedPreference.longitude!),
                    zoom: 17.5),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.whiteA700,
                border: Border.all(color: Colors.blue)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.my_location_outlined,
                color: Colors.black.withOpacity(0.95),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildMapSelectDifferentLocaiton() {
    // final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return Positioned(
      top: 45,
      child: InkWell(
        onTap: () async {
          final String result =
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchPage(
                        initialLogin: true,
                        isPickupLocation: true,
                      )));
          // final String result = await Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) {
          //   return const PlacePickGoogleMaps();
          // }));
          if (result.isNotEmpty) {
            _controller!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(SharedPreference.latitude!,
                        SharedPreference.longitude!),
                    zoom: 17.5),
              ),
            );
          }
          setState(() {});
        },
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 10,
                    offset: Offset(2, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                  )
                ],
                color: ColorConstant.whiteA700,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_history,
                  color: Colors.green,
                  size: 30,
                ),
                Expanded(
                  child: Marquee(
                    text: SharedPreference.address!.isEmpty
                        ? SharedPreference.currentAddress!
                        : SharedPreference.address!,
                    style: CommonStyles.black14(),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    startPadding: 2,
                    pauseAfterRound: const Duration(seconds: 3),
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                Utils.getSizedBox(width: 3),
                InkWell(
                  onTap: () async {
                    final String result =
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchPage(
                                  initialLogin: true,
                                  isPickupLocation: true,
                                )));
                    // final String result = await Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return const PlacePickGoogleMaps();
                    // }));
                    if (result.isNotEmpty) {
                      _controller!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(SharedPreference.latitude!,
                                  SharedPreference.longitude!),
                              zoom: 15),
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Change",
                        style: CommonStyles.green15(),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 20,
                        color: Colors.black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab() {
    return Container(
      height: 70,
      /* decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 10,
            offset: Offset(2, 2),
            blurRadius: 2,
            color: Colors.lightBlue.shade50,
          )
        ],
      ),*/
      child: Card(
        elevation: 20,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20, left: 20),
          child: InkWell(
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Your Drop ?',
                  style: CommonStyles.black13thin(),
                ),
                const Icon(
                  FontAwesomeIcons.search,
                  color: Colors.green,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectRideScreen extends StatefulWidget {
  const SelectRideScreen({Key? key, required this.function}) : super(key: key);

  final VoidCallback function;

  @override
  _SelectRideScreenState createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildvehicalType(),
    );
  }

  buildvehicalType() {
    return Container(
      width: double.maxFinite,
      // height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
            Container(
              color: Colors.amber[100],
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Drop Should be within city Boundary',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: VehicleCategoriesListWidget(),
            ),
            Container(
              height: 3,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }
}
