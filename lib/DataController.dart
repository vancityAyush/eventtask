import 'package:get/get.dart';

class DataController extends GetxController {
  final filePath = "Upload your file here".obs;

  void updatePath(String newPath) {
    filePath.value = newPath;
    update();
  }
}
