import 'package:contact_book/core/widgets/app_bar_popup_menu/popup_menu.dart';
import 'package:contact_book/core/widgets/custom_fading_widget.dart';
import 'package:contact_book/features/users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupButton extends StatefulWidget {
  const PopupButton({
    super.key,
  });

  @override
  State<PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserLoaded) {
          return IconButton(
            iconSize: 32,
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(1, 80, 0, 0),
                items: popupMenu(context, state.user),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          );
        } else if (state is CurrnetUserLoading) {
          return buildIconLoading();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  CustomFadingWidget buildIconLoading() {
    return CustomFadingWidget(
        child: IconButton(
      iconSize: 32,
      onPressed: () {},
      icon: const Icon(Icons.account_circle_outlined),
    ));
  }
}
