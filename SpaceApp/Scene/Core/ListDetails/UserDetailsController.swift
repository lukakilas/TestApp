//
//  UserDetailsController.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

protocol UserDetailsView: class {
    func showError(_ error: String)
}

class UserDetailsController: UIViewController {

    @IBOutlet weak var notesTextField: UITextField!
    var presenter: UserDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func saveNotesClicked(_ sender: Any) {
        
    }
    
}

extension UserDetailsController: UserDetailsView {
    func showError(_ error: String) {
        
    }
}

extension UserDetailsController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
}
