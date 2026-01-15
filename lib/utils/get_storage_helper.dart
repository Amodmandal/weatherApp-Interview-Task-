import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final box = GetStorage();

  static void saveSkip() {
    box.write('skip', true);
  }

  static bool isSkipped() {
    return box.read('skip') ?? false;
  }

  static void saveLocation(String location) {
    box.write('location', location);
  }

  static String? getLocation() {
    return box.read('location');
  }
}
