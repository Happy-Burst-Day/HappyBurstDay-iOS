//
//  SearchViewModel.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//
import Foundation

class SearchViewModel: ObservableObject {
    
//    @Published var searchModels: [SearchModel] = []
    @Published var selectedIndices: Set<Int> = []
    @Published var searchModels: [SearchModel] = dummyData
    
    //api 통신해서 searchModels에 저장
    
    func cautionDetails(for index: Int) -> (icon: String, message: String) {
        guard index >= 0 && index < searchModels.count else {
            return ("", "")
        }
        
        let searchModel = searchModels[index]
        
        switch searchModel.info {
        case 1:
            return ("icon_caution", "Require Attention")
        case 2:
            return ("icon_ban", "Do not Consume")
        case 3:
            return ("icon_safe", "It’s Safe")
        default:
            return ("", "")
        }
    }


    func nutritionMessages(for index: Int) -> [String] {
        guard index >= 0 && index < searchModels.count else {
            return [" "]
        }
        let searchModel = searchModels[index]
        
        switch searchModel.foodInfo {
        case 0:
            return [" "]
        case 1:
            return ["essential nutrients"]
        case 2:
            return ["added over 100 people"]
        case 3:
            return ["essential nutrients", "added over 100 people"]
        default:
            return [" "]
        }
    }
    
    func toggleSelection(for index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.remove(index)
        } else {
            selectedIndices.insert(index)
        }
    }
}
