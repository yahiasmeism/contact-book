import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  const StatusText({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.black12;
    Color textColor = Colors.black;
    switch (status) {
      case 'Active':
        backgroundColor = const Color(0xffD4EDDA);
        textColor = const Color(0xff155724);
        break;
      case 'Pending':
        backgroundColor = const Color(0xffFFF3CD);
        textColor = const Color(0xff856404);
        break;
      case 'Locked':
        backgroundColor = const Color(0xffF8D7DA);
        textColor = const Color(0xff721C24);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
