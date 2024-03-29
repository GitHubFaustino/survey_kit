import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/src/steps/step.dart' as surveystep;
import 'package:survey_kit/survey_kit.dart';

// ignore: must_be_immutable
class StepView extends StatelessWidget {
  final surveystep.Step step;
  final Widget title;
  final Widget child;
  final QuestionResult Function() resultFunction;
  final bool isValid;
  final SurveyController? controller;
  late BuildContext ctx;
  late SurveyController _surveyController;

  StepView({
    required this.step,
    required this.child,
    required this.title,
    required this.resultFunction,
    this.controller,
    this.isValid = true,
  });

  void click() {
    debugPrint("TAPPED");
    //if (isValid || step.isOptional) {
    _surveyController.nextStep(ctx, resultFunction);
    //}
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    _surveyController = controller ?? context.read<SurveyController>();

    return _content(_surveyController, context);
  }

  Widget _content(SurveyController surveyController, BuildContext context) {
    return SizedBox.expand(
      child: Container(
        alignment: Alignment.topCenter,
        color: Theme.of(context).colorScheme.background,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Text("XXX"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  child: title,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: GestureDetector(onTap: () {}, child: child)),
                //  Text("ZZZ"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 20.0),
                  child: (step.autoNext)
                      ? null
                      : OutlinedButton(
                          onPressed: isValid || step.isOptional
                              ? () => [
                                    FocusScope.of(context).hasFocus
                                        ? FocusScope.of(context).unfocus()
                                        : null,
                                    surveyController.nextStep(
                                        context, resultFunction),
                                  ]
                              : null,
                          child: Text(
                            context.read<Map<String, String>?>()?['next'] ??
                                step.buttonText ??
                                'Next',
                            style: TextStyle(
                              color: isValid
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                          ),
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
