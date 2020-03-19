//
//  ViewController.swift
//  Weather
//
//  Created by shaoyifei on 2020/3/18.
//  Copyright © 2020 shaoyifei. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,CLLocationManagerDelegate,SelectCityDelegate {
    
    let locationManager = CLLocationManager()
    let key = "9e5e2d9521574c9ee9008e7879571d55"
    let gaodeLoca = GaodeLoca()
    var cityCode = 0
    let weather = Weather()
    @IBOutlet weak var viewLoca: UILabel!
    @IBOutlet weak var viewTemp: UILabel!
    @IBOutlet weak var viewPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestLocation() // 请求用户位置，只请求一次
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 请求授权当前位置
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude // 经度
        let lon = locations[0].coordinate.longitude // 纬度
        let param = ["lat":"\(lon)","lon":"\(lat)"]
        let url = "https://www.wj-ml.me/weather"
        print(param)
//        url,method: .post,parameters: ["page":"1","size":"20"]
        AF.request(url,method: .post,parameters: param,encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let json):
            
                let json = JSON(json)
                self.weather.city = json["data","city"].stringValue
                self.weather.temp = json["data","temperature"].intValue
                let code = json["err_code"].intValue
                if code == 0 {
                    self.viewLoca.text = self.weather.city
                    self.viewTemp.text = "\(self.weather.temp)˚"
                    self.viewPic.image = UIImage(named: self.weather.icon)
                }
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        // 先将经纬度进行转换
//        AF.request(url,parameters: param).responseJSON { response in
//            switch response.result {
//            case .success(let json):
//                let json = JSON(json)
//                self.gaodeLoca.loca = json["locations"].stringValue
//            case .failure(let error):
//                print(error)
//            }
//            let cityUrl = "https://restapi.amap.com/v3/geocode/regeo?location=\(self.gaodeLoca.loca)&key=\(self.key)&radius=100&extensions=base"
//            AF.request(cityUrl).responseJSON { response in
//                switch response.result{
//                case .success(let json):
//                    let json = JSON(json)
//                    let city = json["regeocode","addressComponent","adcode"].stringValue
//                    let a:Int? = Int(city)
//                    self.cityCode = a!
//                case .failure(let error):
//                    print(error)
//                }
//                let weatherUrl = "https://restapi.amap.com/v3/weather/weatherInfo?city=\(self.cityCode)&key=\(self.key)"
//                print(self.cityCode)
//                AF.request(weatherUrl).responseJSON { response in
//                    switch response.result{
//                    case .success(let json):
//                        let json = JSON(json)
//                        self.weather.city = json["lives",0,"province"].stringValue
//                        let t = json["lives",0,"temperature"].stringValue
//                        let a:Int? = Int(t)
//                        self.weather.temp = a!
//                        self.viewLoca.text = self.weather.city
//                        self.viewTemp.text = "\(self.weather.temp)˚"
//                        self.viewPic.image = UIImage(named: self.weather.icon)
//                        print(json)
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
//
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectCity" {
            let vc = segue.destination as! SelectcityController
            vc.currentCity = weather.city
            vc.delgete = self
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didChangeCity(city: String) {
        print(city)
        let url = "https://www.wj-ml.me/search"
        let param = ["city":"\(city)"]
        AF.request(url,parameters: param).responseJSON { response in
            switch response.result {
            case .success(let json):
                let json = JSON(json)
                self.weather.city = json["data","city"].stringValue
                self.weather.temp = json["data","temperature"].intValue
                let code = json["err_code"].intValue
                if code == 0 {
                    self.viewLoca.text = self.weather.city
                    self.viewTemp.text = "\(self.weather.temp)˚"
                    self.viewPic.image = UIImage(named: self.weather.icon)
                }
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}

