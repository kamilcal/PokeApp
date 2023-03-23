//
//  ListViewController.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var tableHelper: ListTableViewHelper!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    


}

private extension ListViewController {
    
    private func setupUI(){
        tableHelper = .init(tableView: tableView, navigationController: navigationController!)
    }
}

