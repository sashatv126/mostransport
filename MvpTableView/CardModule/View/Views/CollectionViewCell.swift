//
//  CollectionViewCell.swift
//  MvpTableView
//
//  Created by Александр on 17.04.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//функция для настройки ячейки
        func configure(model : RoutePath ) {
        routeLabel.text = model.number
        timeLabel.text = model.timeArrival.first
            routeLabel.backgroundColor = UIColor(model.color ?? "")
            if Int(timeLabel.text!.components(separatedBy: " ")[0]) ?? 0 > 5 {
            timeLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        else {
            timeLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        routeLabel.layer.masksToBounds = true
        routeLabel.layer.cornerRadius = 10
    }
}
