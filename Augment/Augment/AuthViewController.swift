//
//  AuthViewController.swift
//  Augment
//
//  Created by Rohan Mishra on 10/7/17.
//  Copyright © 2017 Augment. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift
import RealmSwift
import SnapKit
class AuthViewController: UIViewController {

    let api = API()

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view  as! UIImageView
        api.authenticateWithView(viewController: self)
        print(":yo______________")
        
    }
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.view.addSubview(background)
        background.image = UIImage(named: "background")
        let buttonImg = UIImageView(frame: CGRect(x: 0, y: 430, width: 300, height: 40))
        buttonImg.backgroundColor = UIColor(red:0.95, green:0.59, blue:0.70, alpha:1.0)
        background.addSubview(buttonImg)
     background.isUserInteractionEnabled = true
        buttonImg.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        buttonImg.addGestureRecognizer(tapGestureRecognizer)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 40))
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 15)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]
            let string = "AUTHENTICATE WITH LYFT"
            string.draw(with: CGRect(x: 0, y: 5, width: 300, height: 40), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        buttonImg.image = img
    }



}
