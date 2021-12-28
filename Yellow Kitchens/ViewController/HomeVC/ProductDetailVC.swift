//
//  ProductDetailVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 14/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
class ProductDetailVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var lblSeeAllergens: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblAddMore: UILabel!
    @IBOutlet weak var allergensView: DesignableView!
    // MARK: - properties
    var restaurant = RestaurantVC()
    var indexx = IndexPath()
    var someValue: Int = 0
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var arrAddMore = ["Cornet de frites fraîches à l'ancienne", "Haricot verts Bio relevés à l'ail (+1,5€)", "American Coleslaw (+1,5€)", "Pomme du Marais (+1,5€)", "Cornet de frites de Patates Douces (+1,5€)", "D'lice D'onion Rings (+1,5€)", "Aucun"]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCount.text = "1"
        PickerViewConnection()
    }
    override func viewWillAppear(_ animated: Bool) {
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        self.allergensView.isHidden = true
    }
}
// MARK: - Action Method
extension ProductDetailVC {
    @IBAction func action_SeeAllergens(_ sender: UIControl) {
        if sender.isSelected {
            heightConstraint.priority = UILayoutPriority(rawValue: 997)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.allergensView.isHidden = false
                sender.isSelected = false
                self.lblSeeAllergens.text = "Fermer"
                self.arrowImg.image = #imageLiteral(resourceName: "upArrow")
            }
        } else {
            heightConstraint.priority = UILayoutPriority(rawValue: 999)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                self.allergensView.isHidden = true
                sender.isSelected = true
                self.lblSeeAllergens.text = "Voir les allergènes"
                self.arrowImg.image = #imageLiteral(resourceName: "downArrowBlack")
            }) { _ in
            }
        }
    }
    @IBAction func action_AddToCart(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.restaurant.isBottomView = true
            self.restaurant.tableView.scrollToRow(at: self.indexx, at: .bottom, animated: true)
            self.restaurant.tableView.reloadData()
        }
    }
    @IBAction func action_Minus(_ sender: UIButton) {
        if someValue == 0 {
            btnMinus.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
            btnMinus.isUserInteractionEnabled = false
        } else {
            someValue = someValue - 1
            if someValue == 0 {
                lblCount.text = "1"
                btnMinus.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
                btnMinus.isUserInteractionEnabled = false
            } else {
                lblCount.text = "\(someValue)"
            }
        }
    }
    @IBAction func action_Plus(_ sender: UIButton) {
        btnMinus.tintColor = UIColor.black
        btnMinus.setImage(#imageLiteral(resourceName: "minusBlack"), for: .normal)
        btnMinus.isUserInteractionEnabled = true
        if someValue == 0 {
            someValue = 1
            someValue = someValue + 1
            lblCount.text = "\(someValue)"
        } else {
            someValue = someValue + 1
            lblCount.text = "\(someValue)"
        }
    }
    @IBAction func action_Share(_ sender: UIControl) {
        let shareText = "Yellow Kitchens!"
        if let image = UIImage(named: "bagel_preview") {
            let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    @IBAction func action_Favourties(_ sender: UIButton) {
        if sender.isSelected {
            btnFav.setImage(#imageLiteral(resourceName: "favUnFill"), for: .normal)
            sender.isSelected = false
        } else {
            btnFav.setImage(#imageLiteral(resourceName: "heartFill"), for: .normal)
            sender.isSelected = true
        }
    }
    @IBAction func action_AddMore(_ sender: UIControl) {
        self.view.addSubview(picker)
        self.view.addSubview(toolBar)
    }
    // MARK: - Picker View Setup
    func PickerViewConnection() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.selectRow(2, inComponent: 0, animated: true)
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDoneButtonTapped))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onCancelButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancel, flexibleSpace, done], animated: false)
    }
    // MARK: - The Function For the Picker Done button
    @objc func onDoneButtonTapped() {
        let dataIndex: Int = picker.selectedRow(inComponent: 0)
        lblAddMore.text = arrAddMore[dataIndex]
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        lblAddMore.resignFirstResponder()
    }
    // MARK: - The Function For the Picker Cancel button
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}
// MARK: - UiPicker View DataSource Assigning
extension ProductDetailVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrAddMore.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrAddMore[row]
    }
}
// MARK: - UiPicker View Delegate Assigning
extension ProductDetailVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        let itemselected = arrAddMore[row]
        //        lblAddMore.text = itemselected
    }
}
