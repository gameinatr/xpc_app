import 'package:flutter/material.dart';

class NextTrainingStatuses {
  static const wait = 'wait';
  static const progress = 'progress';
}

class NextTrainingStatus extends StatelessWidget {
  final String status;
  const NextTrainingStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case NextTrainingStatuses.wait:
        return const Text('Awaiting start');
      case NextTrainingStatuses.progress:
        return const Text('In Progress');
      default:
        return const Text('Not Available');
    }
  }
}
