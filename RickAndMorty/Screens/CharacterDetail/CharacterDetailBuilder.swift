//
//  CharacterDetailBuilder.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import UIKit

final class CharacterDetailBuilder {
    static func build(with viewModel: CharacterDetailViewModelType) -> UIViewController {
        let vc = CharacterDetailViewController(viewModel: viewModel)
        return vc
    }
}
