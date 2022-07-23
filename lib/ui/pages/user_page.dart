import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_users_app/cubit/user_cubit.dart';
import 'package:github_search_users_app/ui/theme/theme_font.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  'Github Search User App',
                  style: defTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 36,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                        ),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            if (state is UserInitial) {}
                            if (state is UserLoaded) {}
                            if (state is UserError) {}
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Center(
            child: TextField(
              cursorColor: Colors.black,
              style: defTextStyle.copyWith(fontSize: 12),
              onSubmitted: (value) {
                context.read<UserCubit>().getUserGithub();
              },
              controller: UserCubit.search,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: defTextStyle.copyWith(fontSize: 12),
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
