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
  @IBOutlet var headerView: UIView!

  // MARK: - IBOutlets
  var carList = [CarItem]()

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
    tableView.isUserInteractionEnabled = true
  }
}

// MARK: - UITableViewDataSource
extension CarListViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return carList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell",
                                                   for: indexPath) as? CarTableViewCell else {
      return UITableViewCell()
    }

    let carData = carList[indexPath.row]
    cell.configureWith(carData: carData)

    return cell
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return headerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
}

// MARK: - UITableViewDelegate
extension CarListViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
