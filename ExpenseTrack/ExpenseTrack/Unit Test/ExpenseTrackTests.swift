import XCTest
@testable import ExpenseTrack

/// A set of test cases for the `ExpenseTrack` app.
///
/// `ExpenseTrackTests` tests the functionality of the `ExpenseManager` class, including adding and deleting expenses and categories, setting budgets, fetching expenses and budgets, and calculating totals and remaining budgets.
///
/// - Tag: ExpenseTrackTests
class ExpenseTrackTests: XCTestCase {

    /// The `ExpenseManager` instance under test.
    var expenseManager: ExpenseManager!

    /// Sets up the test environment before each test case runs.
    ///
    /// This method creates a new `ExpenseManager` instance.
    override func setUp() {
        super.setUp()
        expenseManager = ExpenseManager()
    }

    /// Tests the `addExpense(_:)` method.
    ///
    /// This test case adds a new expense and checks that the count of expenses increases by one.
    func testAddExpense() {
        let initialCount = expenseManager.expenses.count
        let newExpense = Expense(context: expenseManager.coreDataStack.context)
        newExpense.amount = 50.0
        newExpense.category = "Food"
        expenseManager.addExpense(newExpense)
        XCTAssertEqual(expenseManager.expenses.count, initialCount + 1)
    }

    /// Tests the `deleteExpense(at:)` method.
    ///
    /// This test case adds a new expense, deletes it, and checks that the count of expenses decreases by one.
    func testDeleteExpense() {
        let newExpense = Expense(context: expenseManager.coreDataStack.context)
        newExpense.amount = 50.0
        newExpense.category = "Food"
        expenseManager.addExpense(newExpense)
        let initialCount = expenseManager.expenses.count
        expenseManager.deleteExpense(at: [initialCount - 1])
        XCTAssertEqual(expenseManager.expenses.count, initialCount - 1)
    }

    /// Tests the `addCategory(_:)` method.
    ///
    /// This test case adds a new category and checks that the count of categories increases by one.
    func testAddCategory() {
        let initialCount = expenseManager.categories.count
        expenseManager.addCategory("NewCategory")
        XCTAssertEqual(expenseManager.categories.count, initialCount + 1)
    }

    /// Tests the `deleteCategory(at:)` method.
    ///
    /// This test case adds a new category, deletes it, and checks that the count of categories decreases by one.
    func testDeleteCategory() {
        expenseManager.addCategory("NewCategory")
        let initialCount = expenseManager.categories.count
        expenseManager.deleteCategory(at: [initialCount - 1])
        XCTAssertEqual(expenseManager.categories.count, initialCount - 1)
    }

    /// Tests the `setBudget(for:amount:)` and `getBudget(for:)` methods.
    ///
    /// This test case sets a budget for a category and checks that the budget is correctly stored.
    func testSetBudget() {
        expenseManager.setBudget(for: "Food", amount: 200.0)
        XCTAssertEqual(expenseManager.getBudget(for: "Food"), 200.0)
    }

    /// Tests the `fetchExpenses()` method.
    ///
    /// This test case fetches expenses and checks that the expenses are not `nil`.
    func testFetchExpenses() {
        expenseManager.fetchExpenses()
        XCTAssertNotNil(expenseManager.expenses)
    }

    /// Tests the `fetchBudgets()` method.
    ///
    /// This test case fetches budgets and checks that the budgets are not `nil`.
    func testFetchBudgets() {
        expenseManager.fetchBudgets()
        XCTAssertNotNil(expenseManager.budgets)
    }

    /// Tests the `totalForCategory(_:)` method.
    ///
    /// This test case calculates the total for a category and checks that the total is correct.
    func testTotalForCategory() {
        let total = expenseManager.totalForCategory("Food")
        XCTAssertEqual(total, expenseManager.expenses.filter { $0.category == "Food" }.reduce(0) { $0 + $1.amount })
    }

    /// Tests the `remainingBudget(for:)` method.
    ///
    /// This test case calculates the remaining budget for a category and checks that the remaining budget is correct.
    func testRemainingBudget() {
        let remaining = expenseManager.remainingBudget(for: "Food")
        let totalExpensesForCategory = expenseManager.expenses.filter { $0.category == "Food" }.map { $0.amount }.reduce(0, +)
        let budgetForCategory = expenseManager.getBudget(for: "Food")
        XCTAssertEqual(remaining, budgetForCategory - totalExpensesForCategory)
    }

    /// Tests the `saveContext()` method.
    ///
    /// This test case saves the context and checks that no error is thrown.
    func testSaveContext() {
        XCTAssertNoThrow(expenseManager.saveContext())
    }
}
