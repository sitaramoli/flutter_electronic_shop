import 'package:electronic_shop/features/authentication/presentation/login/login_view_model.dart';
import 'package:electronic_shop/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<LoginViewModel>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, Routes.authRoute);
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
