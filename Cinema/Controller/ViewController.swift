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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        setupChoiceCityButton()
        setupCollectionView()
        setupSearchController()
        setupNavController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMoviesData()
    }
    
    private func setupChoiceCityButton() {
        choiceCityButton.translatesAutoresizingMaskIntoConstraints = false
        choiceCityButton.setTitle("Выбрать город", for: .normal)
        choiceCityButton.setTitleColor(.white, for: .normal)
        choiceCityButton.layer.cornerRadius = 5
        choiceCityButton.clipsToBounds = true
        choiceCityButton.backgroundColor = .systemYellow
        view.addSubview(choiceCityButton)
        
        NSLayoutConstraint.activate([
            choiceCityButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            choiceCityButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            choiceCityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            choiceCityButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: choiceCityButton.topAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    }
    
    private func getMoviesData() {
        apiService.getCity(api: urlCity) { results in
            var cellModels = [CityModel]()
            
            for city in results {
                let model = CityModel(city: city)
                cellModels.append(model)
            }
            
            self.cellModels = cellModels
            self.filteredStudents = cellModels
            self.collectionView.reloadData()
        }
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismisKeybord))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismisKeybord() {
        searchController.searchBar.endEditing(true)
        print("на меня нажали")
    }
    
}

extension ViewController {
    
    func setupNavController() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "фон"), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationItem.title = "выбрать город"
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Caviar-Dreams", size: 15) ?? UIFont.systemFont(ofSize: 15)]
        
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchControllerAction))
    }
    
    @objc func searchControllerAction() {
        hideKeyboard()
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.becomeFirstResponder()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.searchBar.layer.borderColor = UIColor.clear.cgColor
        
        let placeholder = NSAttributedString(string: "Введите название города", attributes: [.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 14) ?? ""])
        searchController.searchBar.searchTextField.attributedPlaceholder = placeholder
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchControllerAction))
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchValue = searchController.searchBar.text?.lowercased() ?? ""
        
        if searchValue.isEmpty {
            filteredStudents = cellModels
        } else {
            filteredStudents = cellModels.filter {
                $0.title.lowercased().hasPrefix(searchValue)
            }
        }
        
        collectionView.reloadData()
    }
    
}
