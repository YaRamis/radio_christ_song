// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_djs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioDj _$RadioDjFromJson(Map<String, dynamic> json) => RadioDj(
      id: json['id'] as int,
      imageThumbnail: json['image_thumbnail'] as String,
      imageMedium: json['image_medium'] as String,
      name: json['name'] as String,
      metadata: json['metadata'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$RadioDjToJson(RadioDj instance) => <String, dynamic>{
      'id': instance.id,
      'image_thumbnail': instance.imageThumbnail,
      'image_medium': instance.imageMedium,
      'name': instance.name,
      'metadata': instance.metadata,
      'image': instance.image,
    };
