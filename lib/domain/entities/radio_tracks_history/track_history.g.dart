// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackHistory _$TrackHistoryFromJson(Map<String, dynamic> json) => TrackHistory(
      id: json['id'] as int,
      allMusicId: json['all_music_id'] as int,
      imageUrl: json['img_url'] as String?,
      imageMediumUrl: json['img_medium_url'] as String?,
      imageLargeUrl: json['img_large_url'] as String?,
      metadata: json['metadata'] as String,
      author: json['author'] as String,
      title: json['title'] as String,
      playlistTitle: json['playlist_title'] as String,
      djName: json['dj_name'] as String,
      album: json['album'] as String,
    );

Map<String, dynamic> _$TrackHistoryToJson(TrackHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'all_music_id': instance.id,
      'img_url': instance.imageUrl,
      'img_medium_url': instance.imageMediumUrl,
      'img_large_url': instance.imageLargeUrl,
      'metadata': instance.metadata,
      'author': instance.author,
      'title': instance.title,
      'playlist_title': instance.playlistTitle,
      'dj_name': instance.djName,
      'album': instance.album,
    };
