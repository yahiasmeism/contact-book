import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/contacts_repository.dart';

class GetImageUrlUseCase {
  final ContactsRepository contactsRepository;

  GetImageUrlUseCase({required this.contactsRepository});
  Future<Either<Failure, String>> call({required int id}) {
    return contactsRepository.getImageUrl(id: id);
  }
}
