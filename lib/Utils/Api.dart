import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'Constants.dart';

class API {
  API._privateConstructure();

  static final API instance = API._privateConstructure();

// <------------------------------------ check internet connect ----------------------------------->
  Future<bool> _checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('connectivity error : $e');
      return false;
    }
  }

  Future get({required endPoint, showLoader: true}) async {
    if (!await _checkInternet()) {
      return null;
    }

    final url = Uri.parse('$baseUrl$endPoint');
    debugPrint('$url');

    try {
      if (showLoader) {
        showLoadingScreen();
      }

      final response = await http.get(url);
      if (showLoader) {
        hideLoader();
      }

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return response.body;
      } else {
        debugPrint('${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('get api error : $e');
      return null;
    }
  }

// <------------------------------------ Show Loader ----------------------------------->
  showLoadingScreen() {
    Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: const Text(
            'Loading...',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ));
  }

  hideLoader() {
    Get.back();
  }
}
