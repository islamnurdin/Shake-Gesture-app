//
//  ServerManager.swift
//  Shake Gesture app
//
//  Created by Name on 5/24/19.
//  Copyright © 2019 Name. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }

    /**
     It doubles the value given as a parameter.
     
     ### Usage Example: ###

     ```
     ServerManager.shared.sendStatus(status: Status) {
     
     }
     ```
     */
    func sendStatus(status: Status,_ completion: @escaping ()-> Void, error: @escaping (String)-> Void) {

        let url = URL(string: "https://betaapi.nasladdin.club/api/energy/operationStatus")
        
        Alamofire.request(url!, method: .put, parameters: status.statusParameter(), encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            print("response: \(response)")
            completion()
        }
    }
}
