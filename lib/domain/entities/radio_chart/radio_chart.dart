import 'package:json_annotation/json_annotation.dart';
part 'radio_chart.g.dart';

@JsonSerializable()
class RadioChartTrack {
  final int id;
  final String? filename;
  final String? meta;
  final int rating;
  @JsonKey(name: 'public_path')
  final String? publicPath;
  final String? path;
  final String author;
  final String title;
  final String? album;
  @JsonKey(name: 'human_up')
  final int thumbsUp;
  @JsonKey(name: 'human_down')
  final int thumbsDown;
  @JsonKey(name: 'tag_image')
  final String? tagImage;
  @JsonKey(name: 'image_medium')
  final String? imageMedium;
  @JsonKey(name: 'image_large')
  final String? imageLarge;

  RadioChartTrack({
    required this.id,
    required this.filename,
    required this.meta,
    required this.rating,
    required this.publicPath,
    required this.path,
    required this.author,
    required this.title,
    required this.album,
    required this.thumbsUp,
    required this.thumbsDown,
    required this.tagImage,
    required this.imageMedium,
    required this.imageLarge,
  });

  factory RadioChartTrack.fromJson(json) => _$RadioChartTrackFromJson(json);
}
