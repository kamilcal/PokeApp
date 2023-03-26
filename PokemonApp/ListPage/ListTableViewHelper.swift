//
//  ListTableViewHelper.swift
//  PokemonApp
//
//  Created by kamilcal on 23.03.2023.
//

import UIKit
import SDWebImage


class ListTableViewHelper: NSObject{
    
    private let cellIdentifier = "ListCell"
    private var tableView: UITableView?
    private var navigationController: UINavigationController?
    private var viewModel = ListViewModel()
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    
    init(tableView: UITableView, viewModel: ListViewModel, navigationController: UINavigationController) {
        self.tableView = tableView
        self.navigationController = navigationController
        self.viewModel = viewModel
        
        super.init()
        
        setupTableView()
        viewModel.delegate = self
        activityIndicator.startAnimating()
        viewModel.getPokemonList()
        
    }
}
//MARK: - SetupUI

private extension ListTableViewHelper{
    
    private func setupTableView() {
        tableView?.register(.init(nibName:  "ListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        tableView?.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: tableView!.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: tableView!.centerYAnchor),
        ])
        activityIndicator = indicator
    }

}

//MARK: - Delegate - Datasource

extension ListTableViewHelper: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonListCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        let pokemon = viewModel.pokemonList[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        if let idString = viewModel.getPokemonId(at: indexPath.row), let id = Int(idString) {
            detailVc?.id = id
            print(detailVc?.id)
            self.navigationController?.pushViewController(detailVc!, animated: true)
        }
        
    }
}
//MARK: - PokemonListViewModelDelegate

extension ListTableViewHelper: PokemonListViewModelDelegate {
    
    func pokemonListDidUpdate() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func pokemonListDidFailToUpdate(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Unable to update Pokemon list. Please try again later.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            self.navigationController?.present(alertController, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()

        }
    }
    
}
