import 'package:flutter/cupertino.dart';

class BadgeInfo extends StatefulWidget {
  final String content;
  final Color color;
  final TextStyle style;
  final Icon? icon;

  const BadgeInfo(
      {super.key,
      required this.content,
      required this.color,
      required this.style,
      this.icon});

  @override
  State<BadgeInfo> createState() => _BadgeInfoState();
}

class _BadgeInfoState extends State<BadgeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.icon == null
            ? Text(
                widget.content,
                style: widget.style,
              )
            : Row(
                children: [
                  widget.icon == null ? const SizedBox() : widget.icon!,
                  const SizedBox(width: 5),
                  Text(
                    widget.content,
                    style: widget.style,
                  ),
                ],
              ));
  }
}


