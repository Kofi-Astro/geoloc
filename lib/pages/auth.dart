import 'package:flutter/material.dart';
import 'package:geoloc/services/auth.dart';
import '../pages/home.dart';

import '../widgets/custom_text_form_field.dart';
// import '../model/user_model.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Flexible(child: AuthCard())],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key, this.auth, this.loginCallback});

  final BaseAuth? auth;
  final VoidCallback? loginCallback;

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  String? _username;
  String? _password;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void showUserNotFoundError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('User does not exist.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _userSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // _user = User(
      //   password: _password,
      //   username: _username,
      // );
      Navigator.of(context).pushNamed(HomeScreen.routeName);
      // _userService!.loginUser(_user!);
    } catch (e) {
      // showUserNotFoundError(context);
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    _userSignIn();
  }

  Widget _buildCircularProgressIndicator() {
    _passwordController.clear();
    _usernameController.clear();

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSignIn() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/nsb_logo.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextFormField(
              controller: _usernameController,
              labelText: 'Username',
              validatorFunction: (value) {
                if (value.isEmpty) {
                  return 'Invalid User';
                }
              },
              onSavedFunction: (value) {
                _username = value;
              },
            ),
            CustomTextFormField(
              labelText: 'Password',
              obscureText: true,
              controller: _passwordController,
              validatorFunction: (value) {
                if (value.isEmpty || value.length < 5) {
                  return 'Invalid Password';
                }
              },
              onSavedFunction: (value) {
                _password = value;
              },
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('LOGIN'),
            ),
            SizedBox(
              height: 25,
            ),
            TextButton(onPressed: () {}, child: Text('SIGN UP'))
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return _buildCircularProgressIndicator();
    } else {
      return _buildSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      height: deviceSize.height * 0.7,
      width: deviceSize.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: _buildContent(),
    );
  }
}
