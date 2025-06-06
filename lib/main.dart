import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/data/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc_bloc.dart';
import 'package:rest_api/data/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:rest_api/data/presentation/auth/login/login_bloc.dart';
import 'package:rest_api/data/presentation/auth/register/register_bloc.dart';
import 'package:rest_api/data/repository/auth_repository.dart';
import 'package:rest_api/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:rest_api/data/repository/profile_buyerRepository.dart';
import 'package:rest_api/data/presentation/auth/login_screen.dart';
import 'package:rest_api/services/services_http_client.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository(ServicesHttpClient())),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(authRepository: AuthRepository(ServicesHttpClient())),
        ),
        BlocProvider(
          create: (context) => ProfileBuyerBloc(profileBuyerRepository: ProfileBuyerRepository(ServicesHttpClient())),
        ),
        BlocProvider(
          create: (context) => GetBurungTersediaBlocBloc(
            GetAllBurungTersediaRepository(ServicesHttpClient()),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
