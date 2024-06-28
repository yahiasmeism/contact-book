part of 'contacts_bloc.dart';

sealed class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {}

class ContactsFailure extends ContactsState {
  final String message;

  const ContactsFailure({required this.message});
}

class UserOperationSuccess extends ContactsState {
  final String message;

  const UserOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class OnFilterContactsState extends ContactsState {
  final List<ContactEntity> contactsFilter;

  const OnFilterContactsState({required this.contactsFilter});

  @override
  List<Object> get props => [contactsFilter];
}


