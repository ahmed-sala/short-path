import 'package:short_path/src/data/dto_models/saved_job_model.dart';

class JobEntity {
  final List<ContentEntity>? content;
  final int? pageNumber;
  final int? pageSize;
  final int? totalElements;
  final int? totalPages;
  final bool? last;
  final int? fullTimeJobsCount;
  final int? partTimeJobsCount;
  final int? internshipJobsCount;
  JobEntity({
    this.fullTimeJobsCount,
    this.partTimeJobsCount,
    this.internshipJobsCount,
    this.content,
    this.pageNumber,
    this.pageSize,
    this.totalElements,
    this.totalPages,
    this.last,
  });
}

class ContentEntity {
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
  bool? isSaved = false;
  ContentEntity({
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
    this.isSaved,
  });
  SavedJobModel toSavedJobModel() {
    return SavedJobModel(
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
    );
  }
}
