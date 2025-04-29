import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';

class SalaryRangeWidget extends StatelessWidget {
  const SalaryRangeWidget({super.key, required this.salaryRangeValue});
  final String salaryRangeValue;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localization.salaryRange,
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              salaryRangeValue,
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
