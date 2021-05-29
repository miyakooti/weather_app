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
// dark sky mapの代わりに、open weather mapというものを使用。


import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    

    
    @IBOutlet weak var label: UILabel!
    
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
        guard currentLocation != nil else {
            print("え")
            return
        }
        let lon = currentLocation!.coordinate.longitude
        let lat = currentLocation!.coordinate.latitude
        print(lon, lat)  // 座標を取得できました
        
        
        // make URL
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=\(Sensitive.apiKey)"
        print(urlString)
        
        // throw request
        let request = AF.request(urlString)
        request.responseJSON { (response) in
            
            // validation of response data
            guard let data = response.data else {
                print("error in URLSession")
                return
            }
            
            // convert data to models/some object
            var weatherInstance: WeatherModel?
            do {
                let decoder = JSONDecoder()
                weatherInstance = try decoder.decode(WeatherModel.self, from: data)
//                print(weather)
            } catch {
                print("jsonのデコードに失敗しました：", error)
            }
            print("today's weather:", weatherInstance?.weather[0].main)  // これコンソールにはoptionalって付いてるけど、たぶんラベルとかに出力するときはつかないよね。
            
            // update UI
            self.label.text = "it is \(weatherInstance?.weather[0].main)."
        }
        
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        return UITableViewCell()
    }
    
    


}

