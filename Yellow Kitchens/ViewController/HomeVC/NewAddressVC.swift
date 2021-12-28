//
//  NewAddressVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 18/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewAddressVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDragPinLocation: UILabel!
    // MARK: - properties
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var mapMoveLocation = CLLocationCoordinate2D()
    var home: HomeVC?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        checkLocationServices()
        self.title = Messages.NewAddressTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
}

// MARK: - Action Method
extension NewAddressVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: {
            self.home?.chooseAddress()
        })
    }
    @IBAction func action_Following(_ sender: UIButton) {
    }
    @IBAction func action_EnterAddressManual(_ sender: UIButton) {
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "ConfirmAddressVC") as! ConfirmAddressVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_CureentLocation(_ sender: UIControl) {
       // checkLocationServices()
        updateLocationOnMap(to: locationManager.location ?? CLLocation(), with: nil)
    }
    func checkLocationServices() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 5
            let currentLocation = locationManager.location?.coordinate
            geoCoderGet(latitude: currentLocation?.latitude ?? 0.0, longitude: currentLocation?.longitude ?? 0.0, lblAddress: lblAddress)
        } else {
            Common.showAlertMessage(message: "Accès à l'emplacement refusé, veuillez accéder à l'emplacement", alertType: .warning)
        }
    }
    
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
            let point = MKPointAnnotation()
            point.title = title
            point.coordinate = location.coordinate
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(point)

            let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            self.mapView.setRegion(viewRegion, animated: true)
        }
}
// MARK: - Location Delegate
extension NewAddressVC: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Zoom to user location
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Common.showAlertMessage(message: "Error while updating location \(error.localizedDescription)", alertType: .error)
    }
    // MARK: - Map Move Get Location Coordinate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print(center)
        geoCoderGet(latitude: center.latitude, longitude: center.longitude, lblAddress: lblDragPinLocation)
    }
    func geoCoderGet(latitude: CLLocationDegrees, longitude: CLLocationDegrees, lblAddress: UILabel) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
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
                lblAddress.text = addressString
            }
        }
    }
}
// MARK: - PIN DROP IN MAP
//func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
//      if newState == MKAnnotationView.DragState.ending {
//          let droppedAt = view.annotation?.coordinate
//          let geoCoder = CLGeocoder()
//          let location = CLLocation(latitude: droppedAt?.latitude ?? 0.0, longitude: droppedAt?.longitude ?? 0.0)
//          geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
//              if (error != nil) {
//                  print("Error in reverseGeocode")
//              }
//              let placemark = placemarks! as [CLPlacemark]
//              if placemark.count > 0 {
//                  var placeMark : CLPlacemark!
//                  placeMark = placemarks![0]
//                  var addressString : String = ""
//                  if placeMark.name != nil {
//                      addressString = addressString + placeMark.name! + ", "
//                  }
//                  if placeMark.subLocality != nil {
//                      addressString = addressString + placeMark.subLocality! + ", "
//                  }
//                  if placeMark.locality != nil {
//                      addressString = addressString + placeMark.locality! + ", "
//                  }
//                  if placeMark.country != nil {
//                      addressString = addressString + placeMark.country! + ", "
//                  }
//                  if placeMark.postalCode != nil {
//                      addressString = addressString + placeMark.postalCode! + " "
//                  }
//                  self.lblDragPinLocation.text = addressString
//              }
//          }
//          print(self.lblDragPinLocation.text ?? "")
//          print(droppedAt ?? "")
//      }
//  }
//func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//       guard (annotation is MKUserLocation) else {
//           return nil
//       }
//       let annotationIdentifier = "Identifier"
//       var annotationView: MKAnnotationView?
//       if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//           annotationView = dequeuedAnnotationView
//           annotationView?.annotation = annotation
//       } else {
//           annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//           annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//       }
//       if let annotationView = annotationView {
//           annotationView.canShowCallout = true
//           annotationView.isDraggable = true
//           annotationView.image = UIImage(named: "pinLocation")
//       }
//       return annotationView
//   }
//func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    locationManager.stopUpdatingLocation()
//}
