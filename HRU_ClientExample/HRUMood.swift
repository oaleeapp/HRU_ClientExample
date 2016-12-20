//
//  HRUMood.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

class HRUMood: NSObject {

    var id: Int?

    var name: String
    var emotion: String

    init(name: String, emotion: String, id: Int? = nil) {
        self.name = name
        self.emotion = emotion
        self.id = id
    }
}
