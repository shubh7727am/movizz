import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movizz/View/widget/loading_widget.dart';
import 'package:movizz/View/widget/movie_card.dart';
import 'package:movizz/core/utils/colors.dart';
import 'package:movizz/core/utils/utils.dart';

import '../models/movies_model.dart';
import '../services/services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _service = MovieService();

  List<Movie> _movies = [];
  List<Movie> _topPicks = [];


  void fetchMovies()async{

    await _service.fetchMovies().then((value){
      setState(() {
        _topPicks = _service.sortMovies(movies: value , topMovies: true , criteria: (movie) => movie.rating ?? 0);
        _movies = _service.sortMovies(movies: value, criteria: (movie) => movie.name?? "");
      });

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top rated",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _topPicks.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LoadingWidget(lottieFilePath: Utility.loadingAnimation,width: 100,height: 100,),
                ),
              )
                  : CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 3 / 4,
                  height: 300,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: _topPicks.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: movie.highImageUrl != null
                                ? NetworkImage(movie.highImageUrl!) // Use network image if the URL is not null
                                : AssetImage('assets/placeholder.png'), // Use an asset image as a fallback
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'All Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
             _movies.isEmpty ? LoadingWidget(lottieFilePath: Utility.loadingAnimation,width: 200,height: 200,): GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevents nested scroll issues
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 0.8,
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return MovieCard(movie: movie,);
                },
              ),
              SizedBox(height: 100,width: 100,),
            ],
          ),
        ),
      ),
    );

  }
}
