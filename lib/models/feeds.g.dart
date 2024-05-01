// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedImpl _$$FeedImplFromJson(Map<String, dynamic> json) => _$FeedImpl(
      id: json['id'] as int?,
      caption: json['caption'] as String,
      image: json['image'] as String,
      user_id: json['user_id'] as int?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$$FeedImplToJson(_$FeedImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'image': instance.image,
      'user_id': instance.user_id,
      'created_at': instance.created_at,
    };
