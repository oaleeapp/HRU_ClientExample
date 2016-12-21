//
//  HRUMoodViewController.swift
//  HRU_ClientExample
//
//  Created by lee on 21/12/2016.
//  Copyright © 2016 SwiftWithMe. All rights reserved.
//

import UIKit

class HRUMoodViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardView: UIView!

    var mood: HRUMood?
    var color = UIColor(red:0.99, green:0.35, blue:0.35, alpha:1.0)
//    override func loadView() {
//        super.loadView()
//        let nib = UINib(nibName: "HRUMoodViewController", bundle: nil)
//        nib.instantiate(withOwner: self, options: nil)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popSelf(_:)))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self


        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(shareIt(_:)))
        self.cardView.addGestureRecognizer(longPressGesture)
        longPressGesture.delegate = self

        emotionLabel.text = mood?.emotion
        nameLabel.text = mood?.name
        cardView.backgroundColor = mood?.color.color()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func popSelf(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

    func shareIt(_ sender: UILongPressGestureRecognizer) {

        let shareVC = UIActivityViewController(activityItems: [UIImage(view: self.cardView)], applicationActivities: nil)


        present(shareVC, animated: true, completion: nil)

    }


}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
