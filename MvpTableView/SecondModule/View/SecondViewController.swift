//
//  SecondViewController.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import UIKit
import MapKit
class SecondViewController: UIViewController {
//MARK: -Properties
    @IBOutlet weak var map: MKMapView!
    var presenter : SecondViewPresenterProtocol?
    
    
//MARK: -Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapKit()
        presenter?.setStations()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
//MARK: -Private methods
    private func setMapKit() {
        map.delegate = self
    }
    @IBAction func bus(_ sender: Any) {
        presenter?.pop()
    }
}
//MARK: -SecondViewControllerProtocol
extension SecondViewController : SecondViewControllerProtocol {
    func showStation(model: StationModel?) {
        map.removeAnnotations(map.annotations)
        let lat = model?.lat
        let lon = model?.lon
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2DMake(lat!, lon!)
        annotation.coordinate = coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate,span: span)
        map.setRegion(region, animated: true)
        map.addAnnotation(annotation)
        presenter?.showSheetController(station: model)
    }
}
//MARK: -MKMapViewDelegate
extension SecondViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
 guard !(annotation is MKUserLocation) else {
     return nil
 }

  let annotationIdentifier = "bus"
  var annotationView: MKAnnotationView?
  if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
     annotationView = dequeuedAnnotationView
     annotationView?.annotation = annotation
 }
 else {
     annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
     annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
 }

  if let annotationView = annotationView {

     annotationView.canShowCallout = true
    annotationView.image = UIImage(named: "passenger")
     
 }
   return annotationView
 }
}
