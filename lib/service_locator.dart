import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/core/network/dio_client.dart';
import 'package:sccc_v3/core/service%20locators/repository_locators.dart';
import 'package:sccc_v3/core/service%20locators/service_locators.dart';
import 'package:sccc_v3/core/service%20locators/usecase_locators.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // dio
  getIt.registerSingleton<DioClient>(DioClient());

  // database
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  // logger
  getIt.registerSingleton<Logger>(Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  ));

  repositoryLocators();

  serviceLocators(); // should be data source locators

  usecaseLocators();
}
