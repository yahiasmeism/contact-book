import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import 'snackbar_global.dart';
import '../../features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import '../../features/users/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPopupMenu extends StatelessWidget {
  const MainPopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserCubit, CurrentUserState>(
      listener: (context, state) {
        if (state is CurrnetUserFailure) {
          SnackBarGlobal.show(context, state.message);
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1, 80, 0, 0),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    padding: const EdgeInsets.all(16),
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state is CurrnetUserLoaded
                              ? "${state.user.firstName}${state.user.lastName}"
                              : "unknown",
                          style: STYLES.TEXT_STYLE_16
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state is CurrnetUserLoaded
                              ? state.user.email
                              : 'unknown',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                      child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  )),
                  PopupMenuItem(
                      child: ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      if (state is CurrnetUserLoaded) {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                        Navigator.pushNamed(context, UserDetailsPage.name,
                            arguments: state.user);
                      }
                    },
                  )),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                      child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      context.read<LogoutCubit>().logout();
                      AwesomeDialog(
                        animType: AnimType.bottomSlide,
                        dialogType: DialogType.warning,
                        context: context,
                        title: 'Are you sure to Log out',
                        btnOkColor: COLORS.PRIMARY,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          context.read<LogoutCubit>().logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.name,
                            (route) => false,
                          );
                        },
                      ).show();
                    },
                  )),
                ]);

            PopupMenuButton(
              icon: const Icon(Icons.account_circle_outlined),
              onSelected: (value) {},
              itemBuilder: (context) {
                return <PopupMenuEntry>[];
              },
            );
          },
          icon: const Icon(Icons.account_circle_outlined),
        );
      },
    );
  }
}
