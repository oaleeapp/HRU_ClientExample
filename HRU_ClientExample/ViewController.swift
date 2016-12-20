//
//  ViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 20/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

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
                HRU_API.create(.moods, mood: mood) { isSuccess in
                    if isSuccess {
                        self.moodsListVC?.reloadData()
                    } else {
                        print("fail to create new mood")
                    }
                }
            }

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in

        }))

        self.present(alert, animated: true, completion: nil)

    }


}

