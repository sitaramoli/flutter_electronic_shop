import 'package:electronic_shop/app/config/routes/app_routes.dart';
import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:electronic_shop/dependency_injection.dart';
import 'package:electronic_shop/features/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Box? box;
  @override
  void initState() {
    super.initState();
  }

  void openBox() async {
    box = await Hive.openBox('userDb');
    setState(() {});
  }

  final controller = instance<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildMenuItems(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(top: AppSize.S50, bottom: AppSize.S8),
        child: Column(
          children: [
            CircleAvatar(
              radius: AppSize.S50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: box?.get('image') != null
                      ? Image.network(box?.get('image'))
                      : Image.asset(AssetsManager.PROFILE)),
            ),
            const SizedBox(height: 15),
            Text(box?.get('name') ?? 'User',
                style: Theme.of(context).textTheme.headline4),
            Text(box?.get('email') ?? 'someone@example.com',
                style: Theme.of(context).textTheme.button),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.S20),
      child: Wrap(
        runSpacing: AppSize.S8,
        children: [
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(StringManager.LOGOUT,
                style: Theme.of(context).textTheme.subtitle1),
            onTap: () {
              controller.logout();
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
          )
        ],
      ),
    );
  }
}
