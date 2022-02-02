import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tembea/screens/admin/admin_screens/cinema/dashboard_cinema.dart';
import 'package:tembea/screens/admin/admin_screens/cinema/form/cinema_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/event/dashboard_event.dart';
import 'package:tembea/screens/admin/admin_screens/event/form/event_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/games/dashboard_game.dart';
import 'package:tembea/screens/admin/admin_screens/games/form/game_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/gyms/dashboard_gyms.dart';
import 'package:tembea/screens/admin/admin_screens/gyms/form/gym_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/hotels/dashboard_hotel.dart';
import 'package:tembea/screens/admin/admin_screens/hotels/form/hotel_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/library/dashboard_library.dart';
import 'package:tembea/screens/admin/admin_screens/pools/dashboard_pool.dart';
import 'package:tembea/screens/admin/admin_screens/pools/form/pool_main_form.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/dashboard_restaurant.dart';
import 'package:tembea/screens/admin/admin_screens/restaurant/form/restaurant_main_form.dart';
import 'package:tembea/screens/auth/login_screen.dart';
import 'package:tembea/screens/user/interest.dart';
import 'package:tembea/screens/user/user_dashboard.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/admin/admin_screens/dashboard_screen.dart';
import 'constants.dart';
import 'components/menu_controller.dart';
import 'screens/user/user_home.dart';

// Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
//   print(message.data);
//   AwesomeNotifications().createNotification(
//       content: NotificationContent( //with image from URL
//           id: 1,
//           channelKey: 'basic', //channel configuration key
//           title: message.data["title"],
//           body: message.data["body"],
//           bigPicture: message.data["image"],
//           notificationLayout: NotificationLayout.BigPicture,
//           payload: {"name":"flutter"}
//       )
//   );
// }
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
        EventMainForm.id : (context) =>const EventMainForm(),
        DashboardEvent.id : (context) => const DashboardEvent(),
        DashboardRestaurant.id : (context) => const DashboardRestaurant(),
        DashboardLibrary.id: (context) => const DashboardLibrary(),
        RestaurantMainForm.id : (context) => const RestaurantMainForm(),
        DashboardHotel.id : (context) => const DashboardHotel(),
        HotelMainForm.id : (context) => const HotelMainForm(),
        DashboardGame.id : (context) => const DashboardGame(),
        GameMainForm.id : (context) => const GameMainForm(),
        DashboardGyms.id :(context) => const DashboardGyms(),
        GymMainForm.id :(context) =>const GymMainForm(),
        DashboardCinema.id :(context) =>const DashboardCinema(),
        CinemaMainForm.id :(context) =>const CinemaMainForm(),
        DashboardPool.id :(context) =>const DashboardPool(),
        PoolMainForm.id :(context) =>const PoolMainForm(),
        UserDashboard.id : (context) => const UserDashboard(),
        Interest.id : (context) => const Interest(),
      },
    );

  }
}
