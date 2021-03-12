//
//  UserDetailsPresenter.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

protocol UserDetailsPresenter {
    func viewDidLoad()
    func saveNotes(_ notes: String)
}

protocol UserDidSaveNotesDelegate: class {
    func didSaveNote()
}

class UserDetailsPresenterImpl: UserDetailsPresenter {
    private let displayUserDetailsUseCase: DisplayUserDetailsUseCase
    private let saveUserNoteUseCase: SaveUserNotesUseCase
    private let parameters: UserDetailsPresenterModel
    weak var view: UserDetailsView?
    private var userDetails: UserDetails?
    
    init(displayUserDetailsUseCase: DisplayUserDetailsUseCase,
         saveUserNoteUseCase: SaveUserNotesUseCase,
         parameters: UserDetailsPresenterModel,
         view: UserDetailsView) {
        self.displayUserDetailsUseCase = displayUserDetailsUseCase
        self.saveUserNoteUseCase = saveUserNoteUseCase
        self.parameters = parameters
        self.view = view
    }
    
    func viewDidLoad() {
        fetchDetails()
    }
    
    func saveNotes(_ notes: String) {
        if !notes.isEmpty {
            saveUserNoteUseCase.saveUserNotes(notes, for: parameters.userId) { [weak self] (saved) in
                if saved {
                    self?.view?.showSuccess("Your Notes Saved, Please Reload Data When You Go Back to List")
                } else {
                    self?.view?.showError("Couldn't Save Notes")
                }
            }
        } else {
            self.view?.showError("Please Enter Some Text!")
        }
    }
    
    private func fetchDetails() {
        displayUserDetailsUseCase.fetchDetails(with: parameters.userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.userDetails = details
                self.updateDetailsWithNotes()
                let viewModel = self.createUserDetailsViewModel(with: details)
                self.view?.updateView(with: viewModel)
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    private func updateDetailsWithNotes() {
        userDetails?.notes = parameters.notes
    }
    
}

// MARK: - ViewModel Generation
extension UserDetailsPresenterImpl {
    func createUserDetailsViewModel(with details: UserDetails) -> UserDetailsViewModel {
        return UserDetailsViewModel(name: details.name ?? "No Name",
                                    blog: details.blog ?? "No Blog",
                                    company: details.company ?? "No Company",
                                    followers: String(details.followers ?? .zero),
                                    following: String(details.following ?? .zero),
                                    notes: details.notes ?? "Select Your Notes Here")
    }
}
