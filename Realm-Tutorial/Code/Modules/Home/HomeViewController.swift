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
    
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemonTableView.delegate = self
        self.pokemonTableView.dataSource = self
        
        self.pokemonTableView.register(UINib(nibName: PokemonTableViewCell().description, bundle: nil), forCellReuseIdentifier: PokemonTableViewCell().description)
        
    }
    
    // MARK:- outlets & objc functions
    
    // MARK:- functions
    
    
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: tableView.frame.origin, size: CGSize(width: UIScreen.main.bounds.width, height: 0)))
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "Pokemons"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.frame = CGRect(x: 24, y: 20, width: tableView.frame.size.width - 48, height: label.intrinsicContentSize.height)
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "haha"
        return cell
    }
}


