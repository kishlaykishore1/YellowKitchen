//
//  BottomSheetVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 11/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import SPStorkController
import MapKit
class BottomSheetVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var delivery10MinView: DesignableView!
    @IBOutlet weak var delivery30MinView: DesignableView!
    @IBOutlet weak var openMapViewHeight: NSLayoutConstraint!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var showMapView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var btnNow: UIButton!
    @IBOutlet weak var btnSchedule: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var showMapViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    @IBOutlet weak var loctionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var arrowHeight: NSLayoutConstraint!
    @IBOutlet weak var loctionIconHeight: NSLayoutConstraint!
    @IBOutlet weak var imgFlash: UIImageView!
    @IBOutlet weak var lblNow: UILabel!
    @IBOutlet weak var imgTime: UIImageView!
    @IBOutlet weak var lblShedule: UILabel!
    // MARK: - Properties
    var strKey: String?
    var arrTitle = ["Aujourd’hui","Demain"]
    var arrTime = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var arrTime1 = ["45","30", "15", "0"]
    var chooseAddress: ChooseAddressVC?
    var homeVC: HomeVC?
    var editAddress = ""
    var isEdit: Bool?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        txtAddress.isEnabled = false
        if strKey == "delevery30min" {
            Delivery30Min()
        } else {
            Delivery10Min()
        }
        datePicker.locale = Locale(identifier: "fr")
        datePicker.datePickerMode = .time
        datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        datePicker.minuteInterval = 15
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        if isEdit ?? false {
           txtAddress.text = editAddress
        } else {
             txtAddress.text = "9 rue buffaut 75009 Paris"
        }
    }
    @objc func datePickerChanged(picker: UIDatePicker) {
        print(picker.date)
    }
    @IBAction func action_ShowOnMap(_ sender: UIControl) {
        // MARK: - open google map
        //        let destinationLatitude = "40.7128"
        //        let destinationLongitude = "74.0060"
        //        let customURL = "comgooglemaps://"
        //        if UIApplication.shared.canOpenURL(URL(string: customURL)!) {
        //            UIApplication.shared.open(URL(string: "\(customURL)?saddr=&daddr=\(destinationLatitude),\(destinationLongitude)")!)
        //        } else {
        //            let alert = UIAlertController(title: "Error", message: "Google maps not installed please install google map", preferredStyle: UIAlertController.Style.alert)
        //            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        //            alert.addAction(ok)
        //            self.present(alert, animated:true, completion: nil)
        //        }
        // MARK: - Open apple maps
        let lati: CLLocationDegrees = 48.864716
        let longi: CLLocationDegrees = 2.349014
        UIApplication.shared.open(NSURL(string: "http://maps.apple.com/?address=\(lati),\(longi)")! as URL)
    }
}
// MARK: - Action Method
extension BottomSheetVC {
    @IBAction func action_Delivery30Min(_ sender: UIControl) {
        Delivery30Min()
    }
    @IBAction func action_Delivery10Min(_ sender: UIControl) {
        Delivery10Min()
    }
    @IBAction func action_NowDelevery(_ sender: UIButton) {
        Delivery30Min()
    }
    @IBAction func action_ScheduleDelevery(_ sender: UIButton) {
        Delivery10Min()
    }
    @IBAction func action_Validate(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_EditLocation(_ sender: UIControl) {
        self.dismiss(animated: true) {
            let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "ChooseAddressVC") as! ChooseAddressVC
            let transitionDelegate = SPStorkTransitioningDelegate()
            vc.transitioningDelegate = transitionDelegate
            vc.modalPresentationStyle = .custom
            vc.modalPresentationCapturesStatusBarAppearance = true
            transitionDelegate.customHeight = UIScreen.main.bounds.height/2 + 16
            transitionDelegate.showIndicator = false
            transitionDelegate.translateForDismiss = 50
            transitionDelegate.tapAroundToDismissEnabled = true
            vc.home = self.homeVC
            vc.sheetView = false
            vc.bottomSheet = self
            vc.identifierVC = "BottomSheet"
            self.homeVC?.present(vc, animated: true, completion: nil)
        }
    }
    func Delivery30Min() {
        delivery30MinView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9215686275, blue: 0.2039215686, alpha: 1)
        delivery10MinView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.pickerHeight.constant = 0.0
            self.showMapViewHeight.constant = 0.0
            self.loctionViewHeight.constant = 45.0
            self.arrowHeight.constant = 0.0
            self.loctionIconHeight.constant = 24.0
            self.openMapViewHeight.constant = 0.0
            self.view.layoutIfNeeded()
        })
        lblNow.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        imgFlash.image = #imageLiteral(resourceName: "flash")
        imgTime.image = #imageLiteral(resourceName: "timeGray")
        lblShedule.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        btnNow.setImage(#imageLiteral(resourceName: "RadioFill"), for: .normal)
        btnSchedule.setImage(#imageLiteral(resourceName: "Radioblank"), for: .normal)
    }
    func Delivery10Min() {
        delivery10MinView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9215686275, blue: 0.2039215686, alpha: 1)
        delivery30MinView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.pickerHeight.constant = 120.0
            self.showMapViewHeight.constant = 63.0
            self.loctionViewHeight.constant = 0.0
            self.arrowHeight.constant = 10.0
            self.loctionIconHeight.constant = 0.0
            self.openMapViewHeight.constant = 20.0
            self.view.layoutIfNeeded()
        })
        lblNow.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        imgFlash.image = #imageLiteral(resourceName: "flashGray")
        imgTime.image = #imageLiteral(resourceName: "timeBlack")
        lblShedule.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        btnSchedule.setImage(#imageLiteral(resourceName: "RadioFill"), for: .normal)
        btnNow.setImage(#imageLiteral(resourceName: "Radioblank"), for: .normal)
    }
}
// MARK: - PickerView Delegate
extension BottomSheetVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrTitle.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrTitle[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            //For 12 Hrs
            datePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        } else {
            // For 24 Hrs
            datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        }
    }
}
