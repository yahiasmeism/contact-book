import '../../../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomPagenation extends StatelessWidget {
  const CustomPagenation(
      {super.key,
      required this.totalPages,
      required this.currentPage,
      this.onPageChange});
  final int totalPages;
  final int currentPage;
  final Function(int pageNumber)? onPageChange;
  @override
  Widget build(BuildContext context) {
    if (totalPages > 1) {
      return NumberPaginator(
        config: NumberPaginatorUIConfig(
          buttonUnselectedForegroundColor: Colors.black,
          buttonSelectedBackgroundColor: COLORS.PRIMARY,
          buttonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: COLORS.BORDER),
          ),
        ),
        numberPages: totalPages,
        initialPage: currentPage,
        onPageChange: onPageChange,
      );
    } else {
      return const SizedBox();
    }
  }
}
