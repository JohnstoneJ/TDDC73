import 'package:flutter_test/flutter_test.dart';
import 'package:project_carousel/leaderboard/leaderboard.dart';
import 'package:project_carousel/movie_list.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment

  testWidgets('The leaderboard widget has the correct title',
      (WidgetTester tester) async {
    await tester.pumpWidget(LeaderBoardWidget(
      itemList: movies,
      title: 'Leaderboard Title',
    ));

    final titleFinder = find.text('Leaderboard Title');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('The top leaderboard has correct nr of rows',
      (WidgetTester tester) async {
    int rowTestNR = 5;
    await tester.pumpWidget(LeaderBoardWidget(
      itemList: movies,
      maxRows: rowTestNR,
    ));

    final rowCounter = find.byType(LeaderBoardObject);

    expect(rowCounter, findsNWidgets(rowTestNR));
  });
/*
  testWidgets('The leaderboard widget have the right nr of unique leaderboards',
      (WidgetTester tester) async {
    await tester.pumpWidget(LeaderBoardWidget(
      itemList: movies,
      categoryList: const ["Action", "Family"],
    ));

    final columnCounter = find.byType(LeaderBoard);

    expect(columnCounter, findsNWidgets(2));
  });*/
}
