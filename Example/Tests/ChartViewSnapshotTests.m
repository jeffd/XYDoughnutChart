#import <XCTest/XCTest.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import "DummyChartSourceClass.h"

@interface ChartViewSnapshotTests : FBSnapshotTestCase
@end

@implementation ChartViewSnapshotTests

- (void)setUp
{
    [super setUp];
    self.recordMode = NO;
}

- (void)testChartViewReloadData
{
    XYDoughnutChart *chart = [[XYDoughnutChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    DummyChartSourceClass *source = [[DummyChartSourceClass alloc] init];
    chart.delegate = source;
    chart.dataSource = source;

    [chart reloadData];

    XCTestExpectation *reloadChartExpectation = [self expectationWithDescription:@"reload chart"];
    dispatch_async(dispatch_get_main_queue(), ^{
        FBSnapshotVerifyView(chart, nil);
        [reloadChartExpectation fulfill];
    });
    [self waitForExpectationsWithTimeout:1.5 handler:nil];
}

@end