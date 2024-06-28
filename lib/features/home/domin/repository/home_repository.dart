import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/home/domin/entities/activity_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<ActivityEntity>>> getAcitvities();
}
