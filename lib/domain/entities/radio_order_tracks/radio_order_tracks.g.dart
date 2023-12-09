// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_order_tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioOrderTracks _$RadioOrderTracksFromJson(Map<String, dynamic> json) =>
    RadioOrderTracks(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      tracks: (json['results'] as List<dynamic>)
          .map((e) => TrackOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RadioOrderTracksToJson(RadioOrderTracks instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.tracks,
    };
