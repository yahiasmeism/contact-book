import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        Divider(
          color: Colors.black.withOpacity(0.3),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Copyright © ITM Development | Contact Book | ${DateTime.now().year}',
            style: const TextStyle(fontSize: 13),
          ),
        )
      ],
    );
  }
}
