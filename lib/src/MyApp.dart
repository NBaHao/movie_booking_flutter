
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'blocs/NavigationBloc.dart';
import 'screens/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(252, 196, 52, 1),
            brightness: Brightness.dark,
            secondary: const Color.fromRGBO(252, 196, 52, 1),
            primary: const Color.fromRGBO(252, 196, 52, 1)),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodySmall:
              TextStyle(color: Color.fromRGBO(242, 242, 242, 1), fontSize: 12),
          bodyLarge:
              TextStyle(color: Color.fromRGBO(242, 242, 242, 1), fontSize: 16),
        ),
        useMaterial3: true,
      ),
      home: const MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, int>(builder: (context, state) {
      return Scaffold(
        body: switch (state) {
          0 => const HomePage(userId: 'harohienlanh'),
          1 => const Center(child: Text('Ticket Page')),
          2 => const Center(child: Text('Movie Page')),
          _ => const Center(child: Text('Profile Page')),
        },
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: const Color.fromRGBO(204, 204, 204, 1),
          selectedLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          currentIndex: state,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icon_home.svg'),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icon_ticket.svg'),
                label: 'Ticket',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icon_video.svg'),
                label: 'Movie',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icon_user.svg'),
                label: 'Profile',
                backgroundColor: Colors.black),
          ],
          onTap: (index) {
            context.read<NavigationBloc>().add(NavigationEvent(index));
          },
        ),
      );
    });
  }
}
