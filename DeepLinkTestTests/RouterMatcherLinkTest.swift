//
//  RouterMatcherTest.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/8/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterMatcherTests:XCTestCase {
    let matcher = Matcher()
    
    func testRightMatch() {
        let rightLinkValue = matcher.getLinkValue(with: "/test/*")
        let firstMatchResult = matcher.matchLink(in: "/testz/something", with: rightLinkValue)
        XCTAssertEqual(firstMatchResult, false)
        let secondMatchResult = matcher.matchLink(in: "/test/something", with: rightLinkValue)
        XCTAssertEqual(secondMatchResult, true)
        let thirdMatchResult = matcher.matchLink(in: "something/test/something", with: rightLinkValue)
        XCTAssertEqual(thirdMatchResult, false)
    }
    func testLeftMatch() {
        let leftLinkValue = matcher.getLinkValue(with: "*/test/")
        let firstMatchResult = matcher.matchLink(in: "something/test/", with: leftLinkValue)
        XCTAssertEqual(firstMatchResult, true)
        let secondMatchResult = matcher.matchLink(in: "/test/something", with: leftLinkValue)
        XCTAssertEqual(secondMatchResult, false)
        let thirdMatchResult = matcher.matchLink(in: "/test/", with: leftLinkValue)
        XCTAssertEqual(thirdMatchResult, true)
    }
    func testAnyMatch() {
        let testAnyLinkValue = matcher.getLinkValue(with: "*/test/*")
        let firstMatchResult = matcher.matchLink(in: "something/testz/something", with: testAnyLinkValue)
        XCTAssertEqual(firstMatchResult, false)
        let secondMatchResult = matcher.matchLink(in: "/test", with: testAnyLinkValue)
        XCTAssertEqual(secondMatchResult, false)
        let thirdMatchResult = matcher.matchLink(in: "/test/", with: testAnyLinkValue)
        XCTAssertEqual(thirdMatchResult, true)
        let fourthMatchResult = matcher.matchLink(in: "something/test/something", with: testAnyLinkValue)
        XCTAssertEqual(fourthMatchResult, true)
    }
    func testIdentityMatch() {
        let testIdentityLinkvalue = matcher.getLinkValue(with: "/test/")
        let firstMatcherResult = matcher.matchLink(in: "/test/", with: testIdentityLinkvalue)
        XCTAssertEqual(firstMatcherResult, true)
        let secondMatcherResult = matcher.matchLink(in: "something/test/something", with: testIdentityLinkvalue)
        XCTAssertEqual(secondMatcherResult, false)
        let thirdMatcherResult = matcher.matchLink(in: "/test", with: testIdentityLinkvalue)
        XCTAssertEqual( thirdMatcherResult, false)
    }
    func testEveryMatch() {
        let testString = ""
        print(testString.count)
        let otherTestString = "something/something"
        print(otherTestString.range(of: testString) != nil)
//        let matcherResult = matcher.matchLink(in: "asdfosadfops//asdflasldf", with: testEveryMatchLinkValue)
//        print(matcherResult)
    }
    func testSomething() {
        let routerObserverHandler = RouterObserverHandler()
        routerObserverHandler.addObserver(link: "/testLink", id: "testID1") {
            print("TESTIDACTION TEST ID 1")
        }
        routerObserverHandler.addObserver(link: "/testLink", id: "testID2") {
            print("TESTIDACTION TEST ID 2")
        }
        routerObserverHandler.addObserver(link: "/anotherTestLink", id: "anotherTestID") {
            print("AnotherTestIDAACTION")
        }
        print(routerObserverHandler.getLinks())
        routerObserverHandler.makeAction(link: "/testLink")
        routerObserverHandler.makeAction(link: "/anotherTestLink")
        routerObserverHandler.removeObserver(link: "/testLink", id: "testID1")
        routerObserverHandler.makeAction(link: "/testLink")
        routerObserverHandler.makeAction(link: "/anotherTestLink")
    }
    func testHashMap() {
        print("TEST HASH MAP")
        var dictionary:[String:[String]] = [:]
        dictionary.updateValue([], forKey: "test")
        dictionary["test"]?.append("action1")
        dictionary["test"]?.append("action2")
        dictionary["anotherTest"]?.append("action3")
        for key in dictionary.keys {
            print("KEY \(key)")
            for element in dictionary[key]! {
                print("ELEMENT \(key) \(element)")
            }
        }
    }
}
