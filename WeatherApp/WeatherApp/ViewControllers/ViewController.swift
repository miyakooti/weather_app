//
//  ViewController.swift
//  WeatherApp
//
//  Created by Arai Kousuke on 2021/05/24.
//

// 使用技術
// location: corelocation
// tableview
// custom cell: collection view
// api


import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    
    
    @IBOutlet var table: UITableView!
    
    var models = [Weather]()
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register 2 cells
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        let long = currentLocation?.coordinate.longitude
        let lat = currentLocation?.coordinate.latitude
        print(long, lat)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    


}


struct Weather {
    
}
