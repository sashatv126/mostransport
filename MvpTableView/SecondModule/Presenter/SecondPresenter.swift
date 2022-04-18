//
//  Presenter.swift
//  MvpTableView
//
//  Created by Александр on 17.04.2022.
//

import Foundation
protocol SecondViewControllerProtocol : class {
    func showStation(model : StationModel? )
}
protocol SecondViewPresenterProtocol : class {
    init(view : SecondViewControllerProtocol, model : StationModel?,router : RouterProtocol)
    func setStations()
    func showSheetController(station : StationModel?)
    func pop()
}
class SecondViewPresenter : SecondViewPresenterProtocol {
    
    weak var view : SecondViewControllerProtocol?
    var model : StationModel?
    var router : RouterProtocol?
    required init(view: SecondViewControllerProtocol, model: StationModel?, router : RouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
//сетим данные
    func setStations() {
        self.view?.showStation(model: model!)
    }
//открыввем карточку
    func showSheetController(station: StationModel?) {
        router?.showSheetViewController(station: station)
    }
//переходим на рут контроллер
    func pop()  {
        router?.pop()
    }
    
    
}
