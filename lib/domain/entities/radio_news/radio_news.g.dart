// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioNews _$RadioNewsFromJson(Map<String, dynamic> json) => RadioNews(
      id: json['id'] as int,
      datetime: json['dttm'] as int,
      imageUrl: json['image'] as String,
      videoUrl: json['video_url'] as String,
      title: json['title'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$RadioNewsToJson(RadioNews instance) => <String, dynamic>{
      'id': instance.id,
      'dttm': instance.datetime,
      'image': instance.imageUrl,
      'video_url': instance.videoUrl,
      'title': instance.title,
      'text': instance.text,
    };
