import XCTest

/// A set of UI test cases for the `ExpenseTrack` app.
///
/// `ExpenseTrackUITests` tests the user interface of the `ExpenseTrack` app. It includes tests for launching the app and measuring its launch performance.
///
/// - Tag: ExpenseTrackUITests
final class ExpenseTrackUITests: XCTestCase {

    /// Sets up the test environment before each test case runs.
    ///
    /// This method is called before the invocation of each test method in the class. It sets the initial state required for the tests, such as the interface orientation.
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    /// Tears down the test environment after each test case runs.
    ///
    /// This method is called after the invocation of each test method in the class. It can be used to clean up any resources that were set up in the `setUpWithError()` method.
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Tests the launch of the `ExpenseTrack` app.
    ///
    /// This test case launches the `ExpenseTrack` app and verifies that it produces the correct results.
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    /// Measures the launch performance of the `ExpenseTrack` app.
    ///
    /// This test case measures how long it takes to launch the `ExpenseTrack` app.
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
