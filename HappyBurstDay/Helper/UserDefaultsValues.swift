//
//  UserDefaultsValues.swift
//  HappyBurstDay
//
//  Created by Greem on 8/11/24.
//

import Foundation
final class Defaults{
    static let shared = Defaults()
    init(){ }
    var accessToken:String {
        get{ UserDefaults.standard.string(forKey: "AccessToken") ?? "" }
        set{ UserDefaults.standard.setValue(newValue, forKey: "AccessToken") }
    }
    var refreshToken:String {
        get{ UserDefaults.standard.string(forKey: "RefreshToken") ?? "" }
        set{ UserDefaults.standard.setValue(newValue, forKey: "RefreshToken") }
    }
    var email:String?{
        get{ UserDefaults.standard.string(forKey: "UserEmail") }
        set{ UserDefaults.standard.setValue(newValue, forKey: "UserEmail") }
    }
    var birthDate:String?{
        get{ UserDefaults.standard.string(forKey: "UserBirthDate") }
        set{ UserDefaults.standard.setValue(newValue, forKey: "UserBirthDate") }
    }
    var expiration: Date?{
        get{
            let dateString = UserDefaults.standard.string(forKey: "expiration") ?? ""
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = formatter.date(from: dateString)
            return date
        }
        set{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let newValue{
                let dateStr = formatter.string(from: newValue)
                UserDefaults.standard.setValue(dateStr,forKey: "expiration")
            }
        }
    }
}
