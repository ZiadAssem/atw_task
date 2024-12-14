import 'package:atw_task/data/repositories/auth_repo_impl.dart';
import 'package:atw_task/data/services/auth_firebase.dart';
import 'package:atw_task/domain/repositories/auth_repo.dart';
import 'package:get_it/get_it.dart';

final sl=GetIt.instance;

// Dependency Injection
Future<void> initializeDependancies()async{
  sl.registerSingleton<AuthFirebase>(AuthFirebase());
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
}