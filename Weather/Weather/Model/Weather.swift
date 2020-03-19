//
//  Weather.swift
//  Weather
//
//  Created by shaoyifei on 2020/3/18.
//  Copyright © 2020 shaoyifei. All rights reserved.
//

import Foundation

class Weather{
    var temp = 0
    var city = ""
    var condition = 0
    
    // 计算属性
    var icon:String{
        switch temp{
        case 0...10:
            return "shower3"
        case 10...15:
            return "tstorm1"
        case 15...20:
            return "cloudy2"
        case 20...30:
            return "fog"
        case 30...100:
            return "sunny"
        default:
            return "dunno"
        }
    }
}
