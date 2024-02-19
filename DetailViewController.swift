//
//  DetailViewController.swift
//  Notes
//
//  Created by Venkata on 2/18/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    var selectedNote: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let one = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        let two = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteNote))
        let three = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [one, two, three]
        
        textView.text = selectedNote
    }
    
    @objc func shareTapped() {
        guard let text = textView.text else { return }
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func save() {
        let defaults = UserDefaults.standard
        var savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        if !savedArray.contains(textView.text) {
            savedArray.append(textView.text)
            defaults.set(savedArray, forKey: "SavedNotes")
        }
    }
    
    @objc func deleteNote() {
        let defaults = UserDefaults.standard
        var savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        if let i = savedArray.firstIndex(of: textView.text) {
            savedArray.remove(at: i)
            defaults.set(savedArray, forKey: "SavedNotes")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

