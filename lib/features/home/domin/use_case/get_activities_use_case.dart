import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/home/domin/entities/activity_entity.dart';
import 'package:contact_book/features/home/domin/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetActivitiesUseCase {
  final HomeRepository homeRepository;

  GetActivitiesUseCase({required this.homeRepository});
  Future<Either<Failure, List<ActivityEntity>>> call() {
    return homeRepository.getAcitvities();
  }
}
