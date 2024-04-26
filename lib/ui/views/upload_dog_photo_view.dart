import 'dart:io';

import 'package:doggy_do/core/models/user_model.dart';
import 'package:doggy_do/style.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/register_view_model.dart';
import 'base_view.dart';
import 'package:path/path.dart' as path;

class UploadDogPhotoView extends StatefulWidget {
  final UserModel user;

  const UploadDogPhotoView({Key? key, required this.user}) : super(key: key);

  @override
  _UploadDogPhotoViewState createState() => _UploadDogPhotoViewState();
}

class _UploadDogPhotoViewState extends State<UploadDogPhotoView> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onModelReady: (RegisterViewModel) {},
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Upload Doggo Image'),
        ),
        body: model.state == ViewState.Busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      margin: const EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5.0,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedImage = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(() {
                                    _pickedImage = File(pickedImage.path);
                                  });
                                }
                              },
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: _pickedImage != null
                                    ? Image.file(
                                        _pickedImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var fileName = path.basename(_pickedImage!.path);
                        var success = await model.uploadImage(
                            _pickedImage!.path, fileName, widget.user);

                        if (success) {
                          Navigator.pushNamed(
                            context,
                            'landing',
                          );
                        }
                      },
                      style: Styles.buttonStyle,
                      child: const Text('finish'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
