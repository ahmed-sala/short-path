sealed class JobDetailState{

}

final class JobDetailInitial extends JobDetailState{

}
final class GenerateCoverSheetLoading extends JobDetailState {}

final class GenerateCoverSheetError extends JobDetailState {
  final String message;
  GenerateCoverSheetError(this.message);
}

final class GenerateCoverSheetSuccess extends JobDetailState {}
