import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/constant/constants.dart';
import 'package:movie/ui/screen/detail/cubit/detail_movie_cubit.dart';
import 'package:movie/ui/screen/reservation/reservation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailMovieScreen extends StatefulWidget {
  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool isFavorite = false;
  String movieId = ''; // Store the movie ID

  @override
  void initState() {
    super.initState();
    // Get movieId from the DetailMovieCubit state
    final detailState = BlocProvider.of<DetailMovieCubit>(context).state;
    if (detailState is DetailMoviesLoaded) {
      movieId = detailState.data.id.toString();
    }
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteMovies = prefs.getStringList('favorite_movies') ?? [];

      if (mounted) {
        setState(() {
          isFavorite = favoriteMovies.contains(movieId);
        });
      }
    } catch (e) {
      print("Error checking favorite status: $e");
      // Handle error, misalnya menampilkan pesan ke pengguna
    }
  }

  Future<void> _toggleFavorite() async { // Remove movieId parameter
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> favoriteMovies = prefs.getStringList('favorite_movies') ?? [];

      if (isFavorite) {
        favoriteMovies.remove(movieId);
        print('Removed movie ID: $movieId');
      } else {
        favoriteMovies.add(movieId);
        print('Added movie ID: $movieId');
      }

      await prefs.setStringList('favorite_movies', favoriteMovies);
      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
        });
      }
    } catch (e) {
      print("Error toggling favorite: $e");
      // Handle error, misalnya menampilkan pesan ke pengguna
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: BlocBuilder<DetailMovieCubit, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMoviesLoaded) {
            // String movieId = state.data.id.toString(); // Get movie ID here
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        '${Constants.imageBaseUrl}${'/original'}${state.data.posterPath}',
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _toggleFavorite(); // Call toggleFavorite without movieId
                              },
                              icon: Icon(
                                Icons.bookmark,
                                color: isFavorite ? ColorPallete.colorYellow : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${state.data.voteAverage}/10',
                              style: const TextStyle(color: Colors.yellow),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '(${state.data.voteCount} voting)',
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            itemCount: state.data.genres?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                            itemBuilder: (context, index) {
                              var category = state.data.genres?[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50), color: ColorPallete.colorSecondary),
                                child: Center(
                                  child: Text(
                                    category?.name ?? '-',
                                    style: TextStyle(color: ColorPallete.colorWhite),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text('${state.data.title}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24)),
                        const SizedBox(
                          height: 16,
                        ),
                        Text('${state.data.overview}', style: const TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is DetailMovieFailed) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<DetailMovieCubit, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMoviesLoaded) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 60,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationPage(
                          idMovie: state.data.id ?? 0,
                          title: state.data.title ?? '',
                          imagePath: '${Constants.imageBaseUrl}/original${state.data.posterPath ?? ''}',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorPallete.colorOrange,
                    ),
                    child: const Center(
                      child: Text(
                        'Get Reservation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}