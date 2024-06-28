import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/domain/use_cases/get_contact_image_use_case.dart';
import 'package:equatable/equatable.dart';

part 'contact_image_state.dart';

class ContactImageCubit extends Cubit<ContactImageState> {
  final GetContactImageUseCase getContactImageUseCase;
  ContactImageCubit({required this.getContactImageUseCase})
      : super(ContactImageInitial());
  Uint8List? image;

  getContactImage({required ContactEntity contact}) async {
    emit(ContactImageLoading());

    final imageResult = await getContactImageUseCase(contact: contact);
    imageResult.fold(
      (failure) {
        log(failure.message);
      },
      (image) {
        this.image = image;
        emit(ContactImageLoaded());
      },
    );
  }
}
