//
//  CharacterListBuilder.swift
//  RickAndMorty
//
//  Created by Celal Tok on 31.03.2021.
//

import UIKit

final class CharacterListBuilder {
    static func build() -> UIViewController {
        let viewModel = CharacterListViewModel(service: app.service)
        let viewController = CharacterListViewController(viewModel: viewModel)
        return viewController
    }
}
