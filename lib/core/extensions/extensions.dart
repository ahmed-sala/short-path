import '../../../core/common/common_imports.dart';
import '../../config/localization/app_localizations.dart';

extension StringExtenstion on String? {
  /// check this string [value] is empty or null
  bool isNullOrEmpty() => this == null || this == "";
}

/// Context Extension to get height and width of the screen
/// usage: context.height, context.width
extension ContextExtension on BuildContext {
  /// Get height of context screen
  /// usage: context.height
  double get height => MediaQuery.of(this).size.height;

  /// Get width of context screen
  /// usage: context.width
  double get width => MediaQuery.of(this).size.width;
}

extension AppLocalization on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}

extension Localization on BuildContext {
  /// Get localization of the context
  /// usage: context.localization
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
