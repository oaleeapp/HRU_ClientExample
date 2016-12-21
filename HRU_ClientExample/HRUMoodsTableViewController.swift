//
//  HRUMoodsTableViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit


class HRUMoodsTableViewController: UITableViewController {

    var delegate: LoadingHelper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the data from server
        fetchMoods()
    }

    func fetchMoods() {


        self.tableView.alpha = 0.0
        delegate?.loading(true)
        HRU_API.get(.moods) { isSuccess in

            self.delegate?.loading(false)
            switch isSuccess {
            case true:
                self.tableView.reloadData()

                if self.tableView.scrollsToTop {
                    UIView.animate(withDuration: 0.2){
                        self.tableView.alpha = 1.0
                        self.tableView.scrollToRow(at: HRU_API.lastIndexPath(), at: .bottom, animated: false)
                    }
                } else {
                    self.tableView.alpha = 1.0
                    self.tableView.scrollToRow(at: HRU_API.lastIndexPath(), at: .bottom, animated: false)
                }

            case false:
                print("fail to load moods")
                self.tableView.alpha = 1.0
            }
        }
    }

}

extension HRUMoodsTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HRU_API.moodArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MoodTableViewCell else {
            fatalError("Wrong setting in storyboard for mood cell")
        }

        let mood = HRU_API.moodArray[indexPath.row]
        cell.nameLabel?.text = mood.name
        cell.emotionLabel?.text = mood.emotion
        let randomColor = MoodColor.random()
        mood.color = randomColor
        cell.backView.backgroundColor = randomColor.color()
        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print("triggered!")

        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            print("delete button tapped")
            HRU_API.delete(.moods, mood: HRU_API.moodArray[indexPath.row]){ isSuccess in
                if isSuccess {
                    print("mood deleted")
                    HRU_API.moodArray.remove(at: indexPath.row)
                    self.tableView.reloadData()
                } else {
                    print("fail to delete mood")
                }
            }
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let row = indexPath.row
        let mood = HRU_API.moodArray[row]
        let moodVC = HRUMoodViewController(nibName: "HRUMoodViewController", bundle: nil)
        moodVC.mood = mood

        if let cell = tableView.cellForRow(at: indexPath) as? MoodTableViewCell {
            moodVC.color = cell.backView.backgroundColor!
        } else {
            print("wrong cell type")
        }

        present(moodVC, animated: true){
            print("completed")
        }

    }
}











