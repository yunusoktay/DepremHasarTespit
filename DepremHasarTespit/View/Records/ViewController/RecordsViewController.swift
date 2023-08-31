//
//  RecordsViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 20.06.2023.
//

import UIKit

class RecordsViewController: UIViewController, RecordViewViewModelDelegate {
    @IBOutlet var tableView: UITableView!
    
    let viewModel = RecordViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getInfo()
        configureTableView()
        dataUpdated()
        print(viewModel.imageDataArray)
    }
   
    func dataUpdated() {
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let nib = UINib(nibName: "RecordTableViewCell", bundle: Bundle(for: RecordTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
    }

}

extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        let title = viewModel.titleArray[indexPath.row]
        let address = viewModel.addressArray[indexPath.row]
        
        cell.titleLabel.text = title
        cell.addressLabel.text = address
        cell.viewModel = viewModel
        cell.configureCollectionView()
        
        
        return cell
    }
    
}
