//
//  DefaultRouter.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import UIKit
import FittedSheets
protocol MainRouterProtocol {
    var navigationController : UINavigationController? {get set}
    var assemblyBuilder : AssemblyBuilderProtocol? {get set}
}
protocol RouterProtocol : MainRouterProtocol {
    func initialViewController()
    func showSecondVC(station : StationModel?,router : RouterProtocol)
    func showSheetViewController(station : StationModel?)
    func pop()
}
class Router : RouterProtocol {
   
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController : UINavigationController?
    init(navigationController : UINavigationController, assembly : AssemblyBuilderProtocol ){
        self.navigationController = navigationController
        self.assemblyBuilder = assembly
    }
//сетим рут контроллер
    func initialViewController() {
        if let navigation = navigationController {
            guard let vc = assemblyBuilder?.createMainModule(router: self) else {return}
            navigation.viewControllers = [vc]
        }
    }
//переход на след
    func showSecondVC(station : StationModel?, router : RouterProtocol) {
        if let navigationController = navigationController {
        guard let secondVc = assemblyBuilder?.createSeconModule(router: router , station: station) else {return}
            navigationController.pushViewController(secondVc , animated: true)
        }
    }
//открытие карточки
    func showSheetViewController(station: StationModel?) {
        if let navigationController = navigationController {
        guard let vc = assemblyBuilder?.createSheetModule(station: station) else {return}
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
            sheet.overlayColor = UIColor.gray.withAlphaComponent(0)
            sheet.cornerRadius = 20
            navigationController.present(sheet, animated: false)
        }
    }
//возвращение на рут контроллер
    func pop() {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    
    
    
}
