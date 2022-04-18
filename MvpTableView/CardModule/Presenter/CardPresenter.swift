//
//  CardPresenter.swift
//  MvpTableView
//
//  Created by Александр on 18.04.2022.
//

import Foundation
protocol CardViewProtocol : class {
    func success()
    func failure(error : Error)
}
protocol CardViewPresenterProtocol : class {
    init(view : CardViewProtocol?, networkService : NetworkServiceProtocol, model : StationModel?)
    func getComments()
    var stations : Stops? { get set }
}
class CardPresenter: CardViewPresenterProtocol {
    weak var view : CardViewProtocol?
    let networkService : NetworkServiceProtocol?
    let model : StationModel?
    var stations: Stops?
    required init(view: CardViewProtocol?, networkService: NetworkServiceProtocol, model : StationModel?) {
        self.view = view
        self.model = model
        self.networkService = networkService
        getComments()
    }
//получаем детальные данные о остановке
    func getComments() {
        let urlstr = "https://api.mosgorpass.ru/v8.2/stop/\(model?.id ?? "")"
        networkService?.loadData(url : urlstr ,complition: {[weak self] (result : Result<Stops?,Error>) -> Void in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let stations) :
                    self.stations = stations
                    self.view?.success()
                case .failure(let error) :
                    self.view?.failure(error : error)
                }
            }
            
        })
    }
}
