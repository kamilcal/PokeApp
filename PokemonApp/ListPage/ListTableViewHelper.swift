//
//  ListTableViewHelper.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import UIKit

class ListTableViewHelper: NSObject{
    
    private let cellIdentifier = "ListCell"
    
    private var tableView: UITableView?
    private var navigationController: UINavigationController?

    
    
    init(tableView: UITableView, navigationController: UINavigationController) {
        self.tableView = tableView
        self.navigationController = navigationController
        
        super.init()
        
        setupTableView()
    }
    private func setupTableView() {
        tableView?.register(.init(nibName:  "ListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    

    
}




//    MARK: - Delegate - Datasource

extension ListTableViewHelper: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController

        self.navigationController?.pushViewController(detailVc!, animated: true)
    }
    
}
