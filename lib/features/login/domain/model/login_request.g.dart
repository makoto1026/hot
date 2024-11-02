// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      displayName: json['displayName'] as String,
      thumbnail: json['thumbnail'] as String,
      snsUrl: json['snsUrl'] as String,
      product: json['product'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'thumbnail': instance.thumbnail,
      'snsUrl': instance.snsUrl,
      'product': instance.product,
    };
