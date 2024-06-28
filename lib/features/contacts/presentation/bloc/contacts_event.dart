part of 'contacts_bloc.dart';

sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class CreateNewContactEvent extends ContactsEvent {
  final ContactEntity contact;

  const CreateNewContactEvent({required this.contact});
}

class DeleteContactsEvent extends ContactsEvent {}

class GetAllContactsEvent extends ContactsEvent {}

class GetImageEvent extends ContactsEvent {
  final ContactEntity contact;

  const GetImageEvent({required this.contact});
}

class ToggleFavoriteEvent extends ContactsEvent {
  final ContactEntity contact;

  const ToggleFavoriteEvent({required this.contact});
}

class UpdateContactEvent extends ContactsEvent {
  final ContactEntity contact;

  const UpdateContactEvent({required this.contact});
}

class SearchContactsEvent extends ContactsEvent {
  final String query;

  const SearchContactsEvent({required this.query});
}

class UndoSearchContactsEvent extends ContactsEvent {}
