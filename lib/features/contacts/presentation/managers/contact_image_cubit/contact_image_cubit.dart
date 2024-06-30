import 'package:bloc/bloc.dart';
import 'package:contact_book/core/helpers/image_cache_manager.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/domain/use_cases/get_contact_image_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'contact_image_state.dart';

class ContactImageCubit extends Cubit<ContactImageState> {
  final GetContactImageUseCase getContactImageUseCase;
  ContactImageCubit(
      {required this.getContactImageUseCase})
      : super(ContactImageInitial());

  loadImage({required ContactEntity contact}) async {
    final key = contact.id.toString();
    final image = ImageCacheManager.getImage(key);
    if (image != null) {
      emit(ContactImageLoaded(image: image));
    } else {
      if (!isClosed) emit(ContactImageLoading());
      final imageResult = await getContactImageUseCase(contact: contact);
      imageResult.fold(
        (failure) {
          if (!isClosed) emit(ContactImageFailure());
        },
        (image) {
          ImageCacheManager.cacheImage(image, key);
          if (!isClosed) emit(ContactImageLoaded(image: image));
        },
      );
    }
  }
}
