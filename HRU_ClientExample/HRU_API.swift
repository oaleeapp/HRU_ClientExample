//
//  HRU_API.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (_ isSuccess: Bool)->()

class HRU_API: NSObject {

    static let domainName = "https://floating-bastion-69914.herokuapp.com/"
    static var moodArray: Array<HRUMood> = []
    enum RoutePath: String {
        case moods = "moods"

        func urlString() -> String{
            return HRU_API.domainName.appending(self.rawValue)
        }
    }

    static func get(_ routePath: RoutePath, complete: @escaping CompletionHandler) {
        Alamofire.request(routePath.urlString(), method:.get).responseJSON { response in

            switch response.result {
            case .success(let data):
                let json = JSON(data)
                var moodArray:[HRUMood] = []
                for moodJson in json.array! {
                    let id = moodJson["id"].int
                    let name = moodJson["name"].stringValue
                    let emotion = moodJson["emotion"].stringValue
                    let mood = HRUMood(name: name, emotion: emotion, id: id)

                    moodArray.append(mood)

                }
                HRU_API.moodArray = moodArray
                // complete
                complete(true)


            case .failure(let error):
                print("Request failed with error: \(error)")
                complete(false)
                
            }
        }
    }

    static func create(_ routePath: RoutePath, mood: HRUMood, complete: @escaping CompletionHandler) {

        let headers: HTTPHeaders = [
            "Content-type": "application/json",
            "Accept": "application/json",
        ]
        let parameters: Parameters = [
            "name": mood.name,
            "emotion": mood.emotion
        ]

        Alamofire.request(routePath.urlString(), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)

                // reload tableView
                complete(true)

            case .failure(let error):
                print("Request failed with error: \(error)")
                complete(false)
                
            }
            
        }
    }

    static func delete(_ routePath: RoutePath, mood: HRUMood, complete: @escaping CompletionHandler) {
        guard let id = mood.id else {
            complete(false)
            return
        }
        
        let deleteURL = routePath.urlString().appending("/\(id)")

        Alamofire.request(deleteURL, method: .delete).responseJSON { response in

            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)

                // reload tableView
                complete(true)

            case .failure(let error):
                print("Request failed with error: \(error)")
                complete(false)
                
            }
            
        }
    }

}

extension HRU_API {

    static func lastIndexPath() -> IndexPath {

        if HRU_API.moodArray.count > 0 {
            return IndexPath(row: HRU_API.moodArray.count - 1, section: 0)
        } else {
            return IndexPath(row: 0, section: 0)
        }
        
    }
}
