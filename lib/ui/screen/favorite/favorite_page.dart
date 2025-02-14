import 'package:flutter/material.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/movie.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteMovieIds = [];
  List<MovieEntity> favoriteMovies = [];
  bool isLoading = true;
  String errorMessage = '';

  final MovieRepository movieRepository = MovieRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      favoriteMovies = [];
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      favoriteMovieIds = prefs.getStringList('favorite_movies') ?? [];
      print('Loaded favorite movie IDs: $favoriteMovieIds');

      // Fetch movie details for each favorite movie
      List<MovieEntity> movies = [];
      for (String movieIdString in favoriteMovieIds) {
        try {
          int movieId = int.parse(movieIdString);
          MovieEntity movie = await movieRepository.getMovieById(movieId);
          movies.add(movie);
        } catch (e) {
          print("Error fetching details for movie $movieIdString: $e");
          errorMessage = 'Failed to load details for some favorite movies.';
          // Fallback movie untuk menampilkan pesan error di list tile
          movies.add(MovieEntity(title: 'Error: Tidak dapat memuat film dengan ID $movieIdString'));
        }
      }

      setState(() {
        favoriteMovies = movies;
      });
    } catch (e) {
      print("Error loading favorite movies: $e");
      errorMessage = 'Failed to load favorite movies.';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: const Text(
          'Favorite Movies',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : favoriteMovies.isEmpty
                  ? const Center(
                      child: Text(
                        'No favorite movies yet.',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteMovies.length,
                      itemBuilder: (context, index) {
                        final movie = favoriteMovies[index];
                        return Card(
                          color: ColorPallete.colorSecondary,
                          child: ListTile(
                            leading: movie.posterPath != null // Kondisional rendering jika posterPath null
                                ? Image.network(
                                    '${Constants.imageBaseUrl}/w92${movie.posterPath}',
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                                  )
                                : const Icon(Icons.image_not_supported, color: Colors.white), // Placeholder jika posterPath null
                            title: Text(
                              movie.title ?? 'Unknown Title',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              movie.overview ?? 'No Description',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}