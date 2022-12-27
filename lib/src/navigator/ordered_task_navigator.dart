import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/task/task.dart';

class OrderedTaskNavigator extends TaskNavigator {
  OrderedTaskNavigator(Task task) : super(task);

  @override
  Step? nextStep({required Step step, StepResult? questionResult}) {
    record(step);
    return nextInList(step);
  }

  @override
  Step? previousInList(Step step) {
    final currentIndex =
        task.steps.indexWhere((element) => element.id == step.id);
    return (currentIndex - 1 < 0) ? null : task.steps[currentIndex - 1];
  }

  @override
  Step? firstStep() {
    final previousStep = peekHistory();
    return previousStep == null
        ? task.initalStep ?? task.steps.first
        : nextInList(previousStep);
  }
}
