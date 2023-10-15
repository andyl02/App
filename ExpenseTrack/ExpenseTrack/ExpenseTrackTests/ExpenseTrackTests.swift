//  ExpenseTrackTests.swift

import XCTest
@testable import ExpenseTrack

final class ExpenseTrackTests: XCTestCase {

    var expenseManager: ExpenseManager!
    
    override func setUpWithError() throws {
        super.setUp()
        expenseManager = ExpenseManager()
    }

    override func tearDownWithError() throws {
        expenseManager = nil
        super.tearDown()
    }

    // 1. Test Expense Addition
    func testExpenseAddition() {
        let initialCount = expenseManager.expenses.count
        let expense = Expense(context: expenseManager.coreDataStack.context)
        expense.amount = 10.0
        expense.category = "Food"
        expenseManager.addExpense(expense)
        XCTAssertEqual(expenseManager.expenses.count, initialCount + 1)
    }

    // 2. Test Expense Deletion
    func testExpenseDeletion() {
        let expense = Expense(context: expenseManager.coreDataStack.context)
        expense.amount = 10.0
        expense.category = "Food"
        expenseManager.addExpense(expense)
        let initialCount = expenseManager.expenses.count
        expenseManager.deleteExpense(at: IndexSet(integer: 0))
        XCTAssertEqual(expenseManager.expenses.count, initialCount - 1)
    }

    // 3. Test Budget Setting
    func testBudgetSetting() {
        expenseManager.setBudget(for: "Food", amount: 100.0)
        XCTAssertEqual(expenseManager.getBudget(for: "Food"), 100.0)
    }

    // 4. Test Budget Retrieval
    func testBudgetRetrieval() {
        let budget = expenseManager.getBudget(for: "Food")
        XCTAssertNotNil(budget)
    }

    // 5. Test Total Expense for Category
    func testTotalExpenseForCategory() {
        let total = expenseManager.totalForCategory("Food")
        XCTAssertNotNil(total)
    }

    // 6. Test Remaining Budget
    func testRemainingBudget() {
        let remaining = expenseManager.remainingBudget(for: "Food")
        XCTAssertNotNil(remaining)
    }

    // 7. Test Category Addition
    func testCategoryAddition() {
        let initialCount = expenseManager.categories.count
        expenseManager.addCategory("NewCategory")
        XCTAssertEqual(expenseManager.categories.count, initialCount + 1)
    }

    // 8. Test Category Deletion
    func testCategoryDeletion() {
        expenseManager.addCategory("NewCategory")
        let initialCount = expenseManager.categories.count
        expenseManager.deleteCategory(at: IndexSet(integer: initialCount - 1))
        XCTAssertEqual(expenseManager.categories.count, initialCount - 1)
    }

    // 9. Test Expenses by Category
    func testExpensesByCategory() {
        let expensesByCategory = expenseManager.expensesByCategory
        XCTAssertNotNil(expensesByCategory)
    }

    // 10. Test Save Context
    func testSaveContext() {
        XCTAssertNoThrow(expenseManager.saveContext())
    }
}
