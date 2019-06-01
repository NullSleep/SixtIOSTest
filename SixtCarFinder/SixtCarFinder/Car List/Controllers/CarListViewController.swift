//
//  CarListViewController.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var handleView: UIView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func setUpViews() {
    handleView.layer.cornerRadius = 2.5
    containerView.round(corners: [.topLeft, .topRight], radius: 8)
    tableView.isUserInteractionEnabled = false
  }
}

// MARK: - UITableViewDataSource
extension CarListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return LocationData.default.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as? CarTableViewCell else { return UITableViewCell() }
    
    let data = LocationData.default[indexPath.row]
    cell.titleLabel.text = data.title
    cell.subtitleLabel.text = data.subtitle
    cell.locationIcon.image = UIImage(named: data.imgString)!
    return cell
  }
}

// MARK: - UITableViewDelegate
extension CarListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

