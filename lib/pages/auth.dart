import 'package:flutter/material.dart';
import 'package:geoloc/services/auth.dart';
import '../pages/home.dart';

import '../widgets/custom_text_form_field.dart';
// import '../model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthPage extends StatefulWidget {
  static const route = '/auth';

  AuthPage();

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late BaseAuth auth;
  // final VoidCallback? loginCallback;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _empIdRef;

  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  String? _email;

  String? _password;

  bool _isLoading = false;
  bool _isLoginForm = true;

  @override
  void initState() {
    auth = Auth();
    _isLoading = false;
    _isLoginForm = true;

    // _empIdRef = db.ref().child('')
    super.initState();
  }

  Future<void> _userSignIn() async {
    setState(() {
      _isLoading = true;
    });

    String userId = '';
    _email = _emailController.text;
    _password = _passwordController.text;

    print(_email);

    try {
      if (_isLoginForm) {
        userId = await auth.signIn(_email!, _password!);

        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } else {
        userId = await auth.signUp(_email!, _password!);
      }
    } catch (e) {
      showUserNotFoundError(context);
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

  void toggleFormMode() {
    setState(() {
      _formKey.currentState!.reset();
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Container(
                  height: deviceSize.height * 0.7,
                  width: deviceSize.width * 0.9,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildContent(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildCircularProgressIndicator() {
    _passwordController.clear();
    _emailController.clear();

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
              controller: _emailController,
              labelText: 'Email',
              validatorFunction: (value) {
                if (value.isEmpty) {
                  return 'Invalid User';
                }
              },
              onSavedFunction: (value) {
                _email = value;
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
              child: Text(_isLoginForm ? 'LOGIN' : 'SIGN UP'),
            ),
            SizedBox(
              height: 25,
            ),
            TextButton(
                onPressed: toggleFormMode,
                child: Text(_isLoginForm
                    ? ' Create an account'
                    : 'Have an account? Sign In'))
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
}
