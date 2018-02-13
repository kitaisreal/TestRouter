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
    }
    
    func testLinksMatch() {
        let links = ["*Detail", "*a*", "Detail*"]
        let firstMatchedLinks = links
        let secondMachedLinks = ["*Detail", "*a*"]
        let thirdMatchedLinks = ["*a*","Detail*"]
        let firstCheckedLinks = matcher.checkRealLinkInLinks(in: links, with: "Detail")
        let secondCheckedLinks = matcher.checkRealLinkInLinks(in: links, with: "SomethingDetail")
        let thirdCheckedLinks = matcher.checkRealLinkInLinks(in: links, with: "DetailSomething")
        print(firstCheckedLinks)
        print(secondCheckedLinks)
        print(thirdCheckedLinks)
        XCTAssertEqual(firstCheckedLinks.compare(with: firstMatchedLinks), true)
        XCTAssertEqual(secondCheckedLinks.compare(with: secondMachedLinks), true)
        XCTAssertEqual(thirdCheckedLinks.compare(with: thirdMatchedLinks), true)
    }
}
