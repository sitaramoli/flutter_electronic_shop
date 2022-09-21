import 'dart:math';

import 'package:electronic_shop/app/core/constants/color_manager.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:electronic_shop/app/core/widgets/loading_widget.dart';
import 'package:electronic_shop/dependency_injection.dart';
import 'package:electronic_shop/features/home/home_view.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late FormGroup _formGroup;

  final viewmodel = instance<LoginController>();

  @override
  void initState() {
    _formGroup = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)])
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, value, child) {
      if (value.isLoading) {
        return const LoadingWidget();
      } else {
        return _buildBody(value);
      }
    });
  }

  _buildBody(LoginController value) {
    return FutureBuilder(
        future: value.isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return const HomeView();
            } else {
              return _form();
            }
          } else {
            return const LoadingWidget();
          }
        });
  }

  _form() {
    {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ColorManager.FORM_GRADIENT,
            transform: GradientRotation(pi / 2),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Consumer<LoginController>(builder: (context, value, __) {
              return ReactiveForm(
                formGroup: _formGroup,
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.S50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          AssetsManager.PROFILE,
                        ),
                        radius: AppSize.S70,
                      ),
                      const SizedBox(height: AppSize.S40),
                      Text(
                        StringManager.WELCOME_BACK,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Divider(thickness: 1),
                      const SizedBox(height: 20),
                      ReactiveTextField(
                        formControlName: StringManager.EMAIL_KEY,
                        decoration: const InputDecoration(
                          hintText: StringManager.EMAIL,
                          prefixIcon: Icon(Icons.email),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              StringManager.INVALID_EMAIL,
                          ValidationMessage.email: (error) =>
                              StringManager.INVALID_EMAIL
                        },
                      ),
                      const SizedBox(height: 20),
                      ReactiveTextField(
                        formControlName: StringManager.PASSWORD_KEY,
                        obscureText: !value.passwordVisible,
                        decoration: InputDecoration(
                          hintText: StringManager.PASSWORD,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => value.togglePasswordVisibility(),
                            icon: value.passwordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              StringManager.INVALID_PASSWORD,
                          ValidationMessage.minLength: (error) =>
                              StringManager.INVALID_PASSWORD
                        },
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.S20)),
                        onTap: () async {
                          if (_formGroup.valid) {
                            await value.emailLogin(_formGroup.value);
                          } else {
                            _formGroup.markAllAsTouched();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(AppSize.S20),
                              color: Theme.of(context).textTheme.button?.color),
                          height: 50,
                          width: 300,
                          child: Center(
                            child: Text(
                              StringManager.LOGIN,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(children: [
                        const Expanded(
                            child: Divider(
                                thickness: AppSize.S1, endIndent: AppSize.S2)),
                        Text(StringManager.OR,
                            style: Theme.of(context).textTheme.subtitle1),
                        const Expanded(child: Divider(thickness: 1, indent: 2)),
                      ]),
                      const SizedBox(height: 20),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.S20)),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(AppSize.S20),
                            color: Theme.of(context).textTheme.button?.color,
                          ),
                          height: 40,
                          width: 250,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(FontAwesomeIcons.google,
                                    color: ColorManager.ERROR),
                                const SizedBox(width: AppSize.S20),
                                Text(StringManager.GOOGLE,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ]),
                        ),
                        onTap: () async {
                          await value.googleSignin();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _formGroup.dispose();
    super.dispose();
  }
}
