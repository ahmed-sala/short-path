import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/usecases/home/home_usecase.dart';

part 'home_state.dart';

class HomeViewmodel extends Cubit<HomeState> {
  HomeUsecase _homeUsecase;
  HomeViewmodel(
    this._homeUsecase,
  ) : super(HomeInitial());
  AppUser? appUser;
  Future<void> getUserData() async {
    emit(UserDataLoading());
    final result = await _homeUsecase.invoke();
    switch (result) {
      case Success<AppUser?>():
        appUser = result.data;
        emit(UserDataLoaded(appUser));
        break;
      case Failures<AppUser?>():
        var errorMessages = ErrorHandler.fromException(result.exception);
        if (errorMessages.code == 401) {
          emit(SessionExpired());
          emit(UserDataError(errorMessages.errorMessage));
          break;
        }
    }
  }
}
