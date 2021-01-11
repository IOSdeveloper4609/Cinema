//
//  ViewController.swift
//  Cinema
//
//  Created by Азат Киракосян on 09.01.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    
    
    var cellModels = [CityModel]()
    var filteredStudents = [CityModel]()
    

    private let searchController = UISearchController(searchResultsController: nil)
    private let choiceCityButton = UIButton()
    private var apiService = ApiService()
    private let searchButton = UIButton()
    private let searchImage = UIImage(named: "search")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        greateCollectionView()
        setupSearchController()
        setupChoiceCityButton()
        getMoviesData()
        setupNavController()
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchControllerAction))
        
    }
   
    
    private func setupSearchController() {
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
        
    }
    
    
    private func getMoviesData() {
        
        apiService.getCity(api: "\(urlCity)") { results in
            var cellModels = [CityModel]()
            
            for city in results{
                let model = CityModel(city: city)
                cellModels.append(model)
            }
            self.cellModels = cellModels
            self.filteredStudents = cellModels
            self.collectionView.reloadData()
        }
    }
    
    
   private func setupChoiceCityButton() {
        choiceCityButton.translatesAutoresizingMaskIntoConstraints = false
        choiceCityButton.setTitle("Выбрать город", for: .normal)
        choiceCityButton.setTitleColor(.white, for: .normal)
        choiceCityButton.layer.cornerRadius = 5
        choiceCityButton.clipsToBounds = true
        choiceCityButton.backgroundColor = .systemYellow
        self.view.addSubview(choiceCityButton)
        
        NSLayoutConstraint.activate([
            choiceCityButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            choiceCityButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            choiceCityButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            choiceCityButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let  collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout )
        return collectionView
    }()


   private func greateCollectionView() {
    
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -170)
        ])
    }
}



extension ViewController {
    
    func setupNavController() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "фон"),for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationItem.title = "выбрать город"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Caviar-Dreams", size: 15) ?? UIFont.systemFont(ofSize: 15)]
    }

    @objc func searchControllerAction() {
        
        
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.searchBar.layer.borderColor = UIColor.clear.cgColor
        let placeholder = NSAttributedString(string: "Введите название города", attributes: [.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14) ?? ""])
        searchController.searchBar.searchTextField.attributedPlaceholder = placeholder

    }

//    func setupGestureRecognizer() {
//
//        let tapGesture = UITapGestureRecognizer(target: nil, action: #selector(view.endEditing))
//        tapGesture.numberOfTapsRequired = 1
//        tapGesture.numberOfTouchesRequired = 1
//        collectionView.addGestureRecognizer(tapGesture)
//        collectionView.isUserInteractionEnabled = true
//        view.addGestureRecognizer(tapGesture)
//        view.isUserInteractionEnabled = true
//    }
//
//    @objc func actionGestur(_ sender: UIGestureRecognizer) {
//
//        print("на меня нажали")
//
//
//    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
      
    }
}


extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchValue = searchController.searchBar.text?.lowercased() ?? ""

        if searchValue.isEmpty {
            filteredStudents = cellModels
        } else {
            filteredStudents = cellModels.filter {
                $0.title.lowercased().hasPrefix(searchValue) //?? false
            }
        }
        self.collectionView.reloadData()
    }
}
