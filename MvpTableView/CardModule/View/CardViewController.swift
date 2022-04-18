//
//  CardViewController.swift
//  MvpTableView
//
//  Created by Александр on 17.04.2022.
//

import UIKit
class CardViewController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var presenter : CardViewPresenterProtocol?
    @IBOutlet weak var collection: CardCollectionController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
    }
//MARK: -Private methods
    private func setCollection() {
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellID")
        collection.dataSource = self
    }
}
//MARK: -UICollectionViewDataSource
extension CardViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.stations?.routePath.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CollectionViewCell
        let station = presenter?.stations?.routePath[indexPath.row]
        cell?.configure(model: station!)
        return cell ?? UICollectionViewCell()
    }
    
    
}
//MARK: -CardViewProtocol
extension CardViewController : CardViewProtocol {
    func success() {
        nameLabel.text = presenter?.stations?.name
        collection.reloadData()
    }
    
    func failure(error: Error) {
        print(String(describing: error))
    }
}
