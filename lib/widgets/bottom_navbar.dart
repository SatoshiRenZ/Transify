import 'package:flutter/material.dart';
import '../styles/style.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: AppColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            index: 0,
          ),
          buildNavItem(
            icon: Icons.confirmation_number_outlined,
            activeIcon: Icons.confirmation_number,
            index: 1,
          ),
          buildNavItem(
            icon: Icons.history_outlined,
            activeIcon: Icons.history,
            index: 2,
          ),
          buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required int index,
  }) {
    final bool isSelected = (currentIndex == index);

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.hover :Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          size: 28,
          color: AppColors.mainText,
        ),
      ),
    );
  }
}