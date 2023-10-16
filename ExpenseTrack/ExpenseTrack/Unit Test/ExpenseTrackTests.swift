//  ExpenseTrackTests.swift

import XCTest
@testable import ExpenseTrack

class ExpenseTrackTests: XCTestCase {

    var expenseManager: ExpenseManager!

    override func setUp() {
        super.setUp()
        expenseManager = ExpenseManager()
    }

    func testAddExpense() {
        let initialCount = expenseManager.expenses.count
        let newExpense = Expense(context: expenseManager.coreDataStack.context)
        newExpense.amount = 50.0
        newExpense.category = "Food"
        expenseManager.addExpense(newExpense)
        XCTAssertEqual(expenseManager.expenses.count, initialCount + 1)
    }

    func testDeleteExpense() {
        let newExpense = Expense(context: expenseManager.coreDataStack.context)
        newExpense.amount = 50.0
        newExpense.category = "Food"
        expenseManager.addExpense(newExpense)
        let initialCount = expenseManager.expenses.count
        expenseManager.deleteExpense(at: [initialCount - 1])
        XCTAssertEqual(expenseManager.expenses.count, initialCount - 1)
    }

    func testAddCategory() {
        let initialCount = expenseManager.categories.count
        expenseManager.addCategory("NewCategory")
        XCTAssertEqual(expenseManager.categories.count, initialCount + 1)
    }

    func testDeleteCategory() {
        expenseManager.addCategory("NewCategory")
        let initialCount = expenseManager.categories.count
        expenseManager.deleteCategory(at: [initialCount - 1])
        XCTAssertEqual(expenseManager.categories.count, initialCount - 1)
    }

    func testSetBudget() {
        expenseManager.setBudget(for: "Food", amount: 200.0)
        XCTAssertEqual(expenseManager.getBudget(for: "Food"), 200.0)
    }

    func testFetchExpenses() {
        expenseManager.fetchExpenses()
        XCTAssertNotNil(expenseManager.expenses)
    }

    func testFetchBudgets() {
        expenseManager.fetchBudgets()
        XCTAssertNotNil(expenseManager.budgets)
    }

    func testTotalForCategory() {
        let total = expenseManager.totalForCategory("Food")
        XCTAssertEqual(total, expenseManager.expenses.filter { $0.category == "Food" }.reduce(0) { $0 + $1.amount })
    }

    func testRemainingBudget() {
        let remaining = expenseManager.remainingBudget(for: "Food")
        let totalExpensesForCategory = expenseManager.expenses.filter { $0.category == "Food" }.map { $0.amount }.reduce(0, +)
        let budgetForCategory = expenseManager.getBudget(for: "Food")
        XCTAssertEqual(remaining, budgetForCategory - totalExpensesForCategory)
    }

    func testSaveContext() {
        XCTAssertNoThrow(expenseManager.saveContext())
    }
}
