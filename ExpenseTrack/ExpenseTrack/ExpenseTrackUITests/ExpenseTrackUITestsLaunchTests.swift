import XCTest

/// A set of UI test cases for launching the `ExpenseTrack` app.
///
/// `ExpenseTrackUITestsLaunchTests` tests the launch of the `ExpenseTrack` app. It includes a test for taking a screenshot of the launch screen.
///
/// - Tag: ExpenseTrackUITestsLaunchTests
final class ExpenseTrackUITestsLaunchTests: XCTestCase {

    /// Indicates whether the test case runs for each target application UI configuration.
    ///
    /// This property is `true` because the test case should run for each target application UI configuration.
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    /// Sets up the test environment before each test case runs.
    ///
    /// This method is called before the invocation of each test method in the class. It sets the initial state required for the tests.
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /// Tests the launch of the `ExpenseTrack` app.
    ///
    /// This test case launches the app, performs any necessary steps after launch but before taking a screenshot, and then takes a screenshot of the launch screen.
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
