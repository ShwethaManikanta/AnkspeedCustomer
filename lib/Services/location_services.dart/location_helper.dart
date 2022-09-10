import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  double? latitude;
  double? longitude;
  late Position _currentPosition;
  dynamic currentAddress;

  Future<void> getCurrentLocation() async {
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        print("Position from the geolocator   - -----" +
            position.latitude.toString() +
            "----" +
            position.longitude.toString());
        _currentPosition = position;
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
      }).catchError((e) {
        print(e);
        print("Error while getting current position");
      });
    } else if (status == PermissionStatus.denied) {
      print(
          'Denied. Show a dialog with a reason and again ask for the permission.');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
    }
  }
}
