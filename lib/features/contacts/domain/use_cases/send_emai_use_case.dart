import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';
import 'package:contact_book/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';

class SendEmaiUseCase {
  final ContactsRepository contactsRepository;

  SendEmaiUseCase({required this.contactsRepository});

  Future<Either<Failure, Unit>> call(SendEmailEntity sendEmailEntity) {
    return contactsRepository.sendEmail(sendEmailEntity: sendEmailEntity);
  }
}
