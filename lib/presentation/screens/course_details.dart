import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teacher/core/constants/colors_manager.dart';
import '../bloc/upload_video/cubit.dart';
import '../bloc/upload_video/state.dart';

class CourseDetails extends StatelessWidget {
  final int courseId;
  const CourseDetails({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploadVideoCubit(),
      child:  _CourseDetailsView(courseId),
    );
  }
}

class _CourseDetailsView extends StatelessWidget {
  final int courseId;
  const _CourseDetailsView(this.courseId);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: CourseTabs.values.length,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _CourseBanner(),
                const _CourseHeader(),
                const _CourseInfoRow(),
                const _TabBarSection(),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: CourseTabs.values.map((tab) {
                      return switch (tab) {
                        CourseTabs.details => const _DetailsTab(),
                        CourseTabs.videos =>  _VideosTab(courseId),
                        CourseTabs.notes => const _NotesTab(),
                      };
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum CourseTabs { details, videos, notes }

class _CourseBanner extends StatelessWidget {
  const _CourseBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/course_banner.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Course name',
            style:TextTheme.of(context).headlineLarge?.copyWith(color: AppColors.primary)
          ),
          const SizedBox(height: 8),
          Text(
            'Description of the course',
            style: TextTheme.of(context).titleMedium
          ),
        ],
      ),
    );
  }
}

class _CourseInfoRow extends StatelessWidget {
  const _CourseInfoRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InfoTile(label: 'Duration', value: '5 hours'),
          _InfoTile(label: 'Videos', value: '12'),
          _InfoTile(label: 'Category', value: 'Programming'),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _TabBarSection extends StatelessWidget {
  const _TabBarSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: TabBar(
        tabs: CourseTabs.values.map((tab) {
          return Tab(
            child: Text(
              tab.name.capitalize(),
              style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }
}

class _DetailsTab extends StatelessWidget {
  const _DetailsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        'Here are the full details about the course, what the student will learn, requirements, and expected outcomes. This section is designed in an attractive way with clear fonts for easy reading.',
        style: GoogleFonts.cairo(fontSize: 14),
      ),
    );
  }
}

class _VideosTab extends StatelessWidget {
  final int courseId;
  const _VideosTab(this.courseId);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UploadVideoCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          BlocConsumer<UploadVideoCubit, UploadVideoState>(
            listener: (context, state) {
              if (state is SuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Video uploaded successfully')),
                );
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              double progress = 0.0;
              if (state is UploadProgressState) {
                progress = state.progress;
              }

              return Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await cubit.pickVideo();
                      if (cubit.pickedFile != null) {
                        await cubit.uploadVideo(courseId);
                      }
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Video'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (progress > 0 && progress < 1)
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.surface,
                      color: AppColors.primary,
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          const Expanded(child: _VideoList()),
        ],
      ),
    );
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList();

  @override
  Widget build(BuildContext context) {
    final videos = [
      'Course Introduction',
      'Overview',
      'Installing Tools',
      'Writing Your First Code',
    ];

    return ListView.separated(
      itemCount: videos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) => _VideoListItem(title: videos[index]),
    );
  }
}

class _VideoListItem extends StatelessWidget {
  final String title;

  const _VideoListItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surface),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const _VideoActions(),
        ],
      ),
    );
  }
}

class _VideoActions extends StatelessWidget {
  const _VideoActions();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _VideoActionButton(
          icon: Icons.play_circle_fill,
          color: AppColors.primary,
        ),
        _VideoActionButton(icon: Icons.edit, color: AppColors.accent),
        _VideoActionButton(icon: Icons.delete, color: AppColors.error),
      ],
    );
  }
}

class _VideoActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _VideoActionButton({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: () {
        // TODO: implement action
      },
    );
  }
}

class _NotesTab extends StatelessWidget {
  const _NotesTab();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notes coming soon', style: GoogleFonts.cairo()));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
