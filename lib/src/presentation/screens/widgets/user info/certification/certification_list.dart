import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart'; // for .sp, .h, and .w extensions

class CertificationList extends StatelessWidget {
  /// The list of certifications to display.
  final List<CertificationEntity> certifications;

  /// Called when a certification should be removed.
  final void Function(CertificationEntity certification) onRemove;

  /// Called when a removed certification should be restored.
  final void Function(CertificationEntity certification) onUndo;

  /// The header text above the list.
  final String headerText;

  /// The primary color used for card borders and text.
  final Color primaryColor;

  const CertificationList({
    Key? key,
    required this.certifications,
    required this.onRemove,
    required this.onUndo,
    this.headerText = 'Added Certifications:',
    this.primaryColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: certifications.length,
          itemBuilder: (context, index) {
            final certification = certifications[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: primaryColor, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certification.certificationName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Issued by: ${certification.issuingOrganization}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Date Earned: ${certification.dateEarned}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Expiration Date: ${certification.expirationDate}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final scaffoldMessenger =
                                ScaffoldMessenger.maybeOf(context);
                            if (scaffoldMessenger == null) {
                              debugPrint('ScaffoldMessenger not found.');
                              return;
                            }
                            scaffoldMessenger.hideCurrentSnackBar();

                            // Call the removal callback.
                            onRemove(certification);

                            // Show a SnackBar with an undo action.
                            scaffoldMessenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${certification.certificationName} removed!'),
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    scaffoldMessenger.hideCurrentSnackBar();
                                    onUndo(certification);
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${certification.certificationName} restored!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
