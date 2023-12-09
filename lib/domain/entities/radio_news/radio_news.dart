import 'package:json_annotation/json_annotation.dart';

part 'radio_news.g.dart';

@JsonSerializable()
class RadioNews {
  final int id;
  @JsonKey(name: 'dttm')
  final int datetime;
  @JsonKey(name: 'image')
  final String imageUrl;
  @JsonKey(name: 'video_url')
  final String videoUrl;
  final String title;
  final String text;

  RadioNews({
    required this.id,
    required this.datetime,
    required this.imageUrl,
    required this.videoUrl,
    required this.title,
    required this.text,
  });

  factory RadioNews.fromJson(json) => _$RadioNewsFromJson(json);
}
