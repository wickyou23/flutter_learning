import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class EditProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.grey.withPercentAlpha(0.3),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo),
                              color: context.theme.primaryColor,
                              onPressed: () {
                                print('1231312312');
                              },
                            ),
                          ),
                        ),
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
                              style: context.theme.textTheme.title.copyWith(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                filled: true,
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
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style: context.theme.textTheme.title.copyWith(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                filled: true,
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
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      filled: true,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
