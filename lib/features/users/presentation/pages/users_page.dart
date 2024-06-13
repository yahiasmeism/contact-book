import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/users_body.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  static const name = 'Users';
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: UsersBody(),
    );
  }
}
