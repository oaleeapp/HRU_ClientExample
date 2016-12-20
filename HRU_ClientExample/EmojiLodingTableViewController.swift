//
//  EmojiLodingTableViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

class EmojiLodingTableViewController: UITableViewController {

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ timer in
            self.tableView.reloadData()
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.rowHeight = tableView.frame.size.height / 1
        tableView.estimatedRowHeight = tableView.frame.size.height / 1

    }


    func loading(_ isLoading:Bool) {
        if isLoading {
            timer?.fire()
            UIView.animate(withDuration: 0.2) {
                self.tableView.isHidden = false
            }

        } else {
            timer?.invalidate()
            self.tableView.isHidden = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as? EmojiLoadingTableViewCell else {
            fatalError("wrong setting in EmojiLoadingTableViewCell")
        }

        // Configure the cell...



        cell.emojiLabel?.text = String.randomEmoji()

        cell.alpha = 0.0
        UIView.animate(withDuration: 0.5 + Double(indexPath.row)/4){
            cell.alpha = 1.0
        }
        return cell
    }

}



// Returns a random Emoji 🌿
extension String{
    static func randomEmoji()->String{
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
        let emoji = UnicodeScalar(ascii)?.description
        return emoji ?? "😍"
    }
}
