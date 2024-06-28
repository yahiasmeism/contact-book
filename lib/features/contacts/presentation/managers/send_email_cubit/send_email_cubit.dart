import 'package:bloc/bloc.dart';
import 'package:contact_book/core/constants/messages.dart';
import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';
import 'package:contact_book/features/contacts/domain/use_cases/send_emai_use_case.dart';
import 'package:equatable/equatable.dart';

part 'send_email_state.dart';

class SendEmailCubit extends Cubit<SendEmailState> {
  final SendEmaiUseCase sendEmaiUseCase;
  SendEmailCubit({required this.sendEmaiUseCase}) : super(SendEmailInitial());

  sendEmail(SendEmailEntity senEmailEntity) async {
    emit(SendEmailLoading());
    final either = await sendEmaiUseCase(senEmailEntity);
    either.fold(
        (failure) => emit(SendEmailFilure(message: failure.message)),
        (success) =>
            emit(const SendEmailSuccess(message: MESSAGES.SEND_EMAIL_SUCCCES)));
  }
}
