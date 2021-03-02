//
//  HomeViewController.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 28/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- outlets
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // MARK:- variables
    var homeViewModel: HomeViewModel!
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 16, y: 8, width: self.pokemonTableView.frame.size.width - 32, height: 72))
        searchBar.placeholder = "Search for Pokemons"
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.black
        searchBar.tintColor = UIColor.black
        searchBar.showsCancelButton = true
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.showsScopeBar = false
        
        let searchBarStyle = searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        
        return searchBar
    }()
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = HomeViewModel()
//        self.addSearchController()
        self.addSearchBarInTableView()
        
        self.pokemonTableView.delegate = self
        self.pokemonTableView.dataSource = self
        self.pokemonTableView.register(UINib(nibName: PokemonTableViewCell.description(), bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.description())
//        self.pokemonTableView.contentInset.top = 20
       
        self.homeViewModel.filteredPokemons.bind { [weak self] in
            if $0 != nil {
                DispatchQueue.main.async {
                    self?.pokemonTableView.reloadSections(IndexSet([0]), with: .fade)
                }
//                self?.pokemonTableView.inser
            }
        }
    }
    
    // MARK:- functions
    func addSearchBarInTableView() {
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 92)))
        view.addSubview(searchBar)
        
        self.pokemonTableView.tableHeaderView = view
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        self.homeViewModel.searchPokemons(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.homeViewModel.resetDataIfNeeded()
        
        self.searchBar.text = ""
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.resignFirstResponder()
    }
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemons = self.homeViewModel.filteredPokemons.value else { return 0 }
        print("new count", pokemons.count)
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PokemonTableViewCell().cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemons = self.homeViewModel.filteredPokemons.value else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.description(), for: indexPath) as! PokemonTableViewCell
        
        cell.setupCell(pokemon: pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.homeViewModel.fetchMoreDataIfNeeded(displayedRow: indexPath.row)
    }
}


