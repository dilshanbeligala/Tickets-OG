import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/utils_barrel.dart';

class SideBarLink extends StatelessWidget {
  final String label;
  final String icon;
  final Function() onClick;
  const SideBarLink({super.key, required this.label, required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: size.width * 0.7 - 48,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 24,
                width: 24,
              ),
              SizedBox(width: size.width * 0.04),
              SizedBox(
                width: size.width* 0.66 - 72,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.neutralColor[800],
                      fontWeight: FontWeight.w700,
                      height: 1.1
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
