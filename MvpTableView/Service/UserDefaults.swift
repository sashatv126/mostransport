//
//  UserDefaults.swift
//  MvpTableView
//
//  Created by Александр on 18.04.2022.
//

import Foundation

class DataBase {

    static let shared = DataBase()

    enum SettingKeys : String {
        case station
    }
    let defaults = UserDefaults.standard
    let key = SettingKeys.station.rawValue
    var station : StationModel? {
        get {
            if let data = defaults.value(forKey: key) as? Data {
                return try! PropertyListDecoder().decode(StationModel.self, from: data)
            }
            else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data,forKey: key)
            }
        }
    }
    func saveStop(id : String,name : String , lat : Double , lon : Double)  {
        let station = StationModel(id: id, name: name, lat: lat, lon: lon)
        self.station = station
    }
}
