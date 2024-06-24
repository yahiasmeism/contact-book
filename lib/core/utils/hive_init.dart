import '../../features/users/domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/company/domain/entities/company_entity.dart';
import '../constants/constant.dart';

Future<void> hiveInit() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  await Hive.openBox(APP_BOX);
}
