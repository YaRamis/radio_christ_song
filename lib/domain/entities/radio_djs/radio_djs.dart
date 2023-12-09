import 'package:json_annotation/json_annotation.dart';
part 'radio_djs.g.dart';

@JsonSerializable()
class RadioDj {
  final int id;
  @JsonKey(name: 'image_thumbnail')
  final String imageThumbnail;
  @JsonKey(name: 'image_medium')
  final String imageMedium;
  final String name;
  final String metadata;
  final String image;

  RadioDj({
    required this.id,
    required this.imageThumbnail,
    required this.imageMedium,
    required this.name,
    required this.metadata,
    required this.image,
  });

  factory RadioDj.fromJson(json) => _$RadioDjFromJson(json);
}
