import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenController extends GetxController {
  List<Map<String, dynamic>> quizquestions = [];
  var indexvalue = 0.obs;
  Rx<Color> borderlinescolor = Colors.black.obs; //
  RxList<Color> optionBorderColors = [
    Colors.black, // for Option 1
    Colors.black, // for Option 2
    Colors.black, // for Option 3
  ].obs;

  void incrementIndex() {
    indexvalue.value++; //
  }

  void decrement() {
    indexvalue.value--;
  }
}
