import 'package:cookie/viewmodel/collection_view_model.dart';
import 'package:cookie/viewmodel/oven_screen_view_model.dart';
import 'package:cookie/viewmodel/more_screen_view_model.dart';
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
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase.open());

  sl.registerLazySingleton<LocalDataSource>(
        () => DefaultLocalDataSource(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<Repository>(
        () => DefaultRepository(sl()),
  );

  sl.registerLazySingleton(() => GetCookieDataUseCase(sl()));
  sl.registerLazySingleton(() => UpsertCookieDataUseCase(sl()));
  sl.registerLazySingleton(() => UpdateOpenCookieDataUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayCookieDataUseCase(sl()));

  sl.registerLazySingleton(() => CreateNewCollectionNoUseCase(sl()));
  sl.registerLazySingleton(() => UpsertCollectionUseCase(sl()));

  sl.registerLazySingleton(() => GetTypeCollectionDataUseCase(sl()));
  sl.registerLazySingleton(() => FillCollectionDataListUseCase());

  sl.registerFactory(() => OvenScreenViewModel(
    getTodayCookieDataUseCase: sl(),
    getUseCase: sl(),
    upsertCookieDataUseCase: sl(),
    createNewCollectionNoUseCase: sl(),
    upsertCollectionUseCase: sl(),
    updateOpenCookieDataUseCase: sl(),
  ));

  sl.registerFactory(() => CollectionViewModel(
    getTypeCollectionDataUseCase: sl(),
    fillCollectionDataListUseCase: sl()
  ));

  sl.registerFactory(() => MoreScreenViewModel(

  ));
}