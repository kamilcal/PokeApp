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
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView?.register(.init(nibName:  "ListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.sectionHeaderHeight = 100
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    
    //    MARK: - Header

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") ?? UITableViewHeaderFooterView(reuseIdentifier: "Header")
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokemon")

        
        headerView.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
        ])
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Pokémon App"
        headerLabel.textColor = .black
        headerLabel.font = UIFont(name: "Futura-Bold", size: 35)
        headerView.contentView.addSubview(headerLabel)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 35)

        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.contentView.topAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor, constant: -20)
        ])
        
        headerView.contentView.backgroundColor = .clear
        
        return headerView
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
