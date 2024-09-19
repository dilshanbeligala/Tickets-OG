import 'package:flutter/material.dart';

import '../../../../../core/utils/utils_barrel.dart';

enum Role { CHILD, TEACHER }

class RoleToggle extends StatelessWidget {
  final Function(Role) onChange;
  final Role type;
  const RoleToggle({super.key, required this.onChange, required this.type});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryColor[800]!,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onChange(Role.CHILD);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: type == Role.CHILD ? AppColors.primaryColor[600] : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  'Student',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: type == Role.CHILD
                          ? Colors.white
                          : AppColors.textColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onChange(Role.TEACHER);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: type == Role.TEACHER ? AppColors.primaryColor[600] : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  'Teacher',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: type == Role.TEACHER
                          ? Colors.white
                          : AppColors.textColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
