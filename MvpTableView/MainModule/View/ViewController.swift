//
//  ViewController.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {
//MARK: -Properties
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var presenter : MainViewPresenterProtocol? 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
        setTableView()
    }
//MARK: -Life circle
    private func setTableView() {
//Подписка на делегаты и регистрация ячеек
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        tableView.backgroundColor = #colorLiteral(red: 0.1455829118, green: 0.161157338, blue: 0.1540271603, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        search.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
//MARK: -Extensiom UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.foundStations?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? TableViewCell
        cell?.textLabel?.textColor = #colorLiteral(red: 0.8473886847, green: 0.8473886847, blue: 0.8473886847, alpha: 1)
        let stations = presenter?.foundStations?[indexPath.row]
        cell?.stationLabel.text = stations?.name
        return cell ?? UITableViewCell()
    }
}
//MARK: -Extensiom UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stations = presenter?.foundStations?[indexPath.row]
        presenter?.save(model: stations!)
        presenter?.tap(station: stations)
    }
}
extension ViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(text: searchText)
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
//MARK: -Presenter protocol
extension ViewController : MainViewProtocol {
    func failure(error: Error) {
        print(String(describing: error))
    }
    func success() {
        tableView.reloadData()
    }
    
}
