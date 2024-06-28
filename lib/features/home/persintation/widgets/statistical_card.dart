import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';

class StatisticalCard extends StatelessWidget {
  const StatisticalCard({
    super.key,
    this.color = Colors.blueAccent,
    this.direction = ArrowDirection.top,
  });
  final Color color;
  final ArrowDirection direction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '101',
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white.withOpacity(0.5)),
                child: builIcondDirectionArrow(),
              )
            ],
          ),
          Text(
            'Active',
            style:
                TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.5)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.white.withOpacity(0.5)),
              const SizedBox(width: 12),
              Text(
                '3% from last month',
                style: TextStyle(
                    fontSize: 18, color: Colors.white.withOpacity(0.5)),
              )
            ],
          )
        ],
      ),
    );
  }

  Icon builIcondDirectionArrow() {
    final IconData iconData;
    switch (direction) {
      case ArrowDirection.top:
        iconData = Icons.arrow_upward;
        break;
      case ArrowDirection.bottom:
        iconData = Icons.arrow_downward;
        break;
      case ArrowDirection.left:
        iconData = Icons.arrow_back;
        break;
      case ArrowDirection.right:
        iconData = Icons.arrow_forward;
        break;
    }

    return Icon(iconData, color: color, size: 44);
  }
}
