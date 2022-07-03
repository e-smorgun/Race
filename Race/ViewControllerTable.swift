//
//  ViewControllerTable.swift
//  Race
//
//  Created by Evgeny on 12.06.22.
//

import UIKit

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var recordsToTable: [Records] = []

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Records"
        var index = 1
            
        if let recordsData: Data =  UserDefaults.standard.object(forKey:  UserDefaultsKey.kRecords.rawValue) as? Data {
            if let records: [Records] = try? PropertyListDecoder().decode(Array<Records>.self, from: recordsData) {
                for record in records {
                    recordsToTable.append(record)
                    index += 1
                    if index == 10 {
                        break }
                }
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsToTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "NameTableCell", for: indexPath)
                if let nameCell = cell as? NameTableCell {
                    nameCell.indexLabel.text = String(indexPath.row + 1)
                    nameCell.scoreLabel.text = String(recordsToTable[indexPath.row].scoreGame)
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "dd.MM.yy HH.mm.ss"
                    nameCell.dateLabel.text = dateFormater.string(from: recordsToTable[indexPath.row].dateGame)
                    return nameCell
                }
                return cell
        
    }
    
}
