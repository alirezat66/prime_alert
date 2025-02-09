import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_alert/core/extension/context_ext.dart';
import 'package:prime_alert/features/clock/cubit/date_cubit.dart';

class DateView extends StatelessWidget {
  const DateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, String>(
      builder: (context, state) {
        return Text(
          state,
          style: context.textTheme.displayMedium,
        );
      },
    );
  }
}
