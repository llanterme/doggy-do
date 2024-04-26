import 'package:doggy_do/core/viewmodels/landing_view_model.dart';
import 'package:doggy_do/core/viewmodels/register_view_model.dart';
import 'package:doggy_do/core/viewmodels/vote_view_model.dart';
import 'package:get_it/get_it.dart';
import 'core/network/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => RegisterViewModel());
  locator.registerLazySingleton(() => LandingViewModel());
  locator.registerLazySingleton(() => VoteViewModel());
}
