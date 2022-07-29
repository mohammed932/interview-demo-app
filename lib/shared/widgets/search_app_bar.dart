import 'package:base_flutter/shared/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tf_validator/localization/LocalizationMethods.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClose;
  final VoidCallback onSearch;
  final VoidCallback onBack;
  final GenericCubit<bool> searchCubit;
  final TextEditingController searchController;
  final Function(String) onTextInputChange;
  final String title;
  final bool hideBackButton;
  SearchAppBar({
    required this.onClose,
    required this.onSearch,
    required this.searchCubit,
    required this.onBack,
    required this.title,
    required this.searchController,
    required this.onTextInputChange,
    this.hideBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: hideBackButton
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: AppColors.black,
                ),
                onPressed: onBack,
              ),
        elevation: 0.0,
        actions: [
          BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
            bloc: searchCubit,
            builder: (context, state) {
              if (state.data) {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSearch,
                );
              }
            },
          ),
        ],
        backgroundColor: AppColors.appBarColor,
        title: BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
          bloc: searchCubit,
          builder: (context, state) {
            if (state.data) {
              return TextFormField(
                autofocus: true,
                controller: searchController,
                onChanged: onTextInputChange,
                decoration: InputDecoration(
                  label: Text(tr(context, 'search')),
                ),
              );
            } else {
              return MyText(
                  title: tr(context, title),
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  size: 14.0);
            }
          },
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
