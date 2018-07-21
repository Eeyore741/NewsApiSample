//
//  NewsApiSampleUITests.swift
//  NewsApiSampleUITests
//
//  Created by Vitaliy Kuznetsov on 17/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import XCTest

class NewsApiSampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testGetScreenshots(){
        
        let application = XCUIApplication.init()
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        Thread.sleep(forTimeInterval: 2)
        _ = XCTContext.runActivity(named: "Portrait shot articles list") { (activity) -> XCTWaiter.Result in
            let shot = XCUIScreen.main.screenshot();
            let attachment = XCTAttachment.init(screenshot: shot)
            attachment.lifetime = XCTAttachment.Lifetime.keepAlways
            activity.add(attachment)
            return XCTWaiter.Result.completed
        }
        
        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeLeft
        Thread.sleep(forTimeInterval: 2)
        _ = XCTContext.runActivity(named: "Shot articles list") { (activity) -> XCTWaiter.Result in
            let shot = XCUIScreen.main.screenshot();
            let attachment = XCTAttachment.init(screenshot: shot)
            attachment.lifetime = XCTAttachment.Lifetime.keepAlways
            activity.add(attachment)
            return XCTWaiter.Result.completed
        }
        
        application.tables.element.cells.element(boundBy: 1).tap()
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        Thread.sleep(forTimeInterval: 2)
        _ = XCTContext.runActivity(named: "One article portrait shot") { (activity) -> XCTWaiter.Result in
                let shot = XCUIScreen.main.screenshot();
                let attachment = XCTAttachment.init(screenshot: shot)
                attachment.lifetime = XCTAttachment.Lifetime.keepAlways
                activity.add(attachment)
                return XCTWaiter.Result.completed
        }
        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeLeft
        Thread.sleep(forTimeInterval: 2)
        _ = XCTContext.runActivity(named: "One article landscape shot") { (activity) -> XCTWaiter.Result in
            let shot = XCUIScreen.main.screenshot();
            let attachment = XCTAttachment.init(screenshot: shot)
            attachment.lifetime = XCTAttachment.Lifetime.keepAlways
            activity.add(attachment)
            return XCTWaiter.Result.completed
        }
    }
}
