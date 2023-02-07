import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final LocationController locationController = Get.find<LocationController>();

class LocationController extends GetxController {
  double? lat = 0.00, lang = 0.00;

  String address = '';
  String pincode = '';
  String district = '';
  String state = '';

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );

  getLocationPermission() async {
    var permission = await Permission.location.request();
    if (permission.isGranted) {
      // print('permission granted........');
      getPresentAddress();
    } else {
      address = '';
      update();
    }
  }

  Future<void> getPresentAddress() async {
    Geolocator.getCurrentPosition().then((Position? position) {
      lat = position?.latitude;
      lang = position?.longitude;
      // print('..getting location........');
      getAddressFromLatLong(position?.latitude, position?.longitude);
    }).catchError((err) {
      // print('errr : $err');
      address = 'The Location is disabled';
      update();
    });
  }

  Future<void> getLatestAddress() async {
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      lat = position?.latitude;
      lang = position?.longitude;
      getAddressFromLatLong(position?.latitude, position?.longitude);

    });
  }

  Future getAddressFromLatLong(latitude, longitude) async {
    // print('$latitude');
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placeMarks[0];
    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}';
    district = place.locality.toString();
    pincode = place.postalCode.toString();
    state = place.administrativeArea.toString();
    // print(address);
    update();
    // return;
  }
}
