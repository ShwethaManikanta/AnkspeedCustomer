import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_ank_customer/Models/location_details.dart';
import 'package:new_ank_customer/Models/profile_model.dart';
import 'package:new_ank_customer/Models/vehicle_categories.dart';
import 'package:location/location.dart';

import '../../Models/vehicle_list.dart';
import 'firebase_path.dart';

class DatabaseService {
  DatabaseService({required this.uid});
  final String uid;
  final databaseRef = FirebaseFirestore.instance;

  Future<ProfileDetails?> getIfDatabaseExistAndShowDetails() async {
    final path = FirebasePath.userDetails(uid);
    final reference = databaseRef.doc(path);
    var snapshot = await reference.get();
    ProfileDetails? _profileDetails;
    if (snapshot.exists) {
      _profileDetails = ProfileDetails.fromMap(
          data: snapshot.data(), documentId: snapshot.id);
      return _profileDetails;
    }
    return _profileDetails;
  }

  Future<List<LocationDetailsCopy>?> futureLocation() async {
    List<LocationDetailsCopy> _locationDetails = [];
    final path = FirebasePath.getLocation();
    final reference = databaseRef.collection(path);
    await reference.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        _locationDetails.add(LocationDetailsCopy.fromMap(
            data: element.data(), documentKey: element.id));
      }
    });
    return _locationDetails;
  }

  Future<List<VehilceList>> futureVehicleList(
      {required String vehicleCategory}) async {
    List<VehilceList> _vehicleList = [];
    final path = FirebasePath.vehicleList();
    final reference = databaseRef.collection(path).where(
          "category",
          isEqualTo: vehicleCategory,
        );
    await reference.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        _vehicleList.add(
            VehilceList.fromMap(data: element.data(), documentId: element.id));
      }
    });
    return _vehicleList;
  }

  Future<List<VehicleCategories>> futureVehicleCategories() async {
    List<VehicleCategories> _vehicleCategoryList = [];
    final path = FirebasePath.vehicleCategories();
    final reference = databaseRef.collection(path);
    await reference.get().then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        _vehicleCategoryList.add(VehicleCategories.fromMap(
            data: element.data(), documentId: element.id));
      }
    });
    return _vehicleCategoryList;
  }

  // Future<
}
