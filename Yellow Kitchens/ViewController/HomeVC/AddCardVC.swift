//
//  AddCardVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 18/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import PayCardsRecognizer

class AddCardVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var txtExpDate: UITextField!
    // MARK: - properties
    var recognizer: PayCardsRecognizer!
    var ChoosePayment = ChoosePaymentVC()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtExpDate.delegate = self
        txtCardNumber.delegate = self
        setNavShadow(shadowRadius: 0, shadowOpacity: 0, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.AddCardTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func viewDidAppear(_ animated: Bool) {
        self.txtCardNumber.becomeFirstResponder()
    }
}
// MARK: - Action Method
extension AddCardVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_AddCard(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_CardScaner(_ sender: UIButton) {
        recognizer = PayCardsRecognizer(delegate: self, resultMode: .async, container: self.view, frameColor: #colorLiteral(red: 0.9647058824, green: 0.9333333333, blue: 0.1882352941, alpha: 1))
        recognizer.startCamera()
    }
}
// MARK: - textField Delegate Delegate
extension AddCardVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtExpDate {
            let currentText = txtExpDate.text! as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            if string == "" {
                if textField.text?.count == 3 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
                return true
            }
            if updatedText.count == 5 {
                expDateValidation(dateStr:updatedText)
                return updatedText.count <= 5
            } else if updatedText.count > 5 {
                return updatedText.count <= 5
            } else if updatedText.count == 1 {
                if updatedText > "1"{
                    return updatedText.count < 1
                }
            } else if updatedText.count == 2 {   //Prevent user to not enter month more than 12
                if updatedText > "12"{
                    return updatedText.count < 2
                }
            }
            textField.text = updatedText
            if updatedText.count == 2 {
                textField.text = "\(updatedText)/"   //This will add "/" when user enters 2nd digit of month
            }
            return false
        }
        if textField == txtCardNumber {
            guard let text = txtCardNumber.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            txtCardNumber.text = formattedNumber(number: newString)
            return false
        } else {
            return true
        }
    }
    // MARK: - check Valid Expire Date to Current Date
    func expDateValidation(dateStr:String) {
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
        let enterdYr = Int(dateStr.suffix(2)) ?? 0   // get last two digit from entered string as year
        let enterdMonth = Int(dateStr.prefix(2)) ?? 0  // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user
        if enterdYr > currentYear {
            if (1 ... 12).contains(enterdMonth) {
                print("Entered Date Is Right")
//                self.txtCvv.becomeFirstResponder()
            } else {
                print("Entered Date Is Wrong")
                Common.showAlertMessage(message: "Entered date is wrong", alertType: .warning)
            }
        } else if currentYear == enterdYr {
            if enterdMonth >= currentMonth {
                if (1 ... 12).contains(enterdMonth) {
                    print("Entered Date Is Right")
                } else {
                    print("Entered Date Is Wrong")
                    Common.showAlertMessage(message: "Entered Year is wrong", alertType: .warning)
                }
            } else {
                print("Entered Date Is Wrong")
                Common.showAlertMessage(message: "Entered month is wrong", alertType: .warning)
            }
        } else {
            print("Entered Date Is Wrong")
            Common.showAlertMessage(message: "Entered Year is wrong", alertType: .warning)
        }
    }
    // MARK: - Card Format
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXXX XXXX XXXX XXXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
                print(result)
            } else {
                result.append(ch)
            }
        }
        if result.count == 19 {
          self.txtExpDate.becomeFirstResponder()
        }
        return result
    }
}
// MARK: - PayCardsRecognizer Delegate
extension AddCardVC: PayCardsRecognizerPlatformDelegate {
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        print(result.recognizedNumber ?? "")
        txtCardNumber.text = result.recognizedNumber ?? ""
        txtExpDate.text = "\(result.recognizedExpireDateMonth ?? "")/\(result.recognizedExpireDateYear ?? "")"
        recognizer.stopCamera()
    }
}
