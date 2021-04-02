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
    private var filteredChacters: [GetAllCharactersResponseModel] = []
    private var showAllCharacter: [GetAllCharactersResponseModel] = []
    private var isFiltered: Bool = false
    private var viewModel: CharacterListViewModelType {
        didSet {
            viewModel.delegate = self
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
        viewModel.loadAllCharacter()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        addNotification()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getFilteredCharacter(notification:)), name: NSNotification.Name(rawValue: Constant.NotificationCenterConsant.getFilteredCharacter), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearFilter(notification:)), name: NSNotification.Name(rawValue: Constant.NotificationCenterConsant.filterClear), object: nil)
    }
    
    @objc func filterTapped() {
        let vc = FilterViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate =  self
        present(vc, animated: true)
    }
    
    @objc func clearFilter(notification: NSNotification) {
        viewModel.loadAllCharacter()
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.tableView.reloadData()
        }
    }
    
    @objc func getFilteredCharacter(notification: NSNotification) {
        if let selectedStatus = notification.userInfo?[Constant.UserSessionConstant.selectedStatus] as? CharacterStatus {

            viewModel.filterCharacter(characterStatus: selectedStatus) { [weak self] in
                guard let self = self else { return }
                self.filteredChacters = self.viewModel.returnFilteredCharacters()
                self.showAllCharacter = self.filteredChacters
                self.isFiltered = true
                DispatchQueue.main.async {
                    self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    self.tableView.reloadData()
                }
            }
        }
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
            self.showAllCharacter = self.allChacters
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func navigate(to route: ChracterListRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = CharacterDetailBuilder.build(with: viewModel)
            show(vc, sender: self)
        }
    }
}

extension CharacterListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.showAllCharacter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterListTableViewCell", for: indexPath) as? CharacterListTableViewCell else { return UITableViewCell() }
        cell.character = showAllCharacter[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let screenHeight = view.frame.height
        let cellHeight: CGFloat = screenHeight * 0.2
        
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCharacter(with: showAllCharacter[indexPath.item])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height-50-scrollView.frame.size.height {
            
            guard !viewModel.returnPagination() else {
                return
            }
            var nextPageUrl = viewModel.returnnextPageUrl()
            
            if nextPageUrl != "" {
                self.viewModel.getNextCharacters(pagination: true, nextUrl: "/character/?" + nextPageUrl) {
                    self.showAllCharacter = self.viewModel.returnNextCharacters()
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
}
