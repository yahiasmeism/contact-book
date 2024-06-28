import 'dart:developer';
import 'dart:io';
import 'package:contact_book/core/utils/file_converter.dart';
import 'package:contact_book/features/contacts/presentation/managers/contact_image_cubit/contact_image_cubit.dart';
import 'package:contact_book/features/contacts/presentation/widgets/contact_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/widgets/bread_crumb.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_outline_button.dart';
import '../../../../../core/widgets/footer_app.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../managers/contacts_bloc/contacts_bloc.dart';
import 'contact_details_form.dart';
import '../create new contact/upload_new_image.dart';

class ContactDetailsBody extends StatefulWidget {
  const ContactDetailsBody({super.key, required this.contact});
  final ContactEntity contact;
  @override
  State<ContactDetailsBody> createState() => _ContactDetailsBodyState();
}

class _ContactDetailsBodyState extends State<ContactDetailsBody> {
  bool enabled = false;
  late GlobalKey<FormState> formKey;
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController email2Controller;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController address2Controller;
  File? imageFile;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    fNameController = TextEditingController(text: widget.contact.firstName);
    lNameController = TextEditingController(text: widget.contact.lastName);
    emailController = TextEditingController(text: widget.contact.email);
    email2Controller = TextEditingController(text: widget.contact.emailTwo);
    phoneController = TextEditingController(text: widget.contact.phoneNumber);
    mobileController = TextEditingController(text: widget.contact.mobileNumber);
    addressController = TextEditingController(text: widget.contact.address);
    address2Controller = TextEditingController(text: widget.contact.addressTwo);
    initialImage();
    super.initState();
  }

  initialImage() async {
    final imageBytes = context.read<ContactImageCubit>().image;
    if (imageBytes != null) {
      imageFile = await FileConverter.unit8ListToFile(imageBytes);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  const BreadCrumbNavigator(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Contact Details',
                                style: STYLES.TEXT_STYLE_18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        enabled
                            ? UploadNewImage(
                                initialImage: imageFile,
                                onUploadNewImage: (image) {
                                  imageFile = image;
                                },
                              )
                            : Column(
                                children: [
                                  ContactImage(
                                    radius: 60,
                                    contact: widget.contact,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${widget.contact.firstName} ${widget.contact.lastName}',
                                    style: STYLES.TEXT_STYLE_20,
                                  ),
                                ],
                              ),
                        const SizedBox(height: 24),
                        ContactDetailsForm(
                          enabled: enabled,
                          formKey: formKey,
                          fNameController: fNameController,
                          lNameController: lNameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          email2Controller: email2Controller,
                          mobileController: mobileController,
                          addressController: addressController,
                          address2Controller: address2Controller,
                        ),
                        const SizedBox(height: 32),
                        enabled
                            ? _buildSaveButton(context)
                            : _buildEditButton(context),
                        const SizedBox(height: 24),
                        CustomOutlineButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const Footer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CustomButton(
        child: const Text('Save'),
        onPressed: () {
          final contact = ContactEntity(
            id: widget.contact.id,
            status: widget.contact.status,
            imageUploadFile: imageFile,
            firstName: fNameController.text,
            lastName: lNameController.text,
            email: emailController.text,
            emailTwo: email2Controller.text,
            phoneNumber: phoneController.text,
            mobileNumber: mobileController.text,
            address: addressController.text,
            addressTwo: address2Controller.text,
            companyId: widget.contact.companyId,
            company: widget.contact.company,
          );

          log(contact.toString());
          if (formKey.currentState?.validate() == true) {
            Navigator.pop(context);
            context
                .read<ContactsBloc>()
                .add(UpdateContactEvent(contact: contact));
          }
        });
  }

  Widget _buildEditButton(BuildContext context) {
    return CustomButton(
      child: const Text('Edit'),
      onPressed: () {
        setState(() {
          enabled = true;
        });
      },
    );
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    email2Controller.dispose();
    phoneController.dispose();
    mobileController.dispose();
    addressController.dispose();
    address2Controller.dispose();
    super.dispose();
  }
}
