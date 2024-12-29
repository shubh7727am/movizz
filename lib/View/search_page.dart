import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movizz/View/widget/loading_widget.dart';
import 'package:movizz/View/widget/movie_card.dart';
import 'package:movizz/core/utils/dimensions.dart';
import 'package:movizz/services/services.dart';

import '../core/utils/utils.dart';
import '../models/movies_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final _service = MovieService();
  Function(Movie movie) criteria = (movie) => movie.name?? "";

  List<Movie> searchResults = [];
  bool isLoading = false;

  // Function to perform on search submit
  void _performSearch() async{
    String searchQuery = _searchController.text;
    if (searchQuery.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await _service.searchMovies(search: searchQuery).then((value){
        setState(() {
          searchResults = _service.sortMovies(movies: value, criteria: (movie) => movie.name?? "");
          isLoading = false;
        });

      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading? LoadingWidget(lottieFilePath: Utility.loadingAnimation,width: 400,height: 400,) : searchResults.isEmpty ? Center(
        child: SizedBox(width: Dimensions.screenWidth(context)/2,height: Dimensions.screenHeight(context)/3,child: Image.asset("assets/images/logo.png")),
      ) : Padding(
        padding: EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevents nested scroll issues
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: 0.8,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return MovieCard(movie: movie,);
              },
            ),
              SizedBox(height: 100,width: 100,),
            ]

          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Card(
        elevation: 3,
        child: TextField(
          controller: _searchController,
          onSubmitted: (_) => _performSearch(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
          ),
          cursorColor: Colors.white.withOpacity(0.9),
          decoration: InputDecoration(
            hintText: 'Search for movies/series...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.6),
            ),
            suffixIcon:  PopupMenuButton<Function(Movie movie)>(
              icon: Icon(Icons.sort),
              onSelected: (value) {
                setState(() {
                  criteria = value ;
                });
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<Function(Movie movie)>(
                    value: (movie) => movie.name,
                    child: Text('Sort by Name'),
                  ),
                  PopupMenuItem<Function(Movie movie)>(
                    value: (movie) => movie.premiered?? "",
                    child: Text('Sort by Date'),
                  ),
                  PopupMenuItem<Function(Movie movie)>(
                    value: (movie) => movie.rating ?? 0,
                    child: Text('Sort by Rating'),
                  ),
                ];
              },
            ),
          ),
        ),
      ),
    );
  }
}
