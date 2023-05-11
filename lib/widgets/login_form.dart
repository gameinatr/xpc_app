import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/constants/styling.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:xpc_app/storage/secure_storage.dart';
import 'package:xpc_app/utils/index.dart';
import '../constants/general.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loading = false;
  bool _loginFailed = false;
  final String loginUrl = '${API_URL}token/';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final dio = Dio();
  final _storage = SecureStorage();

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    return emailRegExp.hasMatch(email);
  }

  Future<void> _sendLoginRequest() async {
    setState(() {
      _loginFailed = false;
      _loading = true;
    });

    try {
      if ((_formKey.currentState != null &&
          _formKey.currentState!.validate())) {
        final body = jsonEncode({
          'email': emailController.text,
          'password': passwordController.text
        });

        final response = await dio.post(loginUrl,
            options: Options(
                headers: {Headers.contentTypeHeader: "application/json"}),
            data: body);
        final data = response.data;
        if (response.statusCode == 200) {
          rewriteTokens(response);
          AutoRouter.of(context).push(const CoursesListRoute());
        } else {
          throw Exception(data);
        }
      }
    } catch (err) {
      setState(() {
        _loginFailed = true;
        _loading = false;
      });
      throw Exception(err);
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 30),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: 'Your email address',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "This field is required";
                  }

                  if (!_isValidEmail(value!)) {
                    return "This is not a valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: 'Your password', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 8) {
                    return "Your password is too short";
                  } else if (value != null && value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        if (!_loading)
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff6153f9)),
            onPressed: () {
              _sendLoginRequest();
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Login', style: ThemeTextStyles.semiBoldMediumSize),
            ),
          ),
        if (_loginFailed)
          const Column(
            children: [
              SizedBox(height: 30),
              Text(
                  'Sorry, can/t log you in using this info. In most of these cases, either your password or email is typed incorrectly. Can you kindly check?'),
            ],
          ),
        if (_loading) const Center(child: CircularProgressIndicator())
      ],
    );
  }
}
