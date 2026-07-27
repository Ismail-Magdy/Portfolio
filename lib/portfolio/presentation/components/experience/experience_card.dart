import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.experience,
    required this.index,
    required this.total,
    required this.isMobile,
  });
  final ExperienceModel experience;
  final int index;
  final int total;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(bottom: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 40,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          // Timeline indicator
          Column(
            children: [
              //
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: .circle,
                  border: .all(color: AppColors.backgroundDark, width: 3),
                ),
              ),
              //
              if (index < total - 1)
                //
                Container(
                  width: 2,
                  height: isMobile ? 200 : 150,
                  color: AppColors.primary.withValues(alpha: 0.3),
                  margin: const .symmetric(vertical: 8),
                ),
              //
            ],
          ),
          //
          horizontalSpace(24),
          //
          // Experience Card
          Expanded(
            child: Card(
              elevation: 2,
              color: AppColors.cardBackgroundDark,
              shape: RoundedRectangleBorder(borderRadius: .circular(12)),
              child: Padding(
                padding: const .all(24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    //
                    Text(
                      experience.period,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.textDark.withValues(alpha: 0.6),
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      experience.title,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: .bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    //
                    verticalSpace(4),
                    //
                    Text(
                      experience.company,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: AppColors.textDark,
                      ),
                    ),
                    //
                    verticalSpace(16),
                    //
                    Text(
                      experience.description,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        height: 1.6,
                        color: AppColors.textDark.withValues(alpha: 0.8),
                      ),
                    ),
                    //
                    verticalSpace(20),
                    //
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: experience.technologies
                          .map(
                            (tech) => Container(
                              padding: const .symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: .circular(20),
                                border: .all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: .w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
