class SendEmailEntity {
  final String to;
  final String cc;
  final String bcc;
  final String subject;
  final String body;

  SendEmailEntity(
      {required this.to,
      required this.cc,
      required this.bcc,
      required this.subject,
      required this.body});
}
