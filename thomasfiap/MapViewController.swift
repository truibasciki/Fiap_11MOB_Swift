//
//  MapViewController.swift
//  thomasfiap
//
//  Created by Usuário Convidado on 24/08/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!
    
    
    var locationManager: CLLocationManager!
    
    
    var latitude:Double = -23.5629
    var longitude:Double = -46.6544
    
    var scale:Double = 5
        
    var userLocation: CLLocation!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addBackground()
        navigationItem.imageNavigation()
        
        setMap()
        
        //solicita autorizacao e obtem posicao do usuario
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        map.delegate = self;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setMap(){
        //localização inicial
        let locInicial = CLLocation(latitude: latitude, longitude: longitude);
        
        //raio de visualização da origem
        let raio: CLLocationDistance = 1000
        
        //objeto que agrega posição e raio
        let coordinationToMap = MKCoordinateRegionMakeWithDistance(locInicial.coordinate, raio * scale , raio * scale)
        
        //configura o mapa
        map.setRegion(coordinationToMap, animated: true)
        
    }

    
    func pinMap(latitude: Double, longitude: Double){

        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let location1:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        let distanceInMeters = self.userLocation.distanceFromLocation(location1)
        
        
//        let anotation = MKPointAnnotation()
//        anotation.coordinate = location
//        anotation.title = "Meu ponto"
//        anotation.subtitle = "Teste do map view! \(NSString(format: "%2.f", distanceInMeters))"
//        mapView.addAnnotation(anotation)
        
        // Drop a pin
        
        
        let dropPin = FutAnotation(coordinate: location, title: " Metros", subtitle: "\(NSString(format: "%2.f", distanceInMeters))", detailURL: NSURL(string: "https://google.com")!, enableInfoButton : true)
        mapView(map, viewForAnnotation: dropPin)
//        
        map.addAnnotation(dropPin)
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if self.userLocation != locations[0]{
        self.userLocation = locations[0]        
        
        pinMap(latitude, longitude: longitude)
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        if (annotation.isKindOfClass(FutAnotation)) {
            let customAnnotation = annotation as? FutAnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("FutAnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView.annotation = annotation;
            }
            return annotationView
        } else {
            let reuseId = "test"
            
            var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.image = UIImage(named:"flag_marker.png")
                anView!.canShowCallout = true
            }
            else {
                //we are re-using a view, update its annotation reference...
                anView!.annotation = annotation
            }
            
            return anView
        }
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            performSegueWithIdentifier("MapaPerfilSegue", sender: view)
        }
    }
    
    @IBAction func abrirLista(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
