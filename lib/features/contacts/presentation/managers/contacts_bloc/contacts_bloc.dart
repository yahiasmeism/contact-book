import 'package:bloc/bloc.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:contact_book/features/contacts/domain/use_cases/get_all_contacts_use_case.dart';

import '../../../../../core/constants/messages.dart';
import '../../../domain/use_cases/create_contact_use_case.dart';
import '../../../domain/use_cases/delete_contacts_use_case.dart';
import '../../../domain/use_cases/toggle_favorite_use_case.dart';
import '../../../domain/use_cases/update_contact_use_case.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final CreateContactUseCase createContactUseCase;
  final DeleteContactsUseCase deleteContactsUseCase;
  final GetAllContactsUseCase getAllContactsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final UpdateContactUseCase updateContactUseCase;

  List<ContactEntity> contacts = [];
  List<ContactEntity> contactsSelected = [];
  ContactsBloc({
    required this.toggleFavoriteUseCase,
    required this.createContactUseCase,
    required this.deleteContactsUseCase,
    required this.getAllContactsUseCase,
    required this.updateContactUseCase,
  }) : super(ContactsInitial()) {
    // get all Contacts
    on<GetAllContactsEvent>((event, emit) async {
      emit(ContactsLoading());
      final either = await getAllContactsUseCase();
      either.fold((failure) => emit(ContactsFailure(message: failure.message)),
          (contacts) {
        this.contacts = contacts;
        contactsSelected.clear();
        emit(ContactsLoaded());
      });
    });

    // search contact
    on<SearchContactsEvent>((event, emit) {
      List<ContactEntity> contactsFilter = contacts.where(
        (user) {
          return ("${user.firstName} ${user.lastName}")
                  .startsWith(event.query.trim()) |
              user.lastName.startsWith(event.query.trim()) |
              user.email.contains(event.query.trim()) |
              user.phoneNumber.contains(event.query.trim());
        },
      ).toList();
      emit(OnFilterContactsState(contactsFilter: contactsFilter));
    });

    // undo search
    on<UndoSearchContactsEvent>((event, emit) {
      emit(ContactsLoaded());
    });

    // delete user
    on<DeleteContactsEvent>((event, emit) async {
      emit(ContactsLoading());
      final Either either =
          await deleteContactsUseCase(contacts: contactsSelected);
      either.fold((failure) => emit(ContactsFailure(message: failure.message)),
          (success) {
        contacts.removeWhere((contact) => contactsSelected.contains(contact));
        emit(const UserOperationSuccess(message: MESSAGES.DELETE_SUCCESS));
      });
      contactsSelected.clear();
    });

    // create new contact
    on<CreateNewContactEvent>((event, emit) async {
      emit(ContactsLoading());
      final result = await createContactUseCase(contact: event.contact);
      result.fold(
        (fialure) => emit(ContactsFailure(message: fialure.message)),
        (userAdded) {
          contacts.add(userAdded);
          emit(ContactsLoaded());
          emit(
            const UserOperationSuccess(message: MESSAGES.ADDED_SUCCESSFULY),
          );
        },
      );
    });
    //  update contact
    on<UpdateContactEvent>((event, emit) async {
      emit(ContactsLoading());
      final result = await updateContactUseCase(contact: event.contact);
      result.fold(
        (fialure) => emit(ContactsFailure(message: fialure.message)),
        (contactUpdated) {
          final index = contacts.indexWhere((c) => c.id == event.contact.id);
          contacts[index] = contactUpdated;
          emit(ContactsLoaded());
          emit(
            const UserOperationSuccess(message: MESSAGES.UPDATED_SUCCESS),
          );
        },
      );
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      final either = await toggleFavoriteUseCase(contact: event.contact);
      either.fold(
        (failure) {
          emit(ContactsFailure(message: failure.message));
        },
        (contactUpdated) {
          final index = contacts.indexOf(event.contact);
          contacts[index].isFavorite = contactUpdated.isFavorite;
          emit(ContactsLoaded());
        },
      );
    });

  }
}
