//
//  CharacterListCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Celal Tok on 2.04.2021.
//

import UIKit
import Kingfisher

class CharacterListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var character: GetAllCharactersResponseModel? {
        didSet {
            configureCellContent()
        }
    }
    
    // MARK: View
    
    let characterImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var characterSpeciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
              contentView.frame = contentView.frame.inset(by: margins)
              contentView.layer.cornerRadius = 8
       
        configureCell()
    }
    
    // MARK:  Funcs
    
    private func configureCell() {
        contentView.addSubview(characterImage)
        contentView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(characterNameLabel)
        verticalStack.addArrangedSubview(characterSpeciesLabel)
        
        characterImage.layer.cornerRadius = 16
        configureAutoLayoutConstraints()
    }
    
    private func configureAutoLayoutConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding ),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            characterImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.75),
            characterImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
            verticalStack.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: contentView.frame.width - padding * 2),
            
            characterNameLabel.topAnchor.constraint(equalTo: verticalStack.topAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            characterSpeciesLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            characterSpeciesLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            characterSpeciesLabel.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureCellContent() {
        guard let character = self.character else { return }
        characterNameLabel.text = "Name: " + character.name
        characterSpeciesLabel.text = "Species: " + character.species
        characterImage.kf.setImage(with: URL(string: character.image))
        
        switch character.status {
        case .alive:
            contentView.backgroundColor = .systemGreen
        case .dead:
            contentView.backgroundColor = .systemRed
        case .unknown:
            contentView.backgroundColor = .systemGray2
        }
    }
}
