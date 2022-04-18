//
//  ModuleBuilder.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import UIKit
import FittedSheets
//Собираем модули 
protocol AssemblyBuilderProtocol {
    func createMainModule(router : RouterProtocol) -> UIViewController
    func createSeconModule(router: RouterProtocol, station: StationModel?) -> UIViewController
    func createSheetModule(station : StationModel?) -> UIViewController
}
class  AssemblyBuilder : AssemblyBuilderProtocol {
  
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
            let view = ViewController()
            let network = NetworkService()
            let presenter = MainPresenter(view: view, networkService: network, router : router)
            view.presenter = presenter
            return view
        }
    func createSeconModule(router: RouterProtocol, station: StationModel?) -> UIViewController {
            let view = SecondViewController()
            let presenter = SecondViewPresenter(view: view, model: station, router: router)
            view.presenter = presenter
            return view
        }
    func createSheetModule(station: StationModel?) -> UIViewController {
            let view = CardViewController()
            let network = NetworkService()
            let presenter = CardPresenter(view: view, networkService: network, model: station)
            view.presenter = presenter
            return view
    }
}
