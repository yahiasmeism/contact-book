part of 'send_email_cubit.dart';

sealed class SendEmailState extends Equatable {
  const SendEmailState();

  @override
  List<Object> get props => [];
}

final class SendEmailInitial extends SendEmailState {}

final class SendEmailLoading extends SendEmailState {}

final class SendEmailSuccess extends SendEmailState {
  final String message;

  const SendEmailSuccess({required this.message});
}

final class SendEmailFilure extends SendEmailState {
    final String message;

  const SendEmailFilure({required this.message});
}
