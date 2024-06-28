import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/home/domin/entities/activity_entity.dart';

import '../../features/users/domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/company/domain/entities/company_entity.dart';
import '../constants/constant.dart';

Future<void> hiveInit() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(ContactEntityAdapter());
  Hive.registerAdapter(ActivityEntityAdapter());
  await Hive.openBox(APP_BOX);
}
