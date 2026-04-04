import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/activated_packages.dart';

class ActivatedPackageCard extends StatelessWidget {
  final ActivatedPackageModel package;

  const ActivatedPackageCard({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان + السعر
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    package.packageName,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // الحدود (Internet, Calls, SMS)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildLimitItem(Icons.wifi, "Internet", "${package.internetLimit.toStringAsFixed(2)} GB"),
                  ),
                  Expanded(
                    child: _buildLimitItem(Icons.call, "Calls", "${package.callLimit} min"),
                  ),
                  Expanded(
                    child: _buildLimitItem(Icons.sms, "SMS", "${package.smsLimit}"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // تاريخ التفعيل + المصدر + السعر
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.date_range, color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "Activated: ${package.activationDate}",
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.source, color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "Source: ${package.source}",
                            style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "${package.price.toStringAsFixed(0)} SYP",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[600]),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
