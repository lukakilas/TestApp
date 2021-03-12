//
//  UserDetailsController.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

protocol UserDetailsView: class {
    func showError(_ error: String)
    func showSuccess(_ text: String)
    func updateView(with model: UserDetailsViewModel)
}

class UserDetailsController: UIViewController {

    var presenter: UserDetailsPresenter!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var companyLbl: UILabel!
    @IBOutlet private weak var blogLbl: UILabel!
    @IBOutlet private weak var followersLbl: UILabel!
    @IBOutlet private weak var followingLbl: UILabel!
    @IBOutlet private weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func saveNotesClicked(_ sender: Any) {
        presenter.saveNotes(notesTextView.text)
    }
    
}

// MARK: - UserDetailsView Conformance
extension UserDetailsController: UserDetailsView {
    func showError(_ error: String) {
        showAlert(title: "Error Occured", text: error)
    }
    
    func showSuccess(_ text: String) {
        showAlert(title: "Success", text: text)
    }
    
    func updateView(with model: UserDetailsViewModel) {
        nameLbl.text = model.name
        companyLbl.text = model.company
        blogLbl.text = model.blog
        followersLbl.text = model.followers
        followingLbl.text = model.following
        notesTextView.text = model.notes
    }

}
