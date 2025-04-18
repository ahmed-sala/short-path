part of 'career_viewmodel.dart';

@immutable
sealed class CareerState {}

final class CareerInitial extends CareerState {}

final class GenerateCoverSheetLoading extends CareerState {}

final class GenerateCoverSheetError extends CareerState {
  final String message;
  GenerateCoverSheetError(this.message);
}

final class GenerateCoverSheetSuccess extends CareerState {}
