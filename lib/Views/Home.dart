import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_master/Controllers/HomeController.dart';
import 'package:movie_master/Views/MovieDetails.dart';

import '../Utils/Constants.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Master',
            style: GoogleFonts.balooBhai2(
                color: Colors.white, textStyle: const TextStyle(fontSize: 20))),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          initState: (state) {
            controller.initFunction();
          },
          builder: (controller) {
            return Obx(() => SingleChildScrollView(
                  child: SizedBox(
                    width: Get.size.width,
                    child: Column(
                      children: [
                        Container(
                          width: Get.size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.search),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                // width: 100,
                                child: TextFormField(
                                  controller: controller.searchTerm,
                                  onChanged: (value) {
                                    controller.searchMovies();
                                    controller.closeSearch.value = true;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: controller.closeSearch.value
                                        ? IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              controller.searchTerm.text = '';
                                              controller.searchResults.value =
                                                  [];
                                              controller.closeSearch.value =
                                                  false;
                                              FocusScope.of(context).unfocus();
                                            },
                                          )
                                        : const SizedBox(
                                            height: 0,
                                          ),
                                    hintStyle: GoogleFonts.balooBhai2(
                                        textStyle:
                                            const TextStyle(fontSize: 18)),
                                    hintText: 'Search here.....',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.searchResults.isNotEmpty
                                ? controller.searchResults.length
                                : controller.trendingMovies.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => MovieDetails(
                                        movieId: controller
                                                .searchResults.isNotEmpty
                                            ? controller.searchResults[index]
                                                ['id']
                                            : controller.trendingMovies[index]
                                                ['id'],
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width: Get.size.width,
                                  // height: 200,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: controller
                                                  .searchResults.isNotEmpty
                                              ? (controller.searchResults[index]
                                                          ['poster_path'] !=
                                                      null
                                                  ? Image.network(
                                                      '${imgurl}${controller.searchResults[index]['poster_path']}',
                                                      width: 100,
                                                    )
                                                  : const Text(
                                                      'Image not found'))
                                              : (controller.trendingMovies[
                                                              index]
                                                          ['poster_path'] !=
                                                      null
                                                  ? Image.network(
                                                      '${imgurl}${controller.trendingMovies[index]['poster_path']}',
                                                      width: 100,
                                                    )
                                                  : const Text(
                                                      'Image not found'))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                controller.searchResults
                                                        .isNotEmpty
                                                    ? controller.searchResults[
                                                        index]['original_title']
                                                    : controller.trendingMovies[
                                                            index]
                                                        ['original_title'],
                                                style: GoogleFonts.balooBhai2(
                                                    color: Colors.indigo,
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20))),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                'Rating : ${controller.searchResults.isNotEmpty ? controller.searchResults[index]['vote_average'] : controller.trendingMovies[index]['vote_average']}',
                                                style: GoogleFonts.balooBhai2(
                                                    color: Colors.green,
                                                    textStyle: const TextStyle(
                                                        fontSize: 18))),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                                height: 100,
                                                child: Text(
                                                  controller.searchResults
                                                          .isNotEmpty
                                                      ? controller
                                                              .searchResults[
                                                          index]['overview']
                                                      : controller
                                                              .trendingMovies[
                                                          index]['overview'],
                                                  style: GoogleFonts.balooBhai2(
                                                      color: Colors.black,
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14)),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
