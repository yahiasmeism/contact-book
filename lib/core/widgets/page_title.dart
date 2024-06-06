import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.pageTitle,
  });
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                child: const Text('Home'),
                onPressed: () {
                  Navigator.of(context).popUntil(
                    (route) => route.isFirst,
                  );
                },
              ),
              const Text(
                '/ Company Porfile',
                style: STYLES.TEXT_STYLE_18,
              ),
              const Divider(
                height: 0,
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }
}
