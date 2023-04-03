import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Api.dart';

class MovieDetailsController extends GetxController {
  RxMap movieDetails = {}.obs;

  void initFunction(movieId) {
    getMovieDetails(movieId);
  }

  void getMovieDetails(movieId) async {
    final getMovieResponse = await API.instance.get(
        endPoint:
            'https://api.themoviedb.org/3/movie/$movieId?api_key=ae5827914ac9502d6a8148f89645728a&language=en-US');
    if (getMovieResponse != null) {
      final data = jsonDecode(getMovieResponse);
      movieDetails.value = data;
      // debugPrint('movie details : $movieDetails');
    } else {
      debugPrint('something went wrong fetching movie data');
    }
  }
}
