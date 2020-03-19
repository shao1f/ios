//
//  SelectcityController.swift
//  Weather
//
//  Created by shaoyifei on 2020/3/19.
//  Copyright © 2020 shaoyifei. All rights reserved.
//

import UIKit

protocol SelectCityDelegate {
    func didChangeCity(city:String)
}

class SelectcityController: UIViewController {
    var currentCity = "未知"
    var delgete:SelectCityDelegate?
    @IBOutlet weak var current: UILabel!
    @IBAction func selectButton(_ sender: Any) {
        delgete?.didChangeCity(city: cityText.text!)
    }
    @IBOutlet weak var cityText: UITextField!
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        current.text = currentCity
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
