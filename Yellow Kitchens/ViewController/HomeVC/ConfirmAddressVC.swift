//
//  ConfirmAddressVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 19/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import MapKit

class ConfirmAddressVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtAppartment: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtNameOfAddress: UITextField!
    // MARK: - properties
    let locationManager = CLLocationManager()
    var arrayList = ["Maison","Bureau"]
    let picker = ADCountryPicker()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        mapView.delegate = self
        self.title = Messages.NewAddressTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        picker.searchBarBackgroundColor = UIColor.white
        picker.hidesNavigationBarWhenPresentingSearch = false
        picker.defaultCountryCode = "FR"
        picker.delegate = self
    }
    @IBAction func action_SaveAddress(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_CountryPicker(_ sender: UIControl) {
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
}
// MARK: - Action Method
extension ConfirmAddressVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_IndicateOnMap(_ sender: UIButton) {
        checkLocationServices()
    }
    @IBAction func action_ToChoose(_ sender: UIButton) {
        actionSheet()
    }
    func checkLocationServices() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 5
        } else {
            Common.showAlertMessage(message: "Accès à l'emplacement refusé, veuillez accéder à l'emplacement", alertType: .warning)
        }
    }
    func actionSheet() {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for selectName in arrayList {
            let Name = UIAlertAction(title: selectName, style: .default, handler: {(alert: UIAlertAction!) -> Void in
                print(alert!)
                print(selectName)
                self.txtNameOfAddress.text = selectName
            })
            optionMenu.addAction(Name)
        }
        let addMore = UIAlertAction(title: "Autre...", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            print(alert!)
            self.applyNewAddress()
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: {(alert: UIAlertAction!) -> Void in
            print(alert!)
            print("Annuler")
        })
        optionMenu.addAction(addMore)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    func applyNewAddress() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Nouvelle adresse", message: "Donnez un nom à votre nouvelle adresse pour vous en souvenir plus facilement.", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Mon adresse"
                textField.autocapitalizationType = .sentences
                textField.isEnabled = false
            }
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: { ( _ : UIAlertAction!) -> Void in
            })
            let saveAction = UIAlertAction(title: "Confirmer", style: .default, handler: { _ -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                if firstTextField.text?.trim().count == 0 {
                    return
                }
                self.arrayList.append(firstTextField.text ?? "")
            })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: {
                let firstTextField = alertController.textFields![0] as UITextField
                firstTextField.isEnabled = true
                firstTextField.becomeFirstResponder()
            })
        }
    }
}
// MARK: - Location Delegate
extension ConfirmAddressVC: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Zoom to user location
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if (error != nil) {
                    print("Error in reverseGeocode")
                }
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count > 0 {
                    var placeMark : CLPlacemark!
                    placeMark = placemarks![0]
                    var addressString : String = ""
                    if placeMark.name != nil {
                        addressString = addressString + placeMark.name! + ", "
                    }
                    if placeMark.subLocality != nil {
                        addressString = addressString + placeMark.subLocality! + ", "
                    }
                    if placeMark.locality != nil {
                        addressString = addressString + placeMark.locality! + ", "
                    }
                    if placeMark.country != nil {
                        addressString = addressString + placeMark.country! + ", "
                    }
                    if placeMark.postalCode != nil {
                        addressString = addressString + placeMark.postalCode! + " "
                    }
                    print(addressString)
                    self.txtAddress.text = addressString
                    self.txtCity.text = placeMark.locality
                    self.txtPostalCode.text = placeMark.postalCode
                }
            }
        }
    }
    // MARK: - Map Move Get Location Coordinate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print(center)
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil) {
                print("Error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                var placeMark : CLPlacemark!
                placeMark = placemarks![0]
                var addressString : String = ""
                if placeMark.name != nil {
                    addressString = addressString + placeMark.name! + ", "
                }
                if placeMark.subLocality != nil {
                    addressString = addressString + placeMark.subLocality! + ", "
                }
                if placeMark.locality != nil {
                    addressString = addressString + placeMark.locality! + ", "
                }
                if placeMark.country != nil {
                    addressString = addressString + placeMark.country! + ", "
                }
                if placeMark.postalCode != nil {
                    addressString = addressString + placeMark.postalCode! + " "
                }
                print(addressString)
                self.txtAddress.text = addressString
                self.txtCity.text = placeMark.locality
                self.txtPostalCode.text = placeMark.postalCode
            }
        }
    }
}
extension ConfirmAddressVC: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        lblCountryCode.text = "\(dialCode)"
        picker.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.txtMobile.becomeFirstResponder()
            }
        }
    }
}
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard (annotation is MKUserLocation) else {
//            return nil
//        }
//        let annotationIdentifier = "Identifier"
//        var annotationView: MKAnnotationView?
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        } else {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        if let annotationView = annotationView {
//            annotationView.canShowCallout = true
//            annotationView.isDraggable = true
//            annotationView.image = UIImage(named: "pinLocation")
//        }
//        return annotationView
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
//        if newState == MKAnnotationView.DragState.ending {
//            let droppedAt = view.annotation?.coordinate
//            let geoCoder = CLGeocoder()
//            let location = CLLocation(latitude: droppedAt?.latitude ?? 0.0, longitude: droppedAt?.longitude ?? 0.0)
//            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
//                if (error != nil) {
//                    print("Error in reverseGeocode")
//                }
//                let placemark = placemarks! as [CLPlacemark]
//                if placemark.count > 0 {
//                    var placeMark : CLPlacemark!
//                    placeMark = placemarks![0]
//                    var addressString : String = ""
//                    if placeMark.name != nil {
//                        addressString = addressString + placeMark.name! + ", "
//                    }
//                    if placeMark.subLocality != nil {
//                        addressString = addressString + placeMark.subLocality! + ", "
//                    }
//                    if placeMark.locality != nil {
//                        addressString = addressString + placeMark.locality! + ", "
//                    }
//                    if placeMark.country != nil {
//                        addressString = addressString + placeMark.country! + ", "
//                    }
//                    if placeMark.postalCode != nil {
//                        addressString = addressString + placeMark.postalCode! + " "
//                    }
//                    print(addressString)
//                    self.txtAddress.text = addressString
//                    self.txtCity.text = placeMark.locality
//                    self.txtPostalCode.text = placeMark.postalCode
//                }
//            }
//            print(droppedAt ?? "")
//        }
//    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        locationManager.stopUpdatingLocation()
//    }
