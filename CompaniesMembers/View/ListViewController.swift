//
//  ListViewController.swift
//  CompaniesMembers
//
//  Created by Duy Cao on 12/5/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var viewModel : ListViewModelProtocol!
    
    @IBOutlet weak var btnSortType : UIButton!
    @IBOutlet weak var btnSortDirection : UIButton!
    
    weak var pullControl : UIRefreshControl!
    weak var searchController : UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setupViews()
        setupBinding()
        self.refresh()
    }

    func setupViews(){
        let pullControl = UIRefreshControl.init()
        pullControl.tintColor = .gray
        pullControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.insertSubview(pullControl, at: 0)
        self.pullControl = pullControl
        
        let searchController = UISearchController.init()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.searchController = searchController
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    func setupBinding(){
        self.viewModel.isLoading.bind {[weak self] (shouldShowIndicator) in
            if shouldShowIndicator {
                self?.pullControl.beginRefreshing()
                return
            }
            self?.pullControl.endRefreshing()
        }
        
        self.viewModel.filteredList.bind { [weak self](list) in
            self?.tableView.reloadData()
        }
        
        self.viewModel.title.bindAndFireEvent {[weak self] (str) in
            self?.navigationItem.title = str
        }
        
        self.viewModel.sortType.bind { [weak self] (type) in
            self?.btnSortType.setTitle("Sort by " + type.rawValue, for: .normal)
        }
        
        self.viewModel.sortDir.bind { [weak self] (direction) in
            self?.btnSortDirection.setTitle(direction.rawValue, for: .normal)
        }
        
        self.viewModel.searchString.bind { [weak self](str) in
            self?.viewModel.filter()
        }
        
    }
    
    // MARK: - Table view data source

    @objc func refresh() {
        self.viewModel.refresh()
    }
    
    func configureWith(viewmodel : ListViewModelProtocol){
        self.viewModel = viewmodel
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.countSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.countRowsIntSection(section: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemViewModel = self.viewModel.itemAt(section: indexPath.section, index: indexPath.row)
        guard let configurator = tableView.dequeueReusableCell(withIdentifier: itemViewModel.getViewIdentifier()) as? ListItemCellProtocol, let cell = configurator as? UITableViewCell  else {
            return .init()
        }
        configurator.configure(itemViewModel: itemViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func showSortTypeOptions(sender : Any) {
        let alert = UIAlertController.init(title: "Sort Type", message: "Pick a sort type", preferredStyle: .actionSheet)
        for option in self.viewModel.sortOptions {
            let action = UIAlertAction.init(
                title: option.rawValue,
                style: .default) { [weak self] (action) in
                    guard let self = self else {return}
                    self.viewModel.updateSortType(type: option)
            }
            alert.addAction(action)
        }
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showSortDirectionOptions(sender : Any){
        let alert = UIAlertController.init(title: "Sort Direction  ", message: "Pick a sort Direction", preferredStyle: .actionSheet)
        let directions : [SortDirection] = [ .ascending, .descending ]
        for option in directions {
            let action = UIAlertAction.init(
                title: option.rawValue,
                style: .default) { [weak self] (action) in
                    guard let self = self else {return}
                    self.viewModel.updateSortDir(dir: option)
            }
            alert.addAction(action)
        }
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
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

extension ListViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            self.viewModel.searchString.value = searchController.searchBar.text ?? ""
            return
        }
        self.viewModel.searchString.value = ""
    }
    
}
