//
//  SuggestionsViewViewModelType.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 23.03.2021.
//

import Foundation

protocol SuggestionsViewViewModelType {
    
    func downloadFilms(condition: Conditions)
    var suggestionsDelegate: SuggestionsDelegate? { get set }
}
