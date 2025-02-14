import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/movie.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final repository = MovieRepository();

  Future<void> searchMovie(String query) async {
    emit(SearchLoading());
    try {
      final result = await repository.searchMovie(query);
      emit(SearchLoaded(movies: result));
    } catch (e) {
      emit(SearchFailed(message: e.toString()));
    }
  }
}
