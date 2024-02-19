//
//  ViewController.swift
//  Notes
//
//  Created by Venkata on 2/18/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(createNotes))
        
        // retrive data
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        notes = savedArray
    }
    
    @objc func createNotes() {
        notes.append("")
        let indexPath = IndexPath(row: notes.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedNote = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        notes = savedArray
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedNote = notes[indexPath.row]
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

