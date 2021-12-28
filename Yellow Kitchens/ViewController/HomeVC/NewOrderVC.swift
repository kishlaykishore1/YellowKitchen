//
//  NewOrderVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 18/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class NewOrderVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func action_BackToHome(_ sender: UIButton) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    @IBAction func action_TrackOrder(_ sender: UIButton) {
    }
}
