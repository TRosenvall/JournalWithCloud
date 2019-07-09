//
//  EntryDetailViewController.swift
//  JournalWithCloud
//
//  Created by Timothy Rosenvall on 7/8/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entryLandingPad: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resignWhenTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func clearText(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else {return}
        if let entry = entryLandingPad {
            EntryController.sharedInstance.updateEntry(entry: entry, title: title, body: body)
        } else {
            EntryController.sharedInstance.createEntry(title: title, body: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let entry = entryLandingPad else {return}
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
    }
}
