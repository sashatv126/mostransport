//
//  CardModel.swift
//  MvpTableView
//
//  Created by Александр on 18.04.2022.
//

import Foundation
struct Stops : Decodable {
  let name : String?
  var routePath : [RoutePath]
}
struct RoutePath : Decodable {
  let timeArrival : [String]
  let color : String?
  let number : String?
}
