// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      sampleId: json['sampleId'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      snsUrl: json['snsUrl'] as String,
      product: json['product'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'sampleId': instance.sampleId,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'snsUrl': instance.snsUrl,
      'product': instance.product,
    };
