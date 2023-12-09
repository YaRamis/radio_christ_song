import 'package:json_annotation/json_annotation.dart';
import 'package:radio_christ_song/domain/entities/radio_tracks_history/track_history.dart';
part 'radio_tracks_history.g.dart';

@JsonSerializable()
class RadioTracksHistory {
  final int count;
  @JsonKey(name: 'results')
  final List<TrackHistory> tracks;

  RadioTracksHistory({
    required this.tracks,
    required this.count,
  });

  factory RadioTracksHistory.fromJson(json) =>
      _$RadioTracksHistoryFromJson(json);
}
