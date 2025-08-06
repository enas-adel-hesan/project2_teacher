import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/colors_manager.dart';
import 'courses.dart';

// Cubits
class SidebarCubit extends Cubit<bool> {
  SidebarCubit() : super(true);

  void toggle() => emit(!state);
}

class SelectedItemCubit extends Cubit<int> {
  SelectedItemCubit() : super(0);

  void selectItem(int index) => emit(index);
}

// Main Widget
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SidebarCubit()),
        BlocProvider(create: (_) => SelectedItemCubit()),
      ],
      child: Scaffold(

        body: Row(
          children: const [
            AnimatedSidebar(),
            Expanded(child: Scaffold(body: Courses())),
          ],
        ),
      ),
    );
  }
}

// Sidebar Widget
class AnimatedSidebar extends StatelessWidget {
  const AnimatedSidebar({super.key});

  static const _sidebarItems = [
    SidebarItemData(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    SidebarItemData(icon: Icons.book_outlined, label: 'Courses'),
    SidebarItemData(icon: Icons.people_outline, label: 'Students'),
    SidebarItemData(icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, bool>(
      builder: (context, isExpanded) {
        return AnimatedContainer(
          duration: 500.ms,
          curve: Curves.easeInOut,
          width: isExpanded ? 250 : 80,
          height: double.infinity,
          decoration: _buildSidebarDecoration(),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  _buildToggleButton(context, isExpanded),
                  const SizedBox(height: 30),
                  ..._buildSidebarItems(isExpanded),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildSidebarDecoration() {
    return BoxDecoration(

      gradient: const LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context, bool isExpanded) {
    return IconButton(
      icon: Icon(
        isExpanded ? Icons.arrow_back_ios_new_rounded : Icons.menu_rounded,
        color: Colors.white,
        size: 28,
      ),
      onPressed: () => context.read<SidebarCubit>().toggle(),
      tooltip: isExpanded ? 'Collapse Sidebar' : 'Expand Sidebar',
      splashRadius: 24,
      hoverColor: Colors.white70,
    );
  }

  List<Widget> _buildSidebarItems(bool isExpanded) {
    return List.generate(
      _sidebarItems.length,
      (index) => SidebarItem(
        data: _sidebarItems[index],
        isExpanded: isExpanded,
        index: index,
      ),
    ).animate(interval: 100.ms).fade(duration: 300.ms).slideX(begin: -0.2);
  }
}

// Sidebar Item Data Model
class SidebarItemData {
  final IconData icon;
  final String label;

  const SidebarItemData({required this.icon, required this.label});
}

// Sidebar Item Widget
class SidebarItem extends StatefulWidget {
  final SidebarItemData data;
  final bool isExpanded;
  final int index;

  const SidebarItem({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.index,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedItemCubit, int>(
      builder: (context, selectedIndex) {
        final isSelected = selectedIndex == widget.index;
        final colors = _getItemColors(context, isSelected);

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: () =>
                context.read<SelectedItemCubit>().selectItem(widget.index),
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.deepPurple.shade300.withAlpha(64),
            highlightColor: Colors.deepPurple.shade100.withAlpha(25),
            child:
                AnimatedContainer(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      duration: 300.ms,
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.isExpanded ? 32 : 6,
                        vertical: 16,
                      ),
                      decoration: _buildItemDecoration(
                        isSelected,
                        colors.backgroundColor,
                      ),
                      child: _buildItemContent(colors),
                    )
                    .animate(target: isSelected ? 1.05 : 1)
                    .scale(duration: 300.ms, curve: Curves.easeOutBack),
          ),
        );
      },
    );
  }

  _ItemColors _getItemColors(BuildContext context, bool isSelected) {
    return _ItemColors(
      backgroundColor: isSelected
          ? AppColors.primary
          : _isHovering
          ? Colors.deepPurple.withValues(alpha: 0.35)
          : Colors.transparent,
      iconColor: isSelected || _isHovering ? Colors.white : Colors.white70,
      textColor: isSelected || _isHovering ? Colors.white : Colors.white70,
    );
  }

  BoxDecoration _buildItemDecoration(bool isSelected, Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: Colors.deepPurple.shade700.withValues(alpha: 0.6),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
      border: isSelected
          ? Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5)
          : null,
    );
  }

  Widget _buildItemContent(_ItemColors colors) {
    return Row(
      children: [
        Icon(widget.data.icon, color: colors.iconColor, size: 25),
        if (widget.isExpanded) ...[
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              widget.data.label,
              style: _buildItemTextStyle(colors.textColor),
            ),
          ),
        ],
      ],
    );
  }

  TextStyle _buildItemTextStyle(Color textColor) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 15,
      letterSpacing: 0.75,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.15),
          offset: const Offset(0, 1),
          blurRadius: 3,
        ),
      ],
    );
  }
}

// Helper class for item colors
class _ItemColors {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const _ItemColors({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });
}
