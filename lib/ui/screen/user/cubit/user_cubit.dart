import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data/repositories/user_repository.dart';
import 'package:movie/domain/entities/user_detail.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final repository = UserRepository();

  void gerUser() async {
    emit(UserLoading());
    try {
      final result = await repository.getUser();
      emit(UserLoaded(data: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }
}
