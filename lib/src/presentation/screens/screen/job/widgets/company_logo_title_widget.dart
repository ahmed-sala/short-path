import '../../../../../../core/common/common_imports.dart';
import '../../../../shared_widgets/image_widget.dart';

class CompanyLogoTitleWidget extends StatelessWidget {
  const CompanyLogoTitleWidget(
      {super.key, this.imageUrl, required this.jobTitle});
  final String? imageUrl;
  final String jobTitle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ImageWidget(
            imageUrl: imageUrl,
          ),
          SizedBox(height: 12.h),
          Text(
            jobTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
