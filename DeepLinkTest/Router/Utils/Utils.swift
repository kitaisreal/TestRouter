//
//  Utils.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/15/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

extension Array {
    func compare<OtherCollection>(with otherCollection:OtherCollection) -> Bool
        where OtherCollection : Collection, Element == OtherCollection.Element, OtherCollection.Element: Equatable {
            var comparedCount:Int = 0
            guard self.count == otherCollection.count else {
                return false
            }
            for firstElement in self {
                for secondElement in otherCollection {
                    if (firstElement == secondElement) {
                        comparedCount += 1
                        break
                    }
                }
            }
            return comparedCount == self.count
    }
}
