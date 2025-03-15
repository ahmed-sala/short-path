import 'package:json_annotation/json_annotation.dart';

class JobEntity {
  final List<ContentEntity>? content;
  final int? pageNumber;
  final int? pageSize;
  final int? totalElements;
  final int? totalPages;
  final bool? last;

  JobEntity({
    this.content,
    this.pageNumber,
    this.pageSize,
    this.totalElements,
    this.totalPages,
    this.last,
  });
}

@JsonSerializable()
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
  });
}
