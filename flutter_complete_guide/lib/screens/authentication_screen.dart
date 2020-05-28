import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/data/middleware/authentication_middleware.dart';
import 'package:flutter_complete_guide/utils/constant.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isSignin = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleSignIn() {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Login processed'),
      ),
    );
  }

  void _handleSignUp() {
    if (!_registerFormKey.currentState.validate()) {
      return;
    }

    AuthMiddleware().signup(
      email: _emailController.text,
      password: _passController.text,
    );

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Signup processed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              _background(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: context.media.viewPadding.top + 40,
                        minHeight: context.media.viewPadding.top + 25,
                      ),
                    ),
                    Text(
                      'Wellcome',
                      style: context.theme.textTheme.title.copyWith(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      style: context.theme.textTheme.title.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    _authenForm(),
                    SizedBox(height: 40),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container()),
                            Container(
                              width: 220,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _thirdPartyLoginButton(
                                    'assets/images/fb_logo.png',
                                    onPressed: () {},
                                  ),
                                  _thirdPartyLoginButton(
                                    'assets/images/google_logo.png',
                                    onPressed: () {},
                                  ),
                                  _thirdPartyLoginButton(
                                    'assets/images/twitter_logo.png',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.theme.primaryColor.withPercentAlpha(0.9),
                  context.theme.primaryColor.withPercentAlpha(0.8),
                  context.theme.primaryColor.withPercentAlpha(0.7)
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _authenForm() {
    final Text signInText = Text(
      'Sign in',
      style: context.theme.textTheme.title.copyWith(
        fontSize: 17,
        color: _isSignin ? Colors.black : Colors.grey.withPercentAlpha(0.7),
      ),
    );

    final Text signUpText = Text(
      'Sign up',
      style: context.theme.textTheme.title.copyWith(
        fontSize: 17,
        color: _isSignin ? Colors.grey.withPercentAlpha(0.7) : Colors.black,
      ),
    );

    return Stack(
      overflow: Overflow.visible,
      children: [
        CustomPaint(
          painter: _AuthFramePainter(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 14),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 32,
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: signInText,
                            onPressed: () {
                              setState(() {
                                _isSignin = true;
                              });
                            },
                          ),
                        ),
                        if (_isSignin)
                          Container(
                            color: Colors.redAccent,
                            width: signInText.textSize.width + 8,
                            height: 2.0,
                          ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 32,
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: signUpText,
                            onPressed: () {
                              setState(() {
                                _isSignin = false;
                              });
                            },
                          ),
                        ),
                        if (!_isSignin)
                          Container(
                            color: Colors.redAccent,
                            width: signUpText.textSize.width + 8,
                            height: 2.0,
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                if (_isSignin) _loginForm(),
                if (!_isSignin) _registerForm()
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -30,
          child: Container(
            width: context.media.size.width - 32,
            alignment: Alignment.center,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.theme.primaryColor.withPercentAlpha(0.9),
                    context.theme.primaryColor.withPercentAlpha(0.8),
                    context.theme.primaryColor.withPercentAlpha(0.7)
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FlatButton(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_isSignin) {
                      _handleSignIn();
                    } else {
                      _handleSignUp();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            _textField(
              controller: _userNameController,
              placeHolder: 'username',
              prefixIcon: Icon(Icons.perm_identity),
              validator: (string) {
                if (string.isEmpty) {
                  return 'Please enter a username';
                }

                if (string.length <= 6) {
                  return 'The username must be larger than 6 characters';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
            _textField(
                controller: _passController,
                placeHolder: 'password',
                prefixIcon: Icon(Icons.lock_outline),
                obscureText: true,
                validator: (string) {
                  if (string.isEmpty) {
                    return 'Please enter a password';
                  }

                  if (!string.contains(RegExp(Constaint.passwordRex))) {
                    return 'The password is invalid';
                  }

                  return null;
                }),
            Container(
              alignment: Alignment.topRight,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'Forgot Password?',
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 16,
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _registerFormKey,
        child: Column(
          children: <Widget>[
            _textField(
              controller: _userNameController,
              placeHolder: 'username',
              prefixIcon: Icon(Icons.perm_identity),
              validator: (string) {
                if (string.isEmpty) {
                  return 'Please enter a username';
                }

                if (string.length <= 6) {
                  return 'The username must be larger than 6 characters';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
            _textField(
              controller: _emailController,
              placeHolder: 'email',
              prefixIcon: Icon(Icons.mail_outline),
              textInputType: TextInputType.emailAddress,
              validator: (string) {
                if (string.isEmpty) {
                  return 'Please enter a email adress';
                }

                if (!string.contains(RegExp(Constaint.emailRex))) {
                  return 'The email is invalid';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
            _textField(
              controller: _passController,
              placeHolder: 'password',
              prefixIcon: Icon(Icons.lock_outline),
              obscureText: true,
              validator: (string) {
                if (string.isEmpty) {
                  return 'Please enter a password';
                }

                if (!string.contains(RegExp(Constaint.passwordRex))) {
                  return 'The password is invalid';
                }

                return null;
              },
            ),
            SizedBox(height: 25),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By pressing \"submit\" you agree to our\n',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: CupertinoButton(
                      minSize: 14,
                      padding: EdgeInsets.zero,
                      child: Text(
                        'terms & conditions',
                        style: context.theme.textTheme.title.copyWith(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _thirdPartyLoginButton(String image,
      {@required VoidCallback onPressed}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _textField({
    String placeHolder,
    Icon prefixIcon,
    TextEditingController controller,
    Function(String) validator,
    bool obscureText = false,
    TextInputType textInputType,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(minWidth: 60),
          hintText: placeHolder,
          hintStyle: context.theme.textTheme.title.copyWith(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class _AuthFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);
    final avatarBounds = Rect.fromCircle(center: centerAvatar, radius: 38);
    _drawBackground(canvas, shapeBounds, avatarBounds, 8.0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawBackground(
      Canvas canvas, Rect shapeBounds, Rect avatarBounds, double corner) {
    final paint = Paint()..color = Colors.white;
    final paintShadow = Paint()
      ..color = Colors.grey.withPercentAlpha(0.7)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        _convertRadiusToSigma(15.0),
      );
    final path = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top + corner)
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy - corner)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(
            corner,
            shapeBounds.bottom - corner,
          ),
          radius: corner,
        ),
        180.0.toRadian(),
        -90.0.toRadian(),
        false,
      )
      ..arcTo(avatarBounds, pi, -pi, false)
      ..lineTo(shapeBounds.bottomRight.dx - corner, shapeBounds.bottomRight.dy)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(
            shapeBounds.bottomRight.dx - corner,
            shapeBounds.bottom - corner,
          ),
          radius: corner,
        ),
        90.0.toRadian(),
        -90.0.toRadian(),
        false,
      )
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy + corner)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(
            shapeBounds.topRight.dx - corner,
            shapeBounds.top + corner,
          ),
          radius: corner,
        ),
        0.0.toRadian(),
        -90.0.toRadian(),
        false,
      )
      ..lineTo(shapeBounds.topLeft.dx + corner, shapeBounds.topLeft.dy)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(
            shapeBounds.topLeft.dx + corner,
            shapeBounds.top + corner,
          ),
          radius: corner,
        ),
        270.0.toRadian(),
        -90.0.toRadian(),
        false,
      )
      ..close();

    canvas.drawPath(path, paintShadow);
    canvas.drawPath(
      path,
      paint,
    );
  }

  double _convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }
}
