import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_master/Utils/Api.dart';

class HomeController extends GetxController {
  RxList trendingMovies = [].obs;
  RxList searchResults = [].obs;
  RxBool closeSearch = false.obs;
  TextEditingController searchTerm = TextEditingController(text: '');
  String searchUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=ae5827914ac9502d6a8148f89645728a&language=en-US&page=1&include_adult=false&query=spiderman';

  void initFunction() {
    getTrendingMovies();
    searchMovies();
  }

  void getTrendingMovies() async {
    final getTrendingMoviesResponse = await API.instance.get(
        endPoint:
            'https://api.themoviedb.org/3/movie/popular?api_key=ae5827914ac9502d6a8148f89645728a&language=en-US&page=1');

    if (getTrendingMoviesResponse != null) {
      final data = jsonDecode(getTrendingMoviesResponse);
      trendingMovies.value = data['results'];
      // debugPrint('trending Movies : $trendingMovies');
    }
  }

  void searchMovies() async {
    final searchMoviesResponse = await API.instance.get(
        showLoader: false,
        endPoint:
            'https://api.themoviedb.org/3/search/movie?api_key=ae5827914ac9502d6a8148f89645728a&language=en-US&page=1&include_adult=false&query=${searchTerm.text}');

    if (searchMoviesResponse != null) {
      final data = jsonDecode(searchMoviesResponse);
      searchResults.value = data['results'];
      // debugPrint('search results : $searchResults');
    }
  }
}
