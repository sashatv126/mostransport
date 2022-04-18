//
//  Person.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import Foundation
//Модель для парсинга данных
struct Model : Codable {
    let data : [StationModel]
}

struct  StationModel : Codable {
    let id : String?
    let name : String?
    let lat : Double?
    let lon : Double?
}

