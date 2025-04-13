import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/domain/entities/user_info/Certification_Entity.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../profile_shared_widgets.dart';

class CertificationCard extends StatelessWidget {
  final CertificationEntity cert;
  final String Function(DateTime?) formatDate;

  const CertificationCard(
      {required this.cert, required this.formatDate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableWidgets.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.badge, size: 30, color: AppColors.primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert.certificationName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cert.issuingOrganization,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "${context.localization.earned}: ${formatDate(cert.dateEarned)}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.timer_off_rounded,
                size: 20,
                color: cert.expirationDate == null ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                cert.expirationDate == null
                    ? context.localization.noExpiration
                    : "${context.localization.expires}: ${formatDate(cert.expirationDate)}",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      cert.expirationDate == null ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
