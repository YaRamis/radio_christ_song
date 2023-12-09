import 'package:json_annotation/json_annotation.dart';
import 'package:radio_christ_song/domain/entities/radio_order_tracks/track_order.dart';
part 'radio_order_tracks.g.dart';

@JsonSerializable()
class RadioOrderTracks {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<TrackOrder> tracks;

  RadioOrderTracks({
    required this.count,
    required this.next,
    required this.previous,
    required this.tracks,
  });

  factory RadioOrderTracks.fromJson(json) => _$RadioOrderTracksFromJson(json);
}
