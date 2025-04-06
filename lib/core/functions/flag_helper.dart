import 'package:country_flags/country_flags.dart';
import 'package:flutter/widgets.dart';

class FlagHelper {
  static Widget getFlag(String language) {
    switch (language.toLowerCase()) {
      case 'english':
        return CountryFlag.fromCountryCode('US', height: 28, width: 44);
      case 'french':
        return CountryFlag.fromCountryCode('FR', height: 28, width: 44);
      case 'german':
        return CountryFlag.fromCountryCode('DE', height: 28, width: 44);
      case 'spanish':
        return CountryFlag.fromCountryCode('ES', height: 28, width: 44);
      case 'arabic':
        return CountryFlag.fromCountryCode('SA', height: 28, width: 44);
      case 'chinese':
        return CountryFlag.fromCountryCode('CN', height: 28, width: 44);
      default:
        return CountryFlag.fromCountryCode('UN',
            height: 28, width: 44); // Default flag (United Nations)
    }
  }
}
