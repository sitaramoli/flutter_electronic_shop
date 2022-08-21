import 'dart:math';

import 'package:electronic_shop/app/constants/assets_constants.dart';
import 'package:electronic_shop/app/constants/color_constants.dart';
import 'package:electronic_shop/app/constants/spacing_constants.dart';
import 'package:electronic_shop/app/constants/string_constants.dart';
import 'package:electronic_shop/common_widgets/loading_widget.dart';
import 'package:electronic_shop/dependency_injection.dart';
import 'package:electronic_shop/features/cart/home_view.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late FormGroup _formGroup;

  final viewmodel = instance<LoginViewModel>();

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
    return Consumer<LoginViewModel>(builder: (context, value, child) {
      if (value.isLoading) {
        return const LoadingWidget();
      } else {
        return _buildBody(value);
      }
    });
  }

  _buildBody(LoginViewModel value) {
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
            colors: ColorConstants.primaryGradient,
            transform: GradientRotation(pi / 2),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Consumer<LoginViewModel>(builder: (context, value, __) {
              return ReactiveForm(
                formGroup: _formGroup,
                child: Padding(
                  padding: const EdgeInsets.all(SpacingConstants.s50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          AssetsConstants.profileGeneric,
                        ),
                        radius: 70,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        StringConstants.login.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const Divider(thickness: 1),
                      const SizedBox(height: 20),
                      ReactiveTextField(
                        formControlName: StringConstants.email,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              'Email must not be empty',
                          ValidationMessage.email: (error) =>
                              'Please enter a valid email'
                        },
                      ),
                      const SizedBox(height: 20),
                      ReactiveTextField(
                        formControlName: StringConstants.password,
                        obscureText: !value.passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                              'Password must not be empty',
                          ValidationMessage.minLength: (error) =>
                              'Password must have at least 6 characters'
                        },
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SpacingConstants.s20)),
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
                              borderRadius:
                                  BorderRadius.circular(SpacingConstants.s20),
                              color: Theme.of(context).textTheme.button?.color),
                          height: 50,
                          width: 300,
                          child: Center(
                            child: Text(
                              StringConstants.login,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(children: [
                        const Expanded(
                            child: Divider(thickness: 1, endIndent: 2)),
                        Text('OR',
                            style: Theme.of(context).textTheme.subtitle1),
                        const Expanded(child: Divider(thickness: 1, indent: 2)),
                      ]),
                      const SizedBox(height: 20),
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(SpacingConstants.s20)),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.circular(SpacingConstants.s20),
                            color: Theme.of(context).textTheme.button?.color,
                          ),
                          height: 40,
                          width: 250,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(FontAwesomeIcons.google,
                                    color: ColorConstants.error),
                                const SizedBox(width: 20),
                                Text(StringConstants.google,
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
