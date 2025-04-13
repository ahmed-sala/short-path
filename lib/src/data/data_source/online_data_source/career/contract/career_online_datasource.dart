import 'dart:typed_data';

abstract interface class CareerOnlineDatasource {
  Future<Stream<Uint8List>> downloadFile(String jobDescription);
  Future<String?> generateCoverSheet(
    String jobDescription,
  );
}
