import 'dart:io';
import 'package:contact_book/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/bread_crumb.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../../../core/widgets/footer_app.dart';
import '../../domain/entities/contact_entity.dart';
import '../bloc/contacts_bloc.dart';
import 'contact_details_form.dart';
import 'upload_new_image.dart';

class CreateNewContactBody extends StatefulWidget {
  const CreateNewContactBody({super.key});
  @override
  State<CreateNewContactBody> createState() => _CreateNewContactBodyState();
}

class _CreateNewContactBodyState extends State<CreateNewContactBody> {
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
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    email2Controller = TextEditingController();
    phoneController = TextEditingController();
    mobileController = TextEditingController();
    addressController = TextEditingController();
    address2Controller = TextEditingController();
    super.initState();
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
                        UploadNewImage(
                          initialImage: imageFile,
                          onUploadNewImage: (image) {
                            imageFile = image;
                          },
                        ),
                        const SizedBox(height: 24),
                        ContactDetailsForm(
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
                        _buildSaveButton(context),
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
    final company = context.read<CompanyBloc>().company;
    return CustomButton(
        child: const Text('Save'),
        onPressed: () {
          final contact = ContactEntity(
            imageUploadFile: imageFile,
            firstName: fNameController.text,
            lastName: lNameController.text,
            email: emailController.text,
            emailTwo: email2Controller.text,
            phoneNumber: phoneController.text,
            mobileNumber: mobileController.text,
            address: addressController.text,
            addressTwo: address2Controller.text,
            companyId: company?.id,
            company: company,
          );

          if (formKey.currentState?.validate() == true) {
            Navigator.pop(context);
            context
                .read<ContactsBloc>()
                .add(CreateNewContactEvent(contact: contact));
          }
        });
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
