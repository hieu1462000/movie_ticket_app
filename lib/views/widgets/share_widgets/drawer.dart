import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/model_views/booking_service.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  Future toTicketScreen() async {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 141, 19, 11),
            ),
          );
        });
    await bookingService.getListTicketFromApi(user.uid);
    //await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/ticket');
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 15, 10, 10).withOpacity(0.8),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 15, 10, 10).withOpacity(0.6),
            ),
            accountName: Text(
              user.displayName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              user.email!,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cgv.png'),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade800,
          ),
          ListTile(
            leading: const Icon(
              Icons.movie_outlined,
              color: Colors.white,
            ),
            visualDensity: const VisualDensity(vertical: -4),
            title: const Text('Booking movie',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              Provider.of<BookingService>(context, listen: false).isSigleMovie =
                  false;
              movieService.selectedMovie = null;
              movieService.selectedMovieId = "";
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/showtime');
            },
          ),
          Divider(
            color: Colors.grey.shade800,
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.white,
            ),
            visualDensity: const VisualDensity(vertical: -4),
            title: const Text('Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              movieService.selectedMovie = null;
              movieService.selectedMovieId = "";
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          Divider(
            color: Colors.grey.shade800,
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.tickets,
              color: Colors.white,
            ),
            visualDensity: const VisualDensity(vertical: -4),
            title: const Text('My tickets',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              movieService.selectedMovie = null;
              movieService.selectedMovieId = "";
              Navigator.of(context).pop();
              toTicketScreen();
            },
          ),
          Divider(
            color: Colors.grey.shade800,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            visualDensity: const VisualDensity(vertical: -4),
            title: const Text('Log out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            onTap: () {
              movieService.selectedMovie = null;
              movieService.selectedMovieId = "";
              FirebaseAuth.instance.signOut();
            },
          ),
          Divider(
            color: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }
}
