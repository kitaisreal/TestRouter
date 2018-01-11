//
//  RouterLinkParserTests.swift
//  DeepLinkTestTests
//
//  Created by Maksim Kita on 1/9/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation
import XCTest
@testable import DeepLinkTest

class RouterLinkParserTests:XCTestCase {
    func testFunc() {
        let link = "testUrl://anotherLink/link?data='data'"
        let url = URL(string:link)!
        print(url.host)
        let components = URLComponents(string: link)
        for i in (components?.queryItems)! {
            print("Description \(i.description) Value \(i.value)")
        }
        
    }
}
