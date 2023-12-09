// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackOrder _$TrackOrderFromJson(Map<String, dynamic> json) => TrackOrder(
      id: json['id'] as int,
      imgUrl: json['tag_image'] as String?,
      imgMediumUrl: json['image_medium'] as String?,
      imgLargeUrl: json['image_large'] as String?,
      metadata: json['metadata'] as String?,
      author: json['author'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$TrackOrderToJson(TrackOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img_url': instance.imgUrl,
      'img_medium_url': instance.imgMediumUrl,
      'img_large_url': instance.imgLargeUrl,
      'metadata': instance.metadata,
      'author': instance.author,
      'title': instance.title,
    };
