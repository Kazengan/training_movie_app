import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/domain/entities/genre.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final repository = MovieRepository();

  Future<void> getGenres() async {
    emit(CategoriesLoading());
    try {
      final result = await repository.getGenres();
      emit(CategoriesLoaded(data: result));
    } catch (e) {
      emit(CategoriesFailed(message: e.toString()));
    }
  }
}
