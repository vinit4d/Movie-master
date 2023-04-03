import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_master/Utils/Constants.dart';

import '../Controllers/MovieDetailsController.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key, required this.movieId}) : super(key: key);
  final controller = Get.put(MovieDetailsController());
  final movieId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        initState: (state) {
          controller.getMovieDetails(movieId);
        },
        init: controller,
        builder: (controller) {
          return Obx(() => Scaffold(
                appBar: AppBar(
                  title: Text(
                      controller.movieDetails.isNotEmpty
                          ? controller.movieDetails['original_title']
                          : '',
                      style: GoogleFonts.balooBhai2(
                          color: Colors.white,
                          textStyle: const TextStyle(fontSize: 20))),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: controller.movieDetails.isNotEmpty
                      ? Container(
                          width: Get.size.width,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  '${imgurl}${controller.movieDetails['poster_path']}',
                                  width: Get.size.width,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Title : ${controller.movieDetails['original_title']}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.indigo,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25))),
                              // const TextStyle(color: Colors.blue),),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'RunTime : ${controller.movieDetails['runtime']}',
                                style: GoogleFonts.balooBhai2(
                                    color: Colors.grey,
                                    textStyle: const TextStyle(fontSize: 18)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Status : ${controller.movieDetails['status']}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.grey,
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Rating : ${controller.movieDetails['vote_average']}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.grey,
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Budget : ${controller.movieDetails['budget']}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.grey,
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Genre : ${controller.movieDetails['genres'].map((item) => item['name'])}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.grey,
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Spoken languages : ${controller.movieDetails['spoken_languages'].map((item) => item['english_name'])}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.grey,
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Overview : ${controller.movieDetails['overview']}',
                                  style: GoogleFonts.balooBhai2(
                                      color: Colors.black,
                                      textStyle:
                                          const TextStyle(fontSize: 16))),
                              const SizedBox(
                                height: 20,
                              ),
                              if (controller
                                  .movieDetails['homepage'].isNotEmpty)
                                SizedBox(
                                  width: Get.size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20)),
                                    onPressed: () async {
                                      final Uri _url = Uri.parse(
                                          controller.movieDetails['homepage']);
                                      debugPrint(
                                          controller.movieDetails['homepage']);
                                      if (!await launchUrl(_url)) {
                                        // throw Exception('Could not launch $_url');
                                        debugPrint('cold not luanch url');
                                      }
                                    },
                                    child: Text(
                                      'Launch site url',
                                      style: GoogleFonts.balooBhai2(
                                          color: Colors.white,
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
              ));
        });
  }
}
