part of 'contact_image_cubit.dart';

sealed class ContactImageState extends Equatable {
  const ContactImageState();

  @override
  List<Object> get props => [];
}

final class ContactImageInitial extends ContactImageState {}

final class ContactImageLoading extends ContactImageState {}

final class ContactImageLoaded extends ContactImageState {}
