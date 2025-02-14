import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/detail/detail_page.dart';
import 'package:movie/ui/screen/search/cubit/search_cubit.dart';
import 'package:movie/ui/screen/search/widgets/movie_card.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: Text(
          'Pencarian "$query"',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaded) {
            if (state.movies.isEmpty) {
              return const Center(
                child: Text("Tidak ada hasil pencarian"),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMoviePage(
                            id: state.movies[index].id!,
                          ),
                        ),
                      );
                    },
                    child: MovieCard(
                      movie: state.movies[index],
                    ),
                  );
                },
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
