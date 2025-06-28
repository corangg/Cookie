import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:data/local/drift/drift_database.dart';
import 'package:data/data_source/local_data_source.dart';
import 'package:data/local/default_local_data_source.dart';
import 'package:data/repository/default_repository.dart';
import 'package:domain/repository/repository.dart';
import 'package:domain/usecases/cookie_usecase.dart';
import 'package:domain/usecases/collection_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final db = AppDatabase.open();
  sl.registerLazySingleton<AppDatabase>(() => db);

  sl.registerLazySingleton<LocalDataSource>(
        () => DefaultLocalDataSource(sl()),
  );

  sl.registerLazySingleton<Repository>(
        () => DefaultRepository(sl()),
  );

  sl.registerLazySingleton(() => GetCookieDataUseCase(sl()));
  sl.registerLazySingleton(() => UpsertCookieDataUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayCookieDataUseCase(sl()));

  sl.registerLazySingleton(() => CreateNewCollectionNoUseCase(sl()));

  sl.registerFactory(() => OvenScreenViewModel(
    getTodayCookieDataUseCase: sl(),
    getUseCase: sl(),
    upsertUseCase: sl(),
    createNewCollectionNoUseCase: sl(),
  ));
}