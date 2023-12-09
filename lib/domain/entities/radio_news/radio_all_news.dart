import 'package:json_annotation/json_annotation.dart';
import 'package:radio_christ_song/domain/entities/radio_news/radio_news.dart';

part 'radio_all_news.g.dart';

@JsonSerializable()
class RadioAllNews {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<RadioNews> allNews;

  RadioAllNews({
    required this.count,
    required this.next,
    required this.previous,
    required this.allNews,
  });

  factory RadioAllNews.fromJson(json) => _$RadioAllNewsFromJson(json);
}
