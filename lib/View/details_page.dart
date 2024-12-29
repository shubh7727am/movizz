import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movizz/core/utils/dimensions.dart';
import '../../models/movies_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero image transition
            Stack(
              children: [
                Hero(
                tag: movie.id!, // Must match the tag in the MovieCard
                child: movie.highImageUrl != null ? CachedNetworkImage(
                  imageUrl: movie.highImageUrl!,
                  fit: BoxFit.fill,
                  width: Dimensions.screenHeight(context),
                  height: Dimensions.screenHeight(context)/1.7,
                ) : Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
                Container(
                  width: Dimensions.screenHeight(context),
                  height: Dimensions.screenHeight(context)/2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.screenHeight(context),
                  height: Dimensions.screenHeight(context)/1.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xB2000000), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40,left: 16,right: 16),
                  child: Row(
                    children: [IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios)),
                    Spacer(),
                      if(movie.rating != null) Text("${movie.rating} ⭐",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ]
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.name!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie.genres?.join(', ') ?? 'No genres available',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Language: ${movie.language}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ]
            ),

          ],
        ),
      ),
    );
  }
}
