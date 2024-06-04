import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() {
  Future writeTimeline(Map<String, dynamic>? data, String timelineName) async {
    if (data?[timelineName] != null) {
      final timeline = driver.Timeline.fromJson(
        data![timelineName] as Map<String, dynamic>,
      );

      // Convert the Timeline into a TimelineSummary that's easier to
      // read and understand.
      final summary = driver.TimelineSummary.summarize(timeline);

      // Then, write the entire timeline to disk in a json format.
      // This file can be opened in the Chrome browser's tracing tools
      // found by navigating to chrome://tracing.
      // Optionally, save the summary to disk by setting includeSummary
      // to true
      print("Saving ${timelineName}_${DateTime.now().millisecondsSinceEpoch}");
      
      await summary.writeTimelineToFile(
        '${timelineName}_${DateTime.now().millisecondsSinceEpoch}',
        pretty: true,
        includeSummary: true,
      );
    }
  }

  return integrationDriver(responseDataCallback: (data) async {
    await writeTimeline(data, 'scrolling_timeline_no_keys');
    await writeTimeline(data, 'scrolling_timeline_global_keys');
    await writeTimeline(data, 'scrolling_timeline_value_keys');
    await writeTimeline(data, 'scrolling_timeline_sliver');
    await writeTimeline(data, 'scrolling_timeline_slivers_prototype');
    await writeTimeline(data, 'scrolling_timeline_shrink_wrap_never_scrollable');
    await writeTimeline(data, 'scrolling_timeline_shrink_wrap');
  });
}
