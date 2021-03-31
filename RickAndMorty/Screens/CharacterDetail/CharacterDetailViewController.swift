//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    // MARK: Properties
    
    private var viewModel: CharacterDetailViewModelType
    
    // MARK: Views
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .white
        return image
    }()
    
    var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.axis = .horizontal
        sv.spacing = 32
        return sv
    }()
    
    var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    var characterSpeicesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
//    var launchDetailLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.clipsToBounds = true
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.numberOfLines = 0
//        label.textAlignment = .justified
//        label.backgroundColor = .white
//        return label
//    }()
    
    // MARK: Init
    
    init(viewModel: CharacterDetailViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.load()
        
        setUpUI()
    }
    
    // MARK: Funcs
    
    private func setUpUI() {
        view.backgroundColor = .white
    }
}

// MARK: - CharacterDetailViewModelDelegate

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    
    func showDetail(_ character: GetAllCharactersResponseModel) {
        // TODO:
    }
    
}
