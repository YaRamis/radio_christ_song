import 'package:json_annotation/json_annotation.dart';
part 'track_order.g.dart';

@JsonSerializable()
class TrackOrder {
  final int id;
  @JsonKey(name: 'tag_image')
  final String? imgUrl;
  @JsonKey(name: 'image_medium')
  final String? imgMediumUrl;
  @JsonKey(name: 'image_large')
  final String? imgLargeUrl;
  final String? metadata;
  final String author;
  final String title;

  TrackOrder({
    required this.id,
    required this.imgUrl,
    required this.imgMediumUrl,
    required this.imgLargeUrl,
    required this.metadata,
    required this.author,
    required this.title,
  });

  factory TrackOrder.fromJson(json) => _$TrackOrderFromJson(json);
}
