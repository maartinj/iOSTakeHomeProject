//
//  CreateScreenUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Marcin Jędrzejak on 11/09/2022.
//

import XCTest

final class CreateScreenUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success":"1",
            "-create-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_valid_form_submission_is_successful() {
        
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There create button should be visible on the screen")
        
        createBtn.tap()
        
        let firstNameTxtField = app.textFields["firstNameTxtField"]
        let lastNameTxtField = app.textFields["lastNameTxtField"]
        let jobTxtField = app.textFields["jobTxtField"]
        
        firstNameTxtField.tap()
        firstNameTxtField.typeText("Tunds")
        
        lastNameTxtField.tap()
        lastNameTxtField.typeText("Ads")
        
        jobTxtField.tap()
        jobTxtField.typeText("iOS Developer")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.exists, "There submit button should be visible on the screen")
        
        submitBtn.tap()
        
        XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "There should be a navigation bar title People")
    }
}
