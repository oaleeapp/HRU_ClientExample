//
//  HRUMoodsTableViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MoodsListDisplayable {
    func reloadData()
}

class HRUMoodsTableViewController: UITableViewController, MoodsListDisplayable {


    var jsonArray: Array<[String:String]>?
    var moodArray: Array<HRUMood> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMoods()


    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moodArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        let mood = moodArray[indexPath.row]
        cell.textLabel?.text = mood.emotion
        cell.detailTextLabel?.text = mood.name

        return cell
    }

    func fetchMoods() {
        Alamofire.request("https://floating-bastion-69914.herokuapp.com/moods", method:.get).responseJSON { response in
            print(response.request ?? "No request")  // original URL request
            print(response.response ?? "No response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization


            switch response.result {
            case .success(let data):
                let json = JSON(data)
                var moodArray:[HRUMood] = []
                for moodJson in json.array! {
                    let name = moodJson["name"].stringValue
                    let emotion = moodJson["emotion"].stringValue
                    let mood = HRUMood(name: name, emotion: emotion)

                    moodArray.append(mood)

                }
                self.moodArray = moodArray
                if self.moodArray.count != 0 {
                    self.tableView.reloadData()
                    let indexPath = IndexPath.init(row: self.moodArray.endIndex - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
                }

            case .failure(let error):
                print("Request failed with error: \(error)")
                
                
            }
        }

    }

    func reloadData() {
        fetchMoods()
    }


}
