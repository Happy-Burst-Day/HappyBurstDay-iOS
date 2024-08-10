//
//  DateExtension.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
extension Date{
    var yyyyMMdd:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}
