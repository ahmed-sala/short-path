part of 'localization_viewmodel.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

class ChangLocalizationState extends LocalizationState {}
