import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/core/widgets/custom_outline_button.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/widgets/user_details_form_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});
  static const name = 'user details';

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UserEntity? user;
  final formKey = GlobalKey<FormState>();
  bool? unloacked;
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController roleController;
  late UserDetailsMode mode;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty text initially
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    roleController = TextEditingController();
    mode = UserDetailsMode.show;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if controllers are already initialized
    if (user == null) {
      // Get user from route
      user = ModalRoute.of(context)?.settings.arguments as UserEntity?;

      fNameController = TextEditingController(text: user?.firstName);
      lNameController = TextEditingController(text: user?.lastName);
      emailController = TextEditingController(text: user?.email);
      phoneController = TextEditingController(text: user?.phoneNumber);
      roleController = TextEditingController(text: user?.role);
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const BreadCrumbNavigator(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      UserDetailsForm(
                        enabled: mode == UserDetailsMode.edit,
                        formKey: formKey,
                        fNameController: fNameController,
                        lNameController: lNameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        roleController: roleController,
                      ),
                      const SizedBox(height: 32),
                      mode == UserDetailsMode.edit
                          ? builSaveButton()
                          : builEditButton(),
                      const SizedBox(height: 32),
                      buildBackButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builEditButton() {
    return CustomButton(
      child: const Text('Edit'),
      onPressed: () => setState(() => mode = UserDetailsMode.edit),
    );
  }

  Widget builSaveButton() {
    return CustomButton(
      child: const Text('Save'),
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          UserEntity userUpdate = UserEntity(
            id: user?.id,
            status: user?.status,
            email: emailController.text,
            phoneNumber: phoneController.text,
            firstName: fNameController.text,
            lastName: lNameController.text,
            role: roleController.text,
          );

          if (user != userUpdate) {
            context.read<UsersBloc>().add(UpdateUserEvent(user: userUpdate));
            Navigator.pop(context);
          } else {
            setState(() {
              mode = UserDetailsMode.show;
            });
          }
        }
      },
    );
  }

  Widget buildBackButton(BuildContext context) {
    return CustomOutlineButton(
      child: const Text('Back'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

enum UserDetailsMode { edit, show }
