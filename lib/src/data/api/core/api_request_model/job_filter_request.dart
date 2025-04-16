import 'package:json_annotation/json_annotation.dart';

part 'job_filter_request.g.dart';

@JsonSerializable()
class JobFilterRequest {
  @JsonKey(name: "datePosted")
  final DatePosted? datePosted;
  @JsonKey(name: "employmentTypes")
  final List<String>? employmentTypes;

  JobFilterRequest({
    this.datePosted,
    this.employmentTypes,
  });

  factory JobFilterRequest.fromJson(Map<String, dynamic> json) {
    return _$JobFilterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$JobFilterRequestToJson(this);
  }
}

@JsonSerializable()
class DatePosted {
  @JsonKey(name: "from")
  final String? from;
  @JsonKey(name: "to")
  final String? to;

  DatePosted({
    this.from,
    this.to,
  });

  factory DatePosted.fromJson(Map<String, dynamic> json) {
    return _$DatePostedFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DatePostedToJson(this);
  }
}
