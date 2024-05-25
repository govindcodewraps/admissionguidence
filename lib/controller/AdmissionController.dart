import 'package:admissionguidence/models/TodayTaskModel.dart';
import 'package:admissionguidence/services/AdmissionServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdmissionController extends GetxController {
  var admDataLoading = true.obs;
  var _admData;
  TodayTaskModel? get admListData => _admData;

  Future<void> getTasksList() {
    return AdmissionServices.getTasks()
        .then((response) {
          admDataLoading(true);
          _admData = response;
        })
        .catchError((err) => debugPrint("Error in Post Data!!  : $err"))
        .whenComplete(() => admDataLoading(false));
  }
}
