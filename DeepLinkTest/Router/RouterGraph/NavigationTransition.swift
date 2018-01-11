//
//  Transition.swift
//  DeepLinkTest
//
//  Created by Maksim Kita on 1/4/18.
//  Copyright © 2018 Maksim Kita. All rights reserved.
//

import Foundation

class NavigationTransition {
    private let animation:AnimationEnum
    private let data:DataEnum
    private let push:PushEnum
    
    init (animation:AnimationEnum, data:DataEnum, push:PushEnum) {
        self.animation = animation
        self.data = data
        self.push = push
    }
}
