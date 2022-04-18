//
//  Presenter.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import Foundation

protocol MainViewProtocol : class {
    func success()
    func failure(error : Error)
}

protocol MainViewPresenterProtocol : class {
    init(view : MainViewProtocol, networkService : NetworkServiceProtocol, router : RouterProtocol)
    func getComments()
    func tap(station : StationModel?)
    func search(text : String)
    func load()
    func save(model : StationModel)
    var stations : [StationModel]? { get set }
    var foundStations : [StationModel]? {get set}
}
class MainPresenter: MainViewPresenterProtocol {
  
    weak var view : MainViewProtocol?
    let networkService : NetworkServiceProtocol?
    var router : RouterProtocol?
    var stations: [StationModel]?
    var foundStations : [StationModel]?
    required init(view: MainViewProtocol, networkService : NetworkServiceProtocol, router : RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getComments()
    }
//Получаем данные из API
    func getComments() {
        let urlstr = "https://api.mosgorpass.ru/v8.2/stop"
        networkService?.loadData(url : urlstr,complition: {[weak self] (result : Result<Model?,Error>) -> Void in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let stations) :
                    self.stations = stations?.data
                    self .foundStations = self.stations
                    self.view?.success()
                case .failure(let error) :
                    self.view?.failure(error : error)
                }
            }
            
        })
    }
//Поиск по полученным данным
    func search(text : String){
        foundStations = text == "" ? stations : stations!.filter({ (array) -> Bool in
            return array.name!.range(of: text,options: .caseInsensitive, range: nil , locale: nil) != nil
        })
    }
//Переход на след экран 
    func tap(station: StationModel?) {
        router?.showSecondVC(station: station, router : router!)
    }
    func load() {
        if let stop = DataBase.shared.station {
            router?.showSecondVC(station: stop, router : router!)
        } else {
            return
        }
    }
    
    func save(model: StationModel) {
        DataBase.shared.saveStop(id: model.id ?? "", name: model.name ?? "", lat: model.lat ?? 0, lon: model.lon ?? 0)
    }
    
}
