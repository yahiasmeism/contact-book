import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/core/widgets/custom_fields/custom_email_form_field.dart';
import 'package:contact_book/core/widgets/custom_outline_button.dart';
import 'package:contact_book/core/widgets/custom_fields/custom_text_form_field.dart';
import 'package:contact_book/core/widgets/footer_app.dart';
import 'package:contact_book/core/widgets/snackbar_global.dart';
import 'package:contact_book/features/contacts/domain/entities/send_email_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/bread_crumb.dart';
import '../managers/send_email_cubit/send_email_cubit.dart';

class SendEmailPage extends StatelessWidget {
  const SendEmailPage({super.key});
  static const name = 'Send Email';
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final toController = TextEditingController();
    final ccController = TextEditingController();
    final bccController = TextEditingController();
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    return AppScaffold(
      body: BlocListener<SendEmailCubit, SendEmailState>(
        listener: (context, state) {
          if (state is SendEmailFilure) {
            SnackBarGlobal.show(context, state.message, color: Colors.red);
          } else if (state is SendEmailSuccess) {
            SnackBarGlobal.show(context, state.message, color: Colors.green);
          }
        },
        child: Padding(
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Send Email',
                                      style: STYLES.TEXT_STYLE_18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              CustomEmailFormField(
                                controller: toController,
                                isRequired: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'contact@example.com',
                                labelText: 'To',
                              ),
                              const SizedBox(height: 32),
                              CustomEmailFormField(
                                isRequired: false,
                                controller: ccController,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'cc@example.com',
                                labelText: 'cc',
                              ),
                              const SizedBox(height: 32),
                              CustomEmailFormField(
                                isRequired: false,
                                controller: bccController,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'bcc@example.com',
                                labelText: 'bcc',
                              ),
                              const SizedBox(height: 32),
                              CustomTextFromField(
                                controller: subjectController,
                                isRequired: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Subject',
                                hintText: 'anything.....',
                              ),
                              const SizedBox(height: 32),
                              CustomTextFromField(
                                controller: messageController,
                                isRequired: true,
                                maxLines: 3,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'Message',
                              ),
                              const SizedBox(height: 32),
                              CustomButton(
                                child: const Text('Send'),
                                onPressed: () {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    context.read<SendEmailCubit>().sendEmail(
                                          SendEmailEntity(
                                            to: toController.text,
                                            cc: ccController.text,
                                            bcc: bccController.text,
                                            subject: subjectController.text,
                                            body: messageController.text,
                                          ),
                                        );
                                    Navigator.pop(context);
                                  }
                                },
                              ),
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
                      ),
                      const Footer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




/* 
{
  "to": "example@example.com",
  "cc": "cc@example.com",
  "bcc": "bcc@example.com",
  "subject": "استفسار عن الخدمة",
  "body": "السلام عليكم،\n\nأود الاستفسار عن الخدمة المقدمة من شركتكم. لدي بعض الأسئلة حول كيفية التسجيل والاشتراك. الرجاء تزويدي بالمزيد من التفاصيل.\n\nشكرًا لكم،\n\nأحمد علي"
}

 */