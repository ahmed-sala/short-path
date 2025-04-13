import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../api/core/constants/apis_baseurl.dart';
import '../../../../api/core/constants/apis_end_points.dart';
import '../contract/career_online_datasource.dart';

@Injectable(as: CareerOnlineDatasource)
class CareerOnlineDatasourceImpl implements CareerOnlineDatasource {
  @override
  Future<String> downloadFile(String jobDescription) async {
    try {
      String? token = await getIt<FlutterSecureStorage>()
          .read(key: SharedPrefKeys.userToken);

      dio.Dio client = dio.Dio(
        dio.BaseOptions(
          connectTimeout: const Duration(seconds: 10),
        ),
      );

      dio.Response<dio.ResponseBody> response = await client.post(
        '${ApisBaseurl.baseUrl}${ApisEndPoints.downloadCv}',
        data: {
          "jobDescription": jobDescription,
        },
        options: dio.Options(
          responseType: dio.ResponseType.stream,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      String filePath = path.join(directory.path, 'file.pdf');
      File file = File(filePath);

      IOSink sink = file.openWrite();
      await for (var chunk in response.data!.stream) {
        sink.add(chunk);
      }
      await sink.close();

      final fileSize = await file.length();
      print('File saved at: $filePath, size: $fileSize bytes');

      return filePath;
    } catch (e) {
      print('Download failed: $e');
      throw Exception('Download failed: $e');
    }
  }
}
