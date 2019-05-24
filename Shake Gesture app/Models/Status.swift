//
//  Status.swift
//  Shake Gesture app
//
//  Created by Name on 5/23/19.
//  Copyright © 2019 Name. All rights reserved.
//

import Foundation

struct Status: Decodable {
    var status: Int
    
    func statusParameter() -> [String: Int] {
        return ["status": status]
    }
}


