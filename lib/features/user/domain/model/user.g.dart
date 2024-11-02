// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      displayName: json['display_name'] as String,
      thumbnail: json['thumbnail'] as String,
      snsUrl: json['sns_url'] as String,
      product: json['product'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'thumbnail': instance.thumbnail,
      'sns_url': instance.snsUrl,
      'product': instance.product,
    };
