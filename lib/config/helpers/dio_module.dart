import 'package:injectable/injectable.dart';

import '../../src/data/api/dio_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  DioClient get dioClient => DioClient();
}
