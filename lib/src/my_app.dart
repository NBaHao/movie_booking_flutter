import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_booking/src/blocs/configuration_bloc/configuration_state.dart';
import 'package:movie_booking/src/blocs/data_load_bloc/data_load_bloc.dart';
import 'package:movie_booking/src/blocs/navigation_bloc/navigation_state.dart';
import 'package:movie_booking/src/blocs/search_bloc/search_bloc.dart';
import 'package:movie_booking/src/screens/configuration_screen.dart';
import 'package:movie_booking/src/screens/movie_details_screen.dart';
import 'package:movie_booking/src/screens/movies_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/configuration_bloc/configuration_bloc.dart';
import 'blocs/navigation_bloc/navigation_bloc.dart';
import 'blocs/navigation_bloc/navigation_event.dart';
import 'models/movie.dart';
import 'screens/home_page.dart';
import 'screens/movie_searching_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie Booking',
            initialRoute: '/',
            onGenerateRoute: (settings) {
              final args = settings.arguments;
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                      builder: (context) => const MainContent());
                case '/movie_details':
                  return MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailsScreen(movie: args as Movie));
                case '/configuration':
                  return MaterialPageRoute(
                      builder: (context) =>
                          const ConfigurationScreen());
                case '/searching':
                  return MaterialPageRoute(
                      builder: (context) => BlocProvider<SearchBloc>(
                            create: (context) =>
                                SearchBloc(args as List<Movie>),
                            child: const MovieSearchingScreen(),
                          ));
                default:
                  return null;
              }
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromRGBO(252, 196, 52, 1),
                  brightness: Brightness.dark,
                  secondary: const Color.fromRGBO(252, 196, 52, 1),
                  primary: const Color.fromRGBO(252, 196, 52, 1)),
              scaffoldBackgroundColor: Colors.black,
              textTheme: const TextTheme(
                bodySmall: TextStyle(
                    color: Color.fromRGBO(242, 242, 242, 1), fontSize: 12),
                bodyLarge: TextStyle(
                    color: Color.fromRGBO(242, 242, 242, 1), fontSize: 16),
              ),
              useMaterial3: true,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: switch (state.languageCode) {
              'en' => const Locale('en', 'US'),
              'vi' => const Locale('vi', 'VN'),
              _ => const Locale('en', 'US')
            },
            home: const MainContent());
      },
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    // final String languageCode = Localizations.localeOf(context).languageCode;
    return BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        return Scaffold(
          body: switch (state.currentPage) {
            NavigationStateEnum.homePage => BlocProvider<DataLoadBloc>(
                create: (context) => DataLoadBloc(),
                child: const HomePage(userId: 'harohienlanh')),
            NavigationStateEnum.ticketPage =>
              const Center(child: Text('Ticket Page')),
            NavigationStateEnum.moviePage => BlocProvider<DataLoadBloc>(
                create: (context) => DataLoadBloc(),
                child: Center(
                    child:
                        (state as NavigationMoviePageState).currentMoviePage ==
                                TabMovieStateEnum.comingSoon
                            ? const MoviesScreen(
                                firstTab: TabMovieStateEnum.comingSoon)
                            : const MoviesScreen(
                                firstTab: TabMovieStateEnum.nowPlaying)),
              ),
            NavigationStateEnum.profilePage =>
              const Center(child: Text('Profile Page')),
          },
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: const Color.fromRGBO(204, 204, 204, 1),
            selectedLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            currentIndex: state.currentPage.index,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon_home.svg'),
                  label: AppLocalizations.of(context)!.home,
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon_ticket.svg'),
                  label: AppLocalizations.of(context)!.ticket,
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon_video.svg'),
                  label: AppLocalizations.of(context)!.movie,
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon_user.svg'),
                  label: AppLocalizations.of(context)!.profile,
                  backgroundColor: Colors.black),
            ],
            onTap: (index) {
              if (index == 2) {
                context.read<NavigationBloc>().add(
                    MoviePageWithTabEvent(index, TabMovieStateEnum.nowPlaying));
              } else {
                context
                    .read<NavigationBloc>()
                    .add(SwitchNavigationEvent(index));
              }
            },
          ),
        );
      }),
    );
  }
}
