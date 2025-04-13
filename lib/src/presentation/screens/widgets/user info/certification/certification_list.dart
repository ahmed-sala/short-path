import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';
import 'package:short_path/src/presentation/shared_widgets/toast_dialoge.dart'; // for .sp, .h, and .w extensions

class CertificationList extends StatelessWidget {
  final List<CertificationEntity> certifications;

  final void Function(CertificationEntity certification) onRemove;

  final void Function(CertificationEntity certification) onUndo;

  final Color primaryColor;

  const CertificationList({
    Key? key,
    required this.certifications,
    required this.onRemove,
    required this.onUndo,
    this.primaryColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.addedCertifications,
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
                      '${context.localization.issuedBy}: ${certification.issuingOrganization}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '${context.localization.dateEarned}: ${certification.dateEarned}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '${context.localization.expirationDate}: ${certification.expirationDate}',
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
                                    '${certification.certificationName} ${context.localization.removedSuccessfully}'),
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  label: context.localization.undo,
                                  onPressed: () {
                                    scaffoldMessenger.hideCurrentSnackBar();
                                    onUndo(certification);
                                    ToastDialog.show(
                                        '${certification.certificationName} ${context.localization.addedBack}',
                                        Colors.green);
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
