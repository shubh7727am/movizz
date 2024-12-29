import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movizz/core/utils/colors.dart';
import '../../models/movies_model.dart';
import '../details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the movie details screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: movie),
            ),
          );
        },
        child: Stack(
          children: [
            // Background image with Hero widget
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: movie.id!, // Unique tag for Hero animation
                child: movie.imageUrl != null
                    ? CachedNetworkImage(
                  imageUrl: movie.imageUrl!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                )
                    : Center(
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            ),
            // Black gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Movie details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (movie.genres != null)
                    Text(
                      movie.genres!.join(', '), // Converts the list to a comma-separated string
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    movie.language!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (movie.rating != null)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: ColorResources.getRatingColor(movie.rating!),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      movie.rating.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
