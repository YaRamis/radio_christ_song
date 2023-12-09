// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_all_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioAllNews _$RadioAllNewsFromJson(Map<String, dynamic> json) => RadioAllNews(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      allNews:
          (json['results'] as List<dynamic>).map(RadioNews.fromJson).toList(),
    );

Map<String, dynamic> _$RadioAllNewsToJson(RadioAllNews instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.allNews,
    };
