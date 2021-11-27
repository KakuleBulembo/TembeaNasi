import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembea/screens/admin/admin_screens/event/dashboard_event.dart';
import 'package:tembea/screens/admin/admin_screens/library/dashboard_library.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/dashboard_restaurant.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/restaurant_main_form.dart';
import 'package:tembea/screens/auth/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/admin/admin_screens/dashboard_screen.dart';
import 'constants.dart';
import 'components/menu_controller.dart';
import 'screens/user/user_home.dart';
import 'screens/admin/admin_screens/event/event_form.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
      child : const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        canvasColor: kSecondaryColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => const WelcomeScreen(),
        LoginScreen.id : (context) => const LoginScreen(),
        RegistrationScreen.id : (context) => const RegistrationScreen(),
        DashboardScreen.id : (context) => const DashboardScreen(),
        UserHome.id : (context) => const UserHome(),
        EventForm.id : (context) => const EventForm(),
        DashboardEvent.id : (context) => const DashboardEvent(),
        DashboardRestaurant.id : (context) => const DashboardRestaurant(),
        DashboardLibrary.id: (context) => const DashboardLibrary(),
        RestaurantMainForm.id : (context) => const RestaurantMainForm(),
      },
    );

  }
}
