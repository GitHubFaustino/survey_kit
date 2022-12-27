import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/time_answer_formart.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';
import 'package:survey_kit/src/views/widget/time_picker_widget.dart';

class TimeAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const TimeAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _TimeAnswerViewState createState() => _TimeAnswerViewState();
}

class _TimeAnswerViewState extends State<TimeAnswerView> {
  final DateTime _startDate = DateTime.now();
  late TimeAnswerFormat _timeAnswerFormat;
  late TimeOfDay? _result;

  @override
  void initState() {
    super.initState();
    _timeAnswerFormat = widget.questionStep.answer as TimeAnswerFormat;
    _result = widget.result?.result as TimeOfDay? ??
        _timeAnswerFormat.defaultValue ??
        TimeOfDay.fromDateTime(
          DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<TimeOfDay>(
        id: widget.questionStep.id,
        startTime: _startDate,
        endTime: DateTime.now(),
        valueIdentifier: _result.toString(),
        result: _result,
      ),
      isValid: !widget.questionStep.isMandatory || _result != null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: ContentWidget(
              content: widget.questionStep.content,
            ),
          ),
          if (Theme.of(context).platform == TargetPlatform.iOS)
            _iosTimePicker()
          else
            _androidTimePicker(),
        ],
      ),
    );
  }

  Widget _androidTimePicker() {
    return Container(
      width: double.infinity,
      height: 450.0,
      child: TimePickerWidget(
        initialTime: _result ??
            TimeOfDay.fromDateTime(
              DateTime.now(),
            ),
        timeChanged: (TimeOfDay time) {
          setState(() {
            _result = time;
          });
        },
      ),
    );
  }

  Widget _iosTimePicker() {
    return Container(
      width: double.infinity,
      height: 450.0,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (DateTime newTime) {
          setState(() {
            _result = TimeOfDay.fromDateTime(newTime);
          });
        },
      ),
    );
  }
}
