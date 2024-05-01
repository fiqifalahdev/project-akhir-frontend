import 'package:freezed_annotation/freezed_annotation.dart';

part 'feeds.freezed.dart';
part 'feeds.g.dart';

@freezed
class Feed with _$Feed {
  const factory Feed(
      {int? id,
      required String caption,
      required String image,
      int? user_id,
      String? created_at}) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
