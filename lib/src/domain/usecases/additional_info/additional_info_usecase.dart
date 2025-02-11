import 'package:injectable/injectable.dart';

import '../../entities/user_info/additional_info_entity.dart';

@injectable
class AdditionalInfoUsecase {
  void invoke(AdditionalInfoEntity additionalInfo) {
    print('Hobbies and Interests: ${additionalInfo.hobbiesAndInterests}');
    print('Publications: ${additionalInfo.publications}');
    print('Awards and Honors: ${additionalInfo.awardsAndHonors}');
    print('Volunteer Work: ${additionalInfo.volunteerWork?.description}');
    print('Volunteer Work Month: ${additionalInfo.volunteerWork?.month}');
    print('Volunteer Work Year: ${additionalInfo.volunteerWork?.year}');
  }

  void removeAdditionalInfo(AdditionalInfoEntity additionalInfo) {
    print('${additionalInfo.hobbiesAndInterests} removed!');
  }
}