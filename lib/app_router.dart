import 'package:doggy_do/core/models/user_model.dart';
import 'package:doggy_do/ui/views/landing_view.dart';
import 'package:doggy_do/ui/views/register_view.dart';
import 'package:doggy_do/ui/views/upload_dog_photo_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'register':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingView());
      case 'uploadphoto':
        var user = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => UploadDogPhotoView(
                  user: user,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
