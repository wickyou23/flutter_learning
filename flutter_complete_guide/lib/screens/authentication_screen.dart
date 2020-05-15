import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isSignin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'Welcome',
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
                  SizedBox(
                    height: 40,
                  ),
                  _authenForm(),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
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
          child: Container(),
        ),
      ],
    );
  }

  Widget _authenForm() {
    final Text signInText = Text(
      'Sign in',
      style: context.theme.textTheme.title.copyWith(
        fontSize: 16,
        color: _isSignin ? Colors.black : Colors.grey.withPercentAlpha(0.7),
      ),
    );

    final Text signUpText = Text(
      'Sign up',
      style: context.theme.textTheme.title.copyWith(
        fontSize: 16,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 32,
                          child: FlatButton(
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
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 32,
                          child: FlatButton(
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
                if (_isSignin) _loginForm()
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
                  onPressed: () {},
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
      height: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.perm_identity),
                  prefixIconConstraints: BoxConstraints(minWidth: 60),
                  hintText: 'username',
                  hintStyle: context.theme.textTheme.title.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                  prefixIconConstraints: BoxConstraints(minWidth: 60),
                  hintText: 'password',
                  hintStyle: context.theme.textTheme.title.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  )),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: FlatButton(
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
        ],
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
