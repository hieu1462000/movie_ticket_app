import 'package:flutter/material.dart';
import 'package:movie_ticket/app_view.dart';
import 'package:movie_ticket/model_views/auth_service.dart';
import 'package:movie_ticket/model_views/booking_service.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:movie_ticket/models/auth_user_model.dart';
import 'package:movie_ticket/views/screens/booking_seat_screen.dart';
import 'package:movie_ticket/views/screens/buying_snack_screen.dart';
import 'package:movie_ticket/views/screens/detail_advertisement_screen.dart';
import 'package:movie_ticket/views/screens/detail_movie_screen.dart';
import 'package:movie_ticket/views/screens/my_ticket_screen.dart';
import 'package:movie_ticket/views/screens/payment_screen.dart';
import 'package:movie_ticket/views/screens/showtime_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MovieService()),
      ChangeNotifierProvider(create: (context) => BookingService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return StreamProvider<AuthUserModel?>.value(
          value: AuthService().user,
          initialData: null,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => AppView(),
              '/movie': (context) => const DetailMovieScreen(),
              '/showtime': (context) => const ShowtimeScreen(),
              '/booking': (context) => const BookingSeatScreen(),
              '/snack': (context) => const SnackScreen(),
              '/ad': (context) => const DetailAdvertisementScreen(),
              '/payment': (context) => const PaymentScreen(),
              '/ticket': (context) => MyTicketScreen()
            },
          ));
    });
  }
}
