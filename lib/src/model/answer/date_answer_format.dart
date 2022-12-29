import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer.dart';

part 'date_answer_format.g.dart';

@JsonSerializable()
class DateAnswerFormat implements Answer {
  static const String type = 'date';

  /// Default date which will be preselected on datepicker opening
  final DateTime? defaultDate;

  /// Lowest date which can be selected via the datepicker
  final DateTime? minDate;

  /// Highest date which can be selected via the datepicker
  final DateTime? maxDate;

  DateAnswerFormat({
    this.defaultDate,
    this.minDate,
    this.maxDate,
  })  : assert(
          minDate == null || maxDate == null || minDate.isBefore(maxDate),
          'mindate must be before maxdate',
        ),
        assert(
          defaultDate == null ||
              minDate == null ||
              defaultDate.isAtSameMomentAs(minDate) ||
              defaultDate.isAfter(minDate),
          'defaultDate must be after minDate',
        ),
        assert(
          defaultDate == null ||
              maxDate == null ||
              defaultDate.isAtSameMomentAs(maxDate) ||
              defaultDate.isBefore(maxDate),
          'defaultDate must be before maxDate',
        ),
        super();

  factory DateAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$DateAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$DateAnswerFormatToJson(this);
}