//
//  ViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    var nameTextfield: UITextField?
    var emotionTextfield: UITextField?
    var moodsListVC: MoodsListDisplayable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MoodsListDisplayable {
            moodsListVC = vc
        }
    }

    @IBAction func addMood(_ sender: UIButton) {

        let alert = UIAlertController(title: "How are you?", message: "use a Emoji to express!", preferredStyle: .alert)
        alert.addTextField { textfield in
            self.nameTextfield = textfield
            self.nameTextfield?.placeholder = "what's your name?"
        }

        alert.addTextField { textfield in
            self.emotionTextfield = textfield
            self.emotionTextfield?.placeholder = "How you feel? e.g. 😊"
        }

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in

            if let name = self.nameTextfield?.text, let emotion = self.emotionTextfield?.text {
                let mood = HRUMood(name: name, emotion: emotion)
                self.createMood(mood)
            }

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in

        }))

        self.present(alert, animated: true, completion: nil)

    }

    func createMood(_ mood: HRUMood) {


        let headers: HTTPHeaders = [

            "Content-type": "application/json",
            "Accept": "application/json",
//            "Authorization": "e1bc6a94-3b9c-486c-9ffa-d96e8bb21645"
        ]
        let parameters: Parameters = [
            "name": mood.name,
            "emotion": mood.emotion
            ]

        Alamofire.request("https://floating-bastion-69914.herokuapp.com/moods", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in


            print(response.request ?? "No request")  // original URL request
            print(response.response ?? "No response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization

            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)

                // reload tableView
                self.moodsListVC?.reloadData()

            case .failure(let error):
                print("Request failed with error: \(error)")
                
                
            }

        }
    }
}

