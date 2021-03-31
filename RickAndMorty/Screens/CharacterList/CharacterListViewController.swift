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
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        setUpUI()
    }
    
    
    private func setUpUI() {
        view.backgroundColor = .black
    }
}

extension CharacterListViewController: CharacterListViewModelDelegate {
    
    func handleViewModelOutput(_ output: CharacterListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            print(isLoading)
        case .showCharacterList(let characters):
            self.allChacters = characters
            //reload data
        }
    }
    
    func navigate(to route: ChracterListRoute) {
        switch route {
        case .detail:
            break
        }
    }
}
