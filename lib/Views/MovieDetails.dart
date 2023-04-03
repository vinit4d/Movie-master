import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/MovieDetailsController.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key, required this.movieId}) : super(key: key);
  final controller = Get.put(MovieDetailsController());
  final movieId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      initState: (state){
        controller.getMovieDetails(movieId);
      },
        init: controller,
      builder: (controller) {
        return Obx(() => Scaffold(
          appBar: AppBar(title: Text(controller.movieDetails.isNotEmpty ? controller.movieDetails['original_title'] : '', style: TextStyle(fontSize: 14),), centerTitle: true,),
          body: SingleChildScrollView(
            child: controller.movieDetails.isNotEmpty? Container(
              width: Get.size.width,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network('http://image.tmdb.org/t/p/w780${controller.movieDetails['poster_path']}', width: Get.size.width,),
                  ),
                  const SizedBox(height: 20,),
                  Text('Title : ${controller.movieDetails['original_title']}', style: const TextStyle(color: Colors.blue),),
                  const SizedBox(height: 20,),
                  Text('RunTime : ${controller.movieDetails['runtime']}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Status : ${controller.movieDetails['status']}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Rating : ${controller.movieDetails['vote_average']}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Budget : ${controller.movieDetails['budget']}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Genre : ${controller.movieDetails['genres'].map((item)=>item['name'])}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Spoken languages : ${controller.movieDetails['spoken_languages'].map((item)=>item['english_name'])}', style: const TextStyle(color: Colors.grey),),
                  const SizedBox(height: 20,),
                  Text('Overview : ${controller.movieDetails['overview']}', style: const TextStyle(color: Colors.black, fontSize: 12),),
                  const SizedBox(height: 20,),
                  if(controller.movieDetails['homepage'].isNotEmpty)
                  SizedBox(
                      width: Get.size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20)),
                        onPressed: ()async{
                    final Uri _url = Uri.parse(controller.movieDetails['homepage']);
                    debugPrint(controller.movieDetails['homepage']);
                    if (!await launchUrl(_url)) {
                    // throw Exception('Could not launch $_url');
                    debugPrint('cold not luanch url');
                    }
                  },
                        child: const Text('launch site url'),

                      ),
                  )
                  ],
              ),
            )
                :const SizedBox(),
          ),
        ));
      }
    );
  }
}
