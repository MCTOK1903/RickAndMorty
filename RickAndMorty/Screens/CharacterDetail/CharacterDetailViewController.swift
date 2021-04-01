//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {

    // MARK: Properties
    
    private var viewModel: CharacterDetailViewModelType
    
    // MARK: Views
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
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
    
    var numberOfEpisodesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    var GenderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    var originLocationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    var lastKnwLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    var lastSeenEpisodeNAmeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()

    
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(characterImage)
        scrollView.addSubview(characterNameLabel)
        scrollView.addSubview(characterStatusLabel)
        scrollView.addSubview(characterSpeicesLabel)
        scrollView.addSubview(numberOfEpisodesLabel)
        scrollView.addSubview(GenderLabel)
        scrollView.addSubview(originLocationNameLabel)
        scrollView.addSubview(lastKnwLocationLabel)
        scrollView.addSubview(lastSeenEpisodeNAmeLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            characterImage.topAnchor.constraint(equalTo: scrollView.topAnchor,  constant: padding),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            characterImage.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding * 2),
            characterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            characterNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: padding * 2),
            characterStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            characterStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            characterSpeicesLabel.topAnchor.constraint(equalTo: characterStatusLabel.bottomAnchor, constant: padding * 2),
            characterSpeicesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            characterSpeicesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            numberOfEpisodesLabel.topAnchor.constraint(equalTo: characterSpeicesLabel.bottomAnchor, constant: padding * 2),
            numberOfEpisodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            numberOfEpisodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            GenderLabel.topAnchor.constraint(equalTo: numberOfEpisodesLabel.bottomAnchor, constant: padding * 2),
            GenderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            GenderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            originLocationNameLabel.topAnchor.constraint(equalTo: GenderLabel.bottomAnchor, constant: padding * 2),
            originLocationNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            originLocationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            lastKnwLocationLabel.topAnchor.constraint(equalTo: originLocationNameLabel.bottomAnchor, constant: padding * 2),
            lastKnwLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            lastKnwLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            lastSeenEpisodeNAmeLabel.topAnchor.constraint(equalTo: lastKnwLocationLabel.bottomAnchor, constant: padding * 2),
            lastSeenEpisodeNAmeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            lastSeenEpisodeNAmeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            lastSeenEpisodeNAmeLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding * 2)
        ])
    }
}

// MARK: - CharacterDetailViewModelDelegate

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    
    func showDetail(_ character: GetAllCharactersResponseModel) {
        let urlImage = URL(string: character.image)
        self.characterImage.kf.setImage(with: urlImage)
        self.characterNameLabel.text = "Name: " + character.name
        self.characterStatusLabel.text = "Status: " + character.status.rawValue
        self.characterSpeicesLabel.text = "Species: " + character.species
        self.GenderLabel.text = "Gender: " + character.gender
        self.originLocationNameLabel.text = "Origin Location Name: " + character.origin.name
        self.lastKnwLocationLabel.text = "Last Know Location: " + character.location.name
        if let totalEpisodesCount = character.totalEpisodesCount {
            self.numberOfEpisodesLabel.text = " Total Episodes: " + String(totalEpisodesCount)
        }
        if let lastSeenEpisodeName = character.lastSeenEpisodeName {
            self.lastSeenEpisodeNAmeLabel.text = "Last Seen Episode: Episode " + lastSeenEpisodeName
        }
        
    }
}
