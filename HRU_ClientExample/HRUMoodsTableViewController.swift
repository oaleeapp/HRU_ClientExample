//
//  HRUMoodsTableViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

protocol MoodsListDisplayable {
    func reloadData()
}

class HRUMoodsTableViewController: UITableViewController, MoodsListDisplayable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the data from server
        fetchMoods()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HRU_API.moodArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        let mood = HRU_API.moodArray[indexPath.row]
        cell.textLabel?.text = mood.emotion
        cell.detailTextLabel?.text = mood.name

        return cell
    }

    func fetchMoods() {
        HRU_API.get(.moods) { isSuccess in

            switch isSuccess {
            case true:
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: HRU_API.lastIndexPath(), at: .bottom, animated: true)

            case false:
                print("fail to load moods")
            }
        }
    }

    func reloadData() {
        fetchMoods()
    }


}
