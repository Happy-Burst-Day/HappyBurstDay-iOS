//
//  FoodDto.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
struct FoodDto: Codable{
    let id:Int
    let name:String
    let imageURL:String
    let safeType: String
    let tages: [String]
    let diseaseWarnings:[FoodDiseaseWarning]
    let vitaminC:Int
    let iron:Int
    let calcium:Int
    let protein:Int
}
