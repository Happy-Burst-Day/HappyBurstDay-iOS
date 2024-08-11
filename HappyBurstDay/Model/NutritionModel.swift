//
//  NutritionModel.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import Foundation

struct NutritionModel: Identifiable {
    let id: Int
    let name: String
    let safeType: String
    let tages: [String]
    let diseaseWarnings:[DiseaseWarning]
    let vitaminC: Int
    let iron: Int
    let calcium: Int
    let protein: Int
}

struct DiseaseWarning:Codable{
    let title:String
    let description: String
}
