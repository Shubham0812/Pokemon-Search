//
//  PokemonTableViewCell.swift
//  Realm-Tutorial
//
//  Created by Shubham Singh on 01/03/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    // MARK:- outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var typeCollectionView: UICollectionView!
    
    // MARK:- variables
    override class func description() -> String {
        return "PokemonTableViewCell"
    }
    
    var type: [String] = [] {
        didSet {
            // reloads the tableView when it's value is set
            self.typeCollectionView.reloadData()
        }
    }
    
    var cellHeight: CGFloat = 128
    
    // MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerView.backgroundColor = UIColor(hex: "fdfdfd")
        
        self.typeCollectionView.delegate = self
        self.typeCollectionView.dataSource = self
        self.typeCollectionView.register(UINib(nibName: TypeCollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: TypeCollectionViewCell.description())
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            
            self?.containerView.layer.cornerRadius = 13
            self?.containerView.layer.shadowPath = UIBezierPath(roundedRect: self!.containerView.bounds, cornerRadius: 13).cgPath
            self?.containerView.layer.shadowColor = UIColor.black.cgColor
            self?.containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            self?.containerView.layer.shadowOpacity = 0.1
            self?.containerView.layer.shadowRadius = 4
        })
        
    }
    
    override func prepareForReuse() {
        // clear the collectionView and the pokemonImage
        self.type = []
        self.imageView?.image = nil
    }
    
    // MARK:- functions
    func setupCell(pokemon: Pokemon) {
        
        self.pokemonName.text = pokemon.name
        self.pokemonNumber.text = "#\(pokemon.id.asString())"
        
        self.type = pokemon.pokemonType
        
        if let pokemonImage = ImageCache.shared.imageMap[pokemon.id] {
            self.pokemonImageView.image = UIImage(data: pokemonImage)
        } else {
            print("fetching image for #\(pokemon.pokemonNumber)")
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.imageURL)!) { (data, _, error) in
                if (error == nil) {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        ImageCache.shared.imageMap[pokemon.id] = data
                        self.pokemonImageView.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}

extension PokemonTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionViewCell.description(), for: indexPath) as! TypeCollectionViewCell
        cell.setupCell(type: type[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 32)
    }
}
