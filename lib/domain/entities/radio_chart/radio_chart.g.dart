// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioChartTrack _$RadioChartTrackFromJson(Map<String, dynamic> json) =>
    RadioChartTrack(
      id: json['id'] as int,
      filename: json['filename'] as String?,
      meta: json['meta'] as String?,
      rating: json['rating'] as int,
      publicPath: json['public_path'] as String?,
      path: json['path'] as String?,
      author: json['author'] as String,
      title: json['title'] as String,
      album: json['album'] as String?,
      thumbsUp: json['human_up'] as int,
      thumbsDown: json['human_down'] as int,
      tagImage: (json['tag_image'] as String?) == null
          ? null
          : 'https://pu.xpradio.ru:1030 ${json['tag_image']}',
      imageMedium: (json['image_medium'] as String?) == null
          ? null
          : 'https://pu.xpradio.ru:1030 ${json['image_medium']}',
      imageLarge: (json['image_large'] as String?) == null
          ? null
          : 'https://pu.xpradio.ru:1030 ${json['image_large']}',
    );

Map<String, dynamic> _$RadioChartTrackToJson(RadioChartTrack instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'meta': instance.meta,
      'rating': instance.rating,
      'public_path': instance.publicPath,
      'path': instance.path,
      'author': instance.author,
      'title': instance.title,
      'album': instance.album,
      'human_up': instance.thumbsUp,
      'human_down': instance.thumbsDown,
      'tag_image': instance.tagImage,
      'image_medium': instance.imageMedium,
      'image_large': instance.imageLarge,
    };
