import 'package:freezed_annotation/freezed_annotation.dart';

part 'feeds.freezed.dart';
part 'feeds.g.dart';

@freezed
class Feed with _$Feed {
  const factory Feed({
    required String caption,
    required String image,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
