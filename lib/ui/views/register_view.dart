import 'package:doggy_do/core/models/user_model.dart';
import 'package:doggy_do/style.dart';
import 'package:flutter/material.dart';
import '../../core/enums/viewstate.dart';

import '../../core/viewmodels/register_view_model.dart';
import 'base_view.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dogNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        onModelReady: (RegisterViewModel) {},
        builder: (context, model, child) => Scaffold(
            body: model.state == ViewState.Busy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Center(
                      child: Card(
                        margin: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  labelText: 'User Name',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey[400]!, width: 1.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _dogNameController,
                                decoration: InputDecoration(
                                  labelText: 'Doggie Name',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey[400]!, width: 1.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  UserModel userModel = UserModel();
                                  userModel.dogName = _dogNameController.text;
                                  userModel.userName = _userNameController.text;
                                  Navigator.pushNamed(context, 'uploadphoto',
                                      arguments: userModel);
                                },
                                child: Text('next'),
                                style: Styles.buttonStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )));
  }
}
