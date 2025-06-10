import 'package:short_path/src/domain/entities/home/jobs_entity.dart';

class SavedJobModel {
  final int? id;
  final String? title;
  final String? company;
  final String? description;
  final String? image;
  final String? location;
  final String? employmentType;
  final String? datePosted;
  final String? salaryRange;
  final String? url;
  int? userId;
  bool? isSaved = false;
  SavedJobModel({
    this.id,
    this.title,
    this.company,
    this.description,
    this.image,
    this.location,
    this.employmentType,
    this.datePosted,
    this.salaryRange,
    this.url,
    this.userId,
    this.isSaved,
  });

  factory SavedJobModel.fromJson(Map<String, dynamic> json) {
    return SavedJobModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      location: json['location'] as String?,
      employmentType: json['employmentType'] as String?,
      datePosted: json['datePosted'] as String?,
      salaryRange: json['salaryRange'] as String?,
      url: json['url'] as String?,
      userId: json['userId'] as int?,
      isSaved: json['isSaved'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'description': description,
      'image': image,
      'location': location,
      'employmentType': employmentType,
      'datePosted': datePosted,
      'salaryRange': salaryRange,
      'url': url,
      'userId': userId,
      'isSaved': isSaved ?? false,
    };
  }

  ContentEntity toEntity() {
    return ContentEntity(
      id: id,
      title: title,
      company: company,
      description: description,
      image: image,
      location: location,
      employmentType: employmentType,
      datePosted: datePosted,
      salaryRange: salaryRange,
      url: url,
      isSaved: isSaved ?? false,
    );
  }
}
