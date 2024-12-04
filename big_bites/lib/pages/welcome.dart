import 'dart:ui';
import 'package:big_bites/pages/create_an_account/bloc/create_an_account_bloc.dart';
import 'package:big_bites/pages/create_an_account/create_an_account.dart';
import 'package:big_bites/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:big_bites/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/authentication_bloc/authentication_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
	late TabController tabController;

	@override
  void initState() {
    tabController = TabController(
			initialIndex: 0,
			length: 2, 
			vsync: this
		);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							Align(
								alignment: const AlignmentDirectional(20, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width,
									width: MediaQuery.of(context).size.width,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.tertiary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.primary
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
							Align(
								alignment: Alignment.center,
								child: SizedBox(
									height: MediaQuery.of(context).size.height / 1.8,
									child: Column(
										children: [
											Padding(
												padding: const EdgeInsets.symmetric(horizontal: 50.0),
												child: TabBar(
													controller: tabController,
													unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
													labelColor: Theme.of(context).colorScheme.onBackground,
													tabs: const [
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign In',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign Up',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
													],
												),
											),
											Expanded(
												child: TabBarView(
													controller: tabController,
													children: [
														BlocProvider<SignInBloc>(
															create: (context) => SignInBloc(
																context.read<AuthenticationBloc>().userRepository
															),
															child: const SignInPage(),
														),
														BlocProvider<SignUpBloc>(
															create: (context) => SignUpBloc(
																context.read<AuthenticationBloc>().userRepository
															),
															child: const CreateAnAccountPage(),
														),
													],
												)
											)
										],
									),
								),
							)
						],
					),
				),
			),
		);
  }
}










// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class WelcomePage extends StatefulWidget {
//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   final user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           // Top Surface Image
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/images/welcome/top_surface.png',
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),

//           // Center Texts
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   ("Hey ${user!.email}"),
//                   style: TextStyle(
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                     color: Color(0xFFFFFFFF),
//                   ),
//                 ),
//                 SizedBox(height: 10), // Space between the texts
//                 Text(
//                   "Welcome to Big Bites",
//                   style: TextStyle(
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 28,
//                     color: Color(0xFF1E1E1E),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
