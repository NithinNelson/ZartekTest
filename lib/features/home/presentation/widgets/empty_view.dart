
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zartek_flutter_test/features/home/presentation/controllers/home_controller.dart';

class EmptyView extends StatelessWidget {
  final HomeController controller;
  const EmptyView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchMenu(loader: false);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              SizedBox(height: (constraints.maxHeight / 2).h),
              Center(
                child: Text(
                  'Empty',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
