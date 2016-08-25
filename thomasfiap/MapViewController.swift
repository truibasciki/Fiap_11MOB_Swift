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


class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var latitude:Double = -23.5629
    var longitude:Double = -46.6544
    
    var scale:Double = 5
    
    var annotationList:[MKPointAnnotation] = []
    
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
        mapView.setRegion(coordinationToMap, animated: true)
        
    }

    
    func pinMap(latitude: Double, longitude: Double){

        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let location1:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        let distanceInMeters = self.userLocation.distanceFromLocation(location1)
        
        
        let anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "Meu ponto"
        anotation.subtitle = "Teste do map view! \(distanceInMeters)"
        mapView.addAnnotation(anotation)
        
        annotationList.append(anotation)
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if self.userLocation != locations[0]{
        self.userLocation = locations[0]        
        
        pinMap(latitude, longitude: longitude)
        }
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
