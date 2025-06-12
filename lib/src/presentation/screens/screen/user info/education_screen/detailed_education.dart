import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/next_back_buttuns.dart';
import 'next_back_buttons.dart';

class DetailedEducation extends StatelessWidget {
  const DetailedEducation({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<EducationViewmodelNew>();

    return BlocListener<EducationViewmodelNew, EducationState>(
      listener: (context, state) {
        if (state is EducationAddedState) {
          viewModel.pageController.jumpToPage(viewModel.currentPage);
        }
      },
      child: BlocBuilder<EducationViewmodelNew, EducationState>(
        builder: (context, state) {
          return Column(
            children: [
              // PageView with PageController
              Expanded(
                child: PageView.builder(
                  controller: viewModel.pageController,
                  onPageChanged: (index) {
                    viewModel.changePage(index);
                  },
                  itemCount: viewModel.pages.length,
                  itemBuilder: (context, index) {
                    return viewModel.pages[index];
                  },
                ),
              ),
              // // Navigation Buttons
              // NextBackButtuns(
              //   finish: () {
              //     viewModel.nextButton();
              //   },
              //   pageController: _pageController,
              //   length: viewModel.pages.length,
              //   changePage: viewModel.changePage,
              //   currentPage: viewModel.currentPage,
              // ),
              NextBackButtons(
                currentPage: viewModel.currentPage,
                length: viewModel.pages.length,
                onNext: viewModel.currentPage < viewModel.pages.length - 1
                    ? viewModel.nextPage
                    : viewModel.nextButton,
                onBack: viewModel.previousPage,
              ),
              verticalSpace(24),
            ],
          );
        },
      ),
    );
  }
}
