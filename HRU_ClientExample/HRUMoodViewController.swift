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

        guard let id = mood?.id else {
            print("have no id")
            //need alert
            return
        }
        let red = Int((mood?.color.color().components.red)! * 255.0)
        let green = Int((mood?.color.color().components.green)! * 255.0)
        let blue = Int((mood?.color.color().components.blue)! * 255.0)

        let moodURL = "https://floating-bastion-69914.herokuapp.com/HowAreYou/mood?id=\(id)&r=\(red.description)&g=\(green.description)&b=\(blue.description)"

        let shareVC = UIActivityViewController(activityItems: [moodURL, UIImage(view: self.cardView)], applicationActivities: nil)


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

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}
