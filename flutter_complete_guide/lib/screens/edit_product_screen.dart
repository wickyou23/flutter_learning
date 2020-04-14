import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String _imageUrl = '';
  final GlobalKey<FormState> _mainForm = GlobalKey<FormState>();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _handleAddProduct() {
    if (_imageUrl.isEmpty) {
      _showWarningAlert(message: 'Please add an image!');
      return;
    }

    if (_mainForm.currentState.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _handleAddProduct();
            },
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _mainForm,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: _imageWidget(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              controller: _titleController,
                              focusNode: _titleFocus,
                              textInputAction: TextInputAction.next,
                              style: context.theme.textTheme.title.copyWith(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Title',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.only(
                                  top: 14,
                                  bottom: 14,
                                  right: 10,
                                  left: 10,
                                ),
                                hintStyle:
                                    context.theme.textTheme.title.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_priceFocus);
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _priceController,
                              focusNode: _priceFocus,
                              keyboardType: TextInputType.number,
                              style: context.theme.textTheme.title.copyWith(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Price',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.only(
                                  top: 14,
                                  bottom: 14,
                                  right: 10,
                                  left: 10,
                                ),
                                hintStyle:
                                    context.theme.textTheme.title.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLines: 5,
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    textInputAction: TextInputAction.done,
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Description...',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        right: 10,
                        left: 10,
                      ),
                      hintStyle: context.theme.textTheme.title.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    validator: (string) {
                      if (string.length < 10) {
                        return 'Description must be greater than 10 character';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _handleAddProduct();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return AspectRatio(
      key: Key('_imageWidget'),
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          width: double.infinity,
          color: Colors.grey.withPercentAlpha(0.3),
          child: _imageUrl.isEmpty
              ? IconButton(
                  icon: Icon(Icons.add_a_photo),
                  color: context.theme.primaryColor,
                  onPressed: () {
                    _showTextFieldAlert().then((value) {
                      setState(() {
                        _imageUrl = value;
                      });
                    });
                  },
                )
              : Image.network(
                  _imageUrl,
                  fit: BoxFit.cover,
                  frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }

                    return AnimatedOpacity(
                      child: child,
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  },
                  loadingBuilder: (_, child, loadingProgress) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        if (loadingProgress != null)
                          Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        child,
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<String> _showTextFieldAlert() {
    return showDialog<String>(
      context: context,
      builder: (ctx) {
        final textFieldUrl = TextEditingController();
        final GlobalKey<FormState> imageUrlForm = GlobalKey<FormState>();

        return AlertDialog(
          title: Text('Image Url'),
          content: Container(
            width: context.media.size.width,
            child: Form(
              key: imageUrlForm,
              child: TextFormField(
                controller: textFieldUrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter image url',
                  border: const OutlineInputBorder(),
                ),
                validator: (string) {
                  if (string.isEmpty) {
                    return 'Please enter a image url';
                  }

                  if (!string.startsWith('http:') &&
                      !string.startsWith('https:')) {
                    return 'The url is invalid';
                  }

                  return null;
                },
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                context.navigator.pop('');
              },
            ),
            FlatButton(
              child: Text(
                'OK',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 16,
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (imageUrlForm.currentState.validate()) {
                  context.navigator.pop(textFieldUrl.text);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showWarningAlert({String message}) {
    showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(
                Icons.warning,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Warning!',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Container(
            width: context.media.size.width,
            child: Text(
              message,
              style: context.theme.textTheme.title.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: context.theme.textTheme.title.copyWith(
                  fontSize: 16,
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                context.navigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
