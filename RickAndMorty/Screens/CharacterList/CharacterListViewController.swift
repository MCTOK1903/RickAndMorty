//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Celal Tok on 30.03.2021.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    // MARK: View
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterListTableViewCell.self, forCellReuseIdentifier: "characterListTableViewCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: Properties

    let service = Services()
    private var allChacters: [GetAllCharactersResponseModel] = []
    private var viewModel: CharacterListViewModelType? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    // MARK: Init
    
    init(viewModel: CharacterListViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterListViewModel(service: service)
        viewModel?.loadAllCharacter()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        setUpUI()
    }
    
    
    private func setUpUI() {
        view.backgroundColor = .white
//        tableView.frame = view.bounds
        
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CharacterListViewModelDelegate


extension CharacterListViewController: CharacterListViewModelDelegate {
    
    func handleViewModelOutput(_ output: CharacterListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            print(isLoading)
        case .showCharacterList(let characters):
            self.allChacters = characters
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: ChracterListRoute) {
        switch route {
        case .detail:
            break
        }
    }
}


extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.allChacters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterListTableViewCell", for: indexPath) as? CharacterListTableViewCell else { return UITableViewCell() }
        cell.character = allChacters[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let screenHeight = view.frame.height
        let cellHeight: CGFloat = screenHeight * 0.2
        
        return CGFloat(cellHeight)
    }
}
