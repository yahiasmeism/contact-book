import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';

class SendEmailModel extends SendEmailEntity {
  SendEmailModel(
      {required super.to,
      required super.cc,
      required super.bcc,
      required super.subject,
      required super.body});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "to": to,
      "cc": cc,
      "bcc": bcc,
      "subject": subject,
      "body": body,
    };
  }

  factory SendEmailModel.fromEntity(SendEmailEntity entity) {
    return SendEmailModel(
      to: entity.to,
      cc: entity.cc,
      bcc: entity.bcc,
      subject: entity.subject,
      body: entity.body,
    );
  }
}
