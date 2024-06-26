import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';

class TimeOptionButton extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onSelected;

  const TimeOptionButton({
    Key? key,
    required this.time,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: onSelected,
        style: isSelected
            ? ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(CustomColors.primary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            : CustomColors.outlinedButtonStyle,
        child: Text(
          time,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
