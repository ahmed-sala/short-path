import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../core/common/common_imports.dart';
import '../../../../../core/styles/colors/app_colore.dart';
import '../../../mangers/home/home_viewmodel.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var homeViewmodel = context.watch<HomeViewmodel>();
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(top: height * 0.06, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
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
            context.localization.welcome,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 5),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${homeViewmodel.appUser?.firstName ?? ''} ${homeViewmodel.appUser?.lastName ?? ''}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
