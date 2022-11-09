import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Helper {
  Future<String?> getCurrentPosition(GeolocatorPlatform geolocator) async {
    final hasPermission = await handlePermission(geolocator);

    if (!hasPermission) {
      return null;
    }

    final position = await geolocator.getCurrentPosition();
    return '${position.latitude}, ${position.longitude}';
  }

  Future<bool> handlePermission(GeolocatorPlatform geolocator) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }

  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}
