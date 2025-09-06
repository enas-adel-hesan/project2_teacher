import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:teacher/core/constants/colors_manager.dart';
import '../../data/models/my_courses_model.dart';

class CourseCard extends StatelessWidget {
  final Data course;
  final bool published;
  final VoidCallback? onInfo;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CourseCard({
    super.key,
    required this.course,
    required this.published,
    this.onInfo,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(

        alignment: Alignment.center,
        children: [
          // نبض واضح للخلفية إذا منشور
          if (published)
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent.withOpacity(0.3),
                  ),
                )
                    .animate(onPlay: (c) => c.loop(reverse: true))
                    .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.3, 1.3),
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                )
                    .fade(
                  begin: 0.6,
                  end: 0.0,
                  duration: 900.ms,
                  curve: Curves.easeInOut,
                ),
              ),
            ),

          // الكارد الأبيض
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: onInfo,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // أيقونة الكورس الكبيرة
                      Center(
                        child: Icon(
                          Icons.screen_search_desktop_rounded,
                          color: AppColors.accent,
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // العنوان
                      Text(
                        course.name ?? "Untitled Course",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // السعر
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${course.price} \$",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // الوصف
                      Text(
                        course.description ?? "No description available",
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),

                      // أيقونات الإجراءات
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _ActionIcon(icon: Icons.info_outline, onTap: onInfo),
                          const SizedBox(width: 10),
                          if (!published)
                            _ActionIcon(icon: Icons.edit, onTap: onEdit),
                          if (!published) const SizedBox(width: 10),
                          if (!published)
                            _ActionIcon(icon: Icons.delete_outline, onTap: onDelete),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // بادج Published
          if (published)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 16, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      "Published",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms).scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 300.ms,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _ActionIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.black87, size: 20),
      ),
    )
        .animate(onPlay: (c) => c.loop(reverse: true))
        .scale(
      begin: const Offset(1, 1),
      end: const Offset(1.15, 1.15),
      duration: 250.ms,
      curve: Curves.easeInOut,
    )
        .fade(begin: 0.8, end: 0.6, duration: 250.ms);
  }
}
