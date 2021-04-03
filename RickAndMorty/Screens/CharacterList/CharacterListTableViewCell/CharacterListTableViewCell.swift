//
//  CharacterListTableViewCell.swift
//  RickAndMorty
//
//  Created by Celal Tok on 31.03.2021.
//

import UIKit
import Kingfisher

class CharacterListTableViewCell: UITableViewCell {

    // MARK: Properties
    
    public static let identifier = "characterListTableViewCell"
    var character: GetAllCharactersResponseModel?  {
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
        sv.distribution = .equalCentering
        sv.spacing = 4
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var characterSatatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
              contentView.frame = contentView.frame.inset(by: margins)
              contentView.layer.cornerRadius = 8
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureCellContent() {
        guard let character = self.character else { return }
        characterNameLabel.text = "Name: " + character.name
        characterSatatusLabel.text = "Status: " + character.status.rawValue
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
    
    private func configureCell() {
        addSubview(characterImage)
        addSubview(verticalStack)

        verticalStack.addArrangedSubview(characterNameLabel)
        verticalStack.addArrangedSubview(characterSatatusLabel)
        verticalStack.addArrangedSubview(characterSpeciesLabel)
        
        characterImage.layer.cornerRadius = 16
        
        configureAutoLayoutConstraints()
    }
    
    private func configureAutoLayoutConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding * 2),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            characterImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - (padding * 2) - (padding / 2)),
            characterImage.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.40),
            characterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: padding * 2),
            
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: padding * 2),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding),
            verticalStack.widthAnchor.constraint(equalToConstant: contentView.frame.width - characterImage.frame.width - padding * 2),
            
            characterNameLabel.topAnchor.constraint(equalTo: verticalStack.topAnchor, constant: padding),
            characterNameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            characterNameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -padding),
            
            characterSatatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: padding),
            characterSatatusLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            characterSatatusLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: -padding),
            
            characterSpeciesLabel.topAnchor.constraint(equalTo: characterSatatusLabel.bottomAnchor, constant: padding),
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: padding),
            characterSpeciesLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: padding),
            characterSpeciesLabel.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: -padding)
        ])
    }
}
