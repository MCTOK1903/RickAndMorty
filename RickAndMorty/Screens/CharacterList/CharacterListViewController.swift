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
        tableView.register(CharacterListTableViewCell.self, forCellReuseIdentifier: Constant.CharacterListVCConstant.characterListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CharacterListCollectionViewCell.self, forCellWithReuseIdentifier: Constant.CharacterListVCConstant.characterListCollectionViewCell)
        return collectionView
    }()
    
    // MARK: Properties
    
    let service = Services()
    private lazy var allChacters: [GetAllCharactersResponseModel] = []
    private lazy var filteredChacters: [GetAllCharactersResponseModel] = []
    private lazy var showAllCharacter: [GetAllCharactersResponseModel] = []
    private lazy var isFiltered: Bool = false
    private lazy var isGridView: Bool = true
    private let defaults = UserDefaults.standard
    private lazy var savedArray: [Int] = []
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        addNotification()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedArray = defaults.object(forKey: Constant.UserSessionConstant.favoriteCharactersId) as? [Int] ?? [Int]()
        isGridView ? collectionView.reloadData() : tableView.reloadData()
    }
    
    // MARK: Funcs
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        if isGridView {
            self.collectionView.isHidden = false
            self.tableView.isHidden = true
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        } else {
            self.tableView.isHidden = false
            self.collectionView.isHidden = true
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
        
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        
        var buttonTitle: String = "Grid"
        
        if isGridView {
            buttonTitle = "List"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constant.CharacterListVCConstant.filterText, style: .plain, target: self, action: #selector(filterTapped))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(changeView))
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
    
    @objc func changeView() {
        self.isGridView = !isGridView
        
        self.setUpUI()
    }
    
    @objc func clearFilter(notification: NSNotification) {
        viewModel.loadAllCharacter()
        DispatchQueue.main.async {
            if self.isGridView {
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            } else {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
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
                    if self.isGridView {
                        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                        self.collectionView.reloadData()
                    } else {
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    }
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
                guard let self = self else { return }
                if self.isGridView {
                    self.collectionView.reloadData()
                } else {
                    self.tableView.reloadData()
                }
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

// MARK: - UIViewControllerTransitioningDelegate

extension CharacterListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.showAllCharacter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterListTableViewCell", for: indexPath) as? CharacterListTableViewCell else { return UITableViewCell() }
        
        showAllCharacter[indexPath.item].isFavorite = false
        
        for item in savedArray {
            if item == showAllCharacter[indexPath.item].id {
                showAllCharacter[indexPath.item].isFavorite = true
            }
        }
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
        
        var scrollHeight: CGFloat = 0.0
        
        if isGridView {
            scrollHeight = self.collectionView.contentSize.height
        } else {
            scrollHeight = self.tableView.contentSize.height
        }
        
        if position > scrollHeight-50-scrollView.frame.size.height {
            guard !viewModel.returnPagination() else {
                return
            }
            
            let nextPageUrl = viewModel.returnnextPageUrl()
            
            if nextPageUrl != "" {
                self.viewModel.getNextCharacters(pagination: true, nextUrl: Constant.NetworkConstant.getNextCharacterPath + nextPageUrl) {
                    self.showAllCharacter = self.viewModel.returnNextCharacters()
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        if self.isGridView {
                            self.collectionView.reloadData()
                        } else {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showAllCharacter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CharacterListVCConstant.characterListCollectionViewCell, for: indexPath) as? CharacterListCollectionViewCell else { return UICollectionViewCell() }
        
        showAllCharacter[indexPath.item].isFavorite = false
        
        for item in savedArray {
            if item == showAllCharacter[indexPath.item].id {
                showAllCharacter[indexPath.item].isFavorite = true
            }
        }
        
        cell.character = showAllCharacter[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCharacter(with: showAllCharacter[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = view.frame.height/3
        return CGSize(width: width, height: height)
    }
}
