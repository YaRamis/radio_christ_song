import 'package:json_annotation/json_annotation.dart';
part 'track_history.g.dart';

@JsonSerializable()
class TrackHistory {
  final int id;
  @JsonKey(name: 'all_music_id')
  final int allMusicId;
  @JsonKey(name: 'img_url')
  final String? imageUrl;
  @JsonKey(name: 'img_medium_url')
  final String? imageMediumUrl;
  @JsonKey(name: 'img_large_url')
  final String? imageLargeUrl;
  final String metadata;
  final String author;
  final String title;
  @JsonKey(name: 'playlist_title')
  final String playlistTitle;
  @JsonKey(name: 'dj_name')
  final String djName;
  final String album;

  TrackHistory({
    required this.id,
    required this.allMusicId,
    required this.imageUrl,
    required this.imageMediumUrl,
    required this.imageLargeUrl,
    required this.metadata,
    required this.author,
    required this.title,
    required this.playlistTitle,
    required this.djName,
    required this.album,
  });

  factory TrackHistory.fromJson(json) => _$TrackHistoryFromJson(json);
}
