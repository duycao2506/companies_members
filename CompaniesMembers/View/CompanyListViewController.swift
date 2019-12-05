//
//  CompanyListViewController.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class CompanyListViewController: ListViewController {
    static let viewIdentifier = "CompanyListViewController"
    override func viewDidLoad() {
        if viewModel == nil {
            self.configureWith(viewmodel: CompanyListViewModel.init())
        }
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func setupViews() {
        super.setupViews()
        self.tableView.register(UINib.init(nibName: CompanyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompanyTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        guard let rawItem = self.viewModel.itemAt(section: indexPath.section, index: indexPath.row).rawValue as? Company else {return}
        let vmodel = MemberListViewModel.init(company: rawItem)
        guard let vc = storyboard?.instantiateViewController(identifier: MemberListViewController.viewIdentifier) as? MemberListViewController else {return}
        vc.configureWith(viewmodel: vmodel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
