// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_tracks_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioTracksHistory _$RadioTracksHistoryFromJson(Map<String, dynamic> json) =>
    RadioTracksHistory(
      tracks: (json['results'] as List<dynamic>)
          .map((e) => TrackHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$RadioTracksHistoryToJson(RadioTracksHistory instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.tracks,
    };
