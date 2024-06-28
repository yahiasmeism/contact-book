import 'package:contact_book/core/constants/enums.dart';
import 'package:contact_book/features/home/persintation/widgets/statistical_card.dart';
import 'package:flutter/material.dart';

class StatisticsItems extends StatelessWidget {
  const StatisticsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        StatisticalCard(color: Color(0xff1ABC9C)),
        SizedBox(height: 32),
        StatisticalCard(
          color: Color(0xffFC766A),
          direction: ArrowDirection.bottom,
        ),
        SizedBox(
          height: 32,
        ),
        StatisticalCard(
          color: Color(0xff2B3D4F),
          direction: ArrowDirection.bottom,
        ),
        SizedBox(height: 32),
        StatisticalCard(
          color: Color(0xff5B84B1),
          direction: ArrowDirection.bottom,
        ),
      ],
    );
  }
}
