import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/home/home_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/short_path.dart';

import '../../widgets/home/offer_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeViewmodel homeViewmodel = getIt<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        homeViewmodel.getUserData();
        homeViewmodel.getAllJobs();
        return homeViewmodel;
      },
      child: BlocBuilder<HomeViewmodel, HomeState>(
        builder: (context, state) {
          if (state is SessionExpired) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Session Expired',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomAuthButton(
                  text: 'Go to login',
                  onPressed: () {
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.login, (route) => false);
                  },
                  color: AppColors.primaryColor,
                ),
              ],
            );
          }
          if (state is UserDataError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (state is JobsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: height * 0.06, left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${homeViewmodel.appUser?.firstName ?? ''} ${homeViewmodel.appUser?.lastName ?? ''}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Redesigned Offer Banner
              OfferCard(),
              SizedBox(height: 20),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: homeViewmodel.jobs?.length ?? 0,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(homeViewmodel.jobs![index].title ?? ''),
              //         subtitle: Text(homeViewmodel.jobs![index].image ?? 'xy'),
              //       );
              //     },
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
