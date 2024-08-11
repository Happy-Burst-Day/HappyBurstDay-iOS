//
//  WishListViewModel.swift
//  HappyBurstDay
//
//  Created by 조세연 on 8/11/24.
//

import SwiftUI

class WishListViewModel: ObservableObject {
    @Published var selectedTab: Tab = .one
    @Published var wishModels: [WishListModel] = []
    
    func cautionDetails(for index: Int) -> (icon: String, message: String) {
        guard index >= 0 && index < wishModels.count else {
            return ("", "")
        }
        
        let searchModel = wishModels[index]
        
        if let info = searchModel.safeType as? String {
            switch info {
            case "BEWARE_OF_INGESTION":
                return ("icon_caution", "Require Attention")
            case "DONT_EAT":
                return ("icon_ban", "Not Allowed")
            case "SAFE":
                return ("icon_safe", "Safe")
            default:
                return ("", "")
            }
        } else {
            return ("", "")
        }
    }
    
    func getTags() {
        
    }
    
    
}
