import 'package:flutter/material.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/snack_bar.dart';

class PortfolioInput extends StatelessWidget {
  const PortfolioInput({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: TextFormField(
              controller: viewModel.portfolioController,
              keyboardType: TextInputType.url,
              validator: (value) => null,
              decoration: InputDecoration(
                prefixIcon:
                const Icon(Icons.link_rounded, color: Colors.blueAccent),
                labelText: 'Portfolio URL',
                labelStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
                hintText: 'Enter your portfolio URL (GitHub, Behance, etc.)',
                hintStyle: TextStyle(color: Colors.grey[400]),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              onPressed: () {
                if (!viewModel
                    .checkValidLink(viewModel.portfolioController.text)) {
                  showSnackBar(context, 'Invalid link', Colors.red);
                  viewModel.portfolioController.clear();
                  return;
                }
                if (viewModel.portfolioController.text.isNotEmpty) {
                  viewModel.addPortfolioLink(
                      viewModel.portfolioController.text);
                }
                viewModel.portfolioController.clear();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.white, size: 24),
                  SizedBox(width: 6),
                  Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}