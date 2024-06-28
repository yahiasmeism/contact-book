import 'package:contact_book/core/widgets/custom_fading_widget.dart';
import 'package:flutter/material.dart';

class ActivitiesFadingLoadingIndecator extends StatelessWidget {
  const ActivitiesFadingLoadingIndecator({super.key, required this.itemCount});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: ListView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFadingWidget(
                          child: Container(
                            height: 25,
                            width: 150,
                            color: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomFadingWidget(
                          child: Container(
                            height: 15,
                            width: 100,
                            color: Colors.grey[200],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomFadingWidget(
                        child: Container(
                          height: 20,
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomFadingWidget(
                        child: Container(
                          height: 20,
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
