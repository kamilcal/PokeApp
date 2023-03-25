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
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Pokemon App ⚡ "
        

        setupUI()
        gradientUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//    navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        navigationController?.navigationBar.prefersLargeTitles = false
    }

}

private extension ListViewController {
    
    private func setupUI(){
        tableHelper = .init(tableView: tableView, viewModel: viewModel, navigationController: navigationController!)
    }
    
    private func gradientUI(){
        let gradientView = Gradient(color: [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)])
        gradientView.frame = view.bounds
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
    }
}

