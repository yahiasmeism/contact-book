import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/country_drop_down_menu.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_outline_button.dart';

import '../../domain/entities/login.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/register_cubit/register_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_fields/custom_email_form_field.dart';
import '../../../../core/widgets/custom_fields/custom_password_form_field.dart';
import '../../../../core/widgets/custom_fields/custom_text_form_field.dart';
import '../../domain/entities/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final vatNumberController = TextEditingController();
  final streetOneController = TextEditingController();
  final streetTwoController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            //
            if (state is RegisterFailure) {
              Fluttertoast.showToast(msg: state.message);
            } else if (state is RegisterSuccess) {
              //
              // If registration is successful, go to login
              context.read<LoginCubit>().loginSubmit(
                    login: LoginEntity(
                        email: emailController.text,
                        password: passwordController.text),
                  );
              // Navigator.pushReplacementNamed(context, HomePage.id);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is RegisterLoading,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 36,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Details',
                          style: STYLES.TEXT_STYLE_18
                              .copyWith(color: Colors.black.withOpacity(0.6)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32),
                            Expanded(
                              child: CustomTextFromField(
                                isRequired: true,
                                labelText: 'First name',
                                controller: firstNameController,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomTextFromField(
                                labelText: 'Last name',
                                controller: lastNameController,
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        CustomEmailFormField(
                          controller: emailController,
                        ),
                        const SizedBox(height: 32),
                        CustomPasswordFormField(
                          controller: passwordController,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Billing details',
                          style: STYLES.TEXT_STYLE_18
                              .copyWith(color: Colors.black.withOpacity(0.6)),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFromField(
                          isRequired: true,
                          labelText: 'Company',
                          controller: companyNameController,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          isRequired: true,
                          keyboardType: TextInputType.number,
                          labelText: 'Vat number',
                          controller: vatNumberController,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          isRequired: true,
                          labelText: 'Street Address 1',
                          controller: streetOneController,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          labelText: 'Street Address 2',
                          controller: streetTwoController,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          labelText: 'City',
                          controller: cityController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          labelText: 'State',
                          controller: stateController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 32),

                        CustomTextFromField(
                          labelText: 'Zip code',
                          keyboardType: TextInputType.number,
                          controller: zipController,
                          isRequired: true,
                        ),
                        const SizedBox(height: 32),

                        //  7) ==============> Phone Number
                        CustomTextFromField(
                          isRequired: true,
                          labelText: 'Phone',
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 32),
                        CountryDropDownMenu(
                          countryController: countryController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CustomCheckBox(
                        onChange: (value) {},
                      ),
                      const SizedBox(
                        width: 200,
                        child: Text(
                          'I agree to the website terms end conditions',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomOutlineButton(
                    child: const Text('Back'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    isLoading: state is RegisterLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final registerEntity = RegisterEntity(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                            companyName: companyNameController.text,
                            vatNumber: vatNumberController.text,
                            streetOne: streetOneController.text,
                            streetTwo: streetTwoController.text,
                            city: cityController.text,
                            state: stateController.text,
                            zip: zipController.text,
                            country: countryController.text);

                        context
                            .read<RegisterCubit>()
                            .registerSubmit(registerEntity: registerEntity);
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: COLORS.PRIMARY),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign in instead')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    companyNameController.dispose();
    vatNumberController.dispose();
    streetOneController.dispose();
    streetTwoController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
