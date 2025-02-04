import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';

import '../../../../../../core/styles/spacing.dart';
import '../../../../shared_widgets/next_back_buttuns.dart';

class DetailedEducation extends StatefulWidget {
  const DetailedEducation({super.key});

  @override
  State<DetailedEducation> createState() => _DetailedEducationState();
}

class _DetailedEducationState extends State<DetailedEducation> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<EducationViewmodelNew>();

    return BlocListener<EducationViewmodelNew, EducationState>(
      listener: (context, state) {
        if (state is EducationAddedState) {
          _pageController.jumpToPage(viewModel.currentPage);
        }
      },
      child: BlocBuilder<EducationViewmodelNew, EducationState>(
        builder: (context, state) {
          return Column(
            children: [
              // PageView with PageController
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    viewModel.changePage(index);
                  },
                  itemCount: viewModel.pages.length,
                  itemBuilder: (context, index) {
                    return viewModel.pages[index];
                  },
                ),
              ),
              // Navigation Buttons
              NextBackButtuns(
                finish: () {},
                pageController: _pageController,
                length: viewModel.pages.length,
                changePage: viewModel.changePage,
                currentPage: viewModel.currentPage,
              ),
              verticalSpace(24),
            ],
          );
        },
      ),
    );
  }
}
