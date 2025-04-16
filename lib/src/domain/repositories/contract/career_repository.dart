import 'dart:typed_data';

import 'package:short_path/core/common/api/api_result.dart';

abstract interface class CareerRepository {
  Future<ApiResult<Stream<Uint8List>>> downloadFile(String jobDescription);
  Future<ApiResult<String?>> generateCoverSheet(String jobDescription);
}
