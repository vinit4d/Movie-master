import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text(
          'Movie Master',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          initState: (state) {
            controller.initFunction();
          },
          builder: (controller) {
            return Obx(() => SingleChildScrollView(
                  child: Container(
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
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      controller.searchTerm.text = '';
                                      controller.searchResults.value = [];
                                    },
                                  ),
                                  hintText: 'Search Here',
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          child: ListView.builder(
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
                                                ? (controller.searchResults[
                                                                index]
                                                            ['poster_path'] !=
                                                        null
                                                    ? Image.network(
                                                        'http://image.tmdb.org/t/p/w780${controller.searchResults[index]['poster_path']}',
                                                        width: 100,
                                                      )
                                                    : const Text(
                                                        'Image not found'))
                                                : (controller.trendingMovies[
                                                                index]
                                                            ['poster_path'] !=
                                                        null
                                                    ? Image.network(
                                                        '${imgUrl}${controller.trendingMovies[index]['poster_path']}',
                                                        width: 100,
                                                      )
                                                    : const Text(
                                                        'Image not found'))
                                            // Image.network('http://image.tmdb.org/t/p/w780${controller.searchResults.isNotEmpty? controller.searchResults[index]['poster_path'] : controller.trendingMovies[index]['poster_path']}', width: 100,),
                                            ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.searchResults
                                                        .isNotEmpty
                                                    ? controller.searchResults[
                                                        index]['original_title']
                                                    : controller.trendingMovies[
                                                            index]
                                                        ['original_title'],
                                                style: const TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                'Rating : ${controller.searchResults.isNotEmpty ? controller.searchResults[index]['vote_average'] : controller.trendingMovies[index]['vote_average']}',
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              ),
                                              Container(
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
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
