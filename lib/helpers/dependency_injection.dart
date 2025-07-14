
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../feature/auth/repositories/auth_repository.dart';
// import '../feature/auth/repositories/auth_repository_interface.dart';
// import '../feature/auth/sevices/auth_service.dart';
// import '../feature/auth/sevices/auth_service_interface.dart';
// import 'remote/data/api_client.dart';

// Future<void> initDI() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   ApiClient apiClient = ApiClient(
//     appBaseUrl: 'https://johnnybrutes.onrender.com/api/v1/',
//     sharedPreferences: prefs,
//   );

//   //////////// Auth Service, Repository and Controller ////////////////////////////////

//   Get.lazyPut(() => ApiClient(appBaseUrl: 'appBaseUrl', sharedPreferences: prefs),);
//   Get.lazyPut(() => AuthRepository(apiClient: Get.find(), sharedPreferences: prefs),);
//   AuthRepositoryInterface authRepositoryInterface = AuthRepository(
//     apiClient: Get.find(),
//     sharedPreferences: prefs,
//   );
//   Get.lazyPut(() => authRepositoryInterface);
//   AuthServiceInterface authServiceInterface = AuthService(Get.find());
//   Get.lazyPut(() => authServiceInterface);
//   Get.lazyPut(() => AuthController(authServiceInterface: Get.find()));
//   Get.lazyPut(() => AuthService(Get.find()));

//   //////////// Auth Service, Repository and Controller ////////////////////////////////
//   ///
//   ///
//   ///

//   ///  ////////////  Commanders Calls, Repository and Controller ////////////////////////////////

//   Get.lazyPut(
//         () => CommandersCallRepository(Get.find(), prefs),
//   );

//   CommandersCallRepositoryInterface commandersCallRepositoryInterface = CommandersCallRepository(Get.find(), prefs,);


//   Get.lazyPut(() => commandersCallRepositoryInterface);

//   CommandersCallServiceInterface commandersCallServiceInterface = CommandersCallService(Get.find());

//   Get.lazyPut(() => commandersCallServiceInterface);

//   Get.lazyPut(() => CommandersCallsController(Get.find()));

//   Get.lazyPut(() => CommandersCallService(Get.find()));



//   ////////////  Commanders Calls, Repository and Controller ////////////////////////////////


//   //////////// Auth Service, Repository and Controller ////////////////////////////////




//   //Get.lazyPut(() => ReviewRepository(Get.find(), prefs));

//   ReviewRepositoryInterface reviewRepositoryInterface = ReviewRepository(Get.find(), prefs,);


//   Get.lazyPut(() => reviewRepositoryInterface);

//   ReviewServiceInterface reviewServiceInterface = ReviewService(Get.find());

//   Get.lazyPut(() => reviewServiceInterface);

//   Get.lazyPut(() => ReviewController(Get.find()));

//   Get.lazyPut(() => ReviewService(Get.find()));



// //   // Registering the repository
// //   Get.lazyPut<ReviewRepositoryInterface>(() => ReviewRepository(Get.find(), prefs));
// //
// // // Registering the service
// //   Get.lazyPut<ReviewServiceInterface>(() => ReviewService(Get.find<ReviewRepositoryInterface>()));
// //
// // // Registering the controller
// //   Get.lazyPut<ReviewController>(() => ReviewController(Get.find<ReviewServiceInterface>()));




//   ////////////  Commanders Calls, Repository and Controller ////////////////////////////////


//   //////////// Commanders Calls Service, Repository and Controller ////////////////////////////////

//   // Get.lazyPut(()=> CommandersRepository(apiClient: Get.find(), sharedPreferences: prefs));

//   // CommandersRepositoryInterface commandersRepositoryInterface = CommandersRepository(apiClient: Get.find(), sharedPreferences: prefs);

//   // Get.lazyPut(()=> commandersRepositoryInterface);

//   // CommandersService commandersService = CommandersService( commandersServiceInterface: Get.find());

//   // CommandersServiceInterface commandersServiceInterface = CommandersService(commandersServiceInterface: Get.find());


//   // Get.lazyPut(() => commandersService);

//   // Get.lazyPut(()=> CommandersController(Get.find()));

//   // Get.lazyPut(() => commandersService);
// Get.lazyPut(()=> CommandersRepository(apiClient: Get.find(), sharedPreferences: prefs));

//   CommandersRepositoryInterface testRepositoryInterface = CommandersRepository(apiClient: Get.find(), sharedPreferences: prefs);

//   Get.lazyPut(()=> testRepositoryInterface);

//   CommandersServiceInterface testCentreServiceInterface = CommandersService(commandersRepositoryInterface: Get.find());

//   Get.lazyPut(() => testCentreServiceInterface);

//   Get.lazyPut(()=> CommandersController(commandersServiceInterface: Get.find()));

//   Get.lazyPut(()=> CommandersService(commandersRepositoryInterface: Get.find()));


//   // //////////// Setting Service, Repository and Controller ////////////////////////////////

//   // //////////// Test Centre Service, Repository and Controller ////////////////////////////////

//   // Get.lazyPut(()=> TestRepository(apiClient: Get.find(), sharedPreferences: prefs));

//   // TestRepositoryInterface testRepositoryInterface = TestRepository(apiClient: Get.find(), sharedPreferences: prefs);

//   // Get.lazyPut(()=> testRepositoryInterface);

//   // TestCentreServiceInterface testCentreServiceInterface = TestCentreService(testRepositoryInterface: Get.find());

//   // Get.lazyPut(() => testCentreServiceInterface);

//   // Get.lazyPut(()=> TestCentreController(testCentreServiceInterface: Get.find()));

//   // Get.lazyPut(()=> TestCentreService(testRepositoryInterface: Get.find()));

//   //////////// Test Centre Service, Repository and Controller ////////////////////////////////
// }
