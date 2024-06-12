import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';
import '../utils/my_routes_observer.dart';

class BreadCrumbNavigator extends StatelessWidget {
  const BreadCrumbNavigator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Row(
              children: routeStack.map(
            (currentRoute) {
              final currentPage = currentRoute?.settings.name;
              return GestureDetector(
                onTap: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(currentPage ?? ''),
                  );
                },
                child: Text(
                  '$currentPage ${(currentPage == routeStack.last?.settings.name ? '' : '/')} ',
                  style: STYLES.TEXT_STYLE_18,
                ),
              );
            },
          ).toList()),
          const Divider(
            height: 10,
            thickness: 1,
            color: Color(0xff868686),
          ),
        ],
      ),
    );
  }
}
