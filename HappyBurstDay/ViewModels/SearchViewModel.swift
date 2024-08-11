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
    
    func cautionDetails(for index: Int) -> (icon: String, message: String) {
        guard index >= 0 && index < searchModels.count else {
            return ("", "")
        }
        
        let searchModel = searchModels[index]
        
        if let info = searchModel.info as? Int {
            switch info {
            case 1:
                return ("icon_caution", "Require Attention")
            case 2:
                return ("icon_ban", "Do not Consume")
            case 3:
                return ("icon_safe", "It’s Safe")
            default:
                return ("", "")
            }
        } else {
            return ("", "")
        }
    }

    func nutritionMessages(for index: Int) -> (tag1: String, tag2: String) {
        guard index >= 0 && index < searchModels.count else {
            return ("", "")
        }
        let searchModel = searchModels[index]
        
        switch searchModel.foodInfo {
            
        case 1:
            return ("Sometime Possible", "added over 20 people")
        case 2:
            return ("Consume Frequently", "added over 10 people")
        case 3:
            return ("Available after 30 days", "added over 30 people")
        default:
            return ("", "")
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
