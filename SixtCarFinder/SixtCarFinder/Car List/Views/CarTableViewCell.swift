//
//  CarTableViewCell.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 6/1/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

  // MARK: - Cell IBoutlets
  @IBOutlet weak var locationIcon: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var makerLabel: UILabel!
  @IBOutlet weak var transmissionLabel: UILabel!
  @IBOutlet weak var cleanlinessLabel: UILabel!
  @IBOutlet weak var licensePlateLabel: UILabel!
  @IBOutlet weak var fuelTypeLabel: UILabel!
  @IBOutlet weak var fuelLevelLabel: UILabel!

  // MARK: - Public methods
  public func configureWith(carData: CarItem) {
      let url = URL(string: carData.carImageUrl ?? "")

      locationIcon.setImage(with: url)
      titleLabel.text = carData.modelName
      ownerLabel.text = carData.ownerName
      makerLabel.text = carData.make
      transmissionLabel.text = carData.transmission
      cleanlinessLabel.text = carData.carCleanliness
      licensePlateLabel.text = carData.licensePlate
      fuelTypeLabel.text = carData.fuelType
      fuelLevelLabel.text = carData.carFuelPercentage
  }
}

// MARK: - UIImageView extension
extension UIImageView {
  func setImage(with url: URL?) {
    backgroundColor = .black
    if let imageURL = url {
      sd_setImage(with: imageURL,
                  placeholderImage: UIImage(named: "defaultCarImg"),
                  options: [.scaleDownLargeImages], completed: nil)
    } else {
      image = UIImage(named: "defaultCarImg")
    }
    layer.cornerRadius = 8.0
    layer.masksToBounds = true
  }
}
