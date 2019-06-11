//
//  ViewController.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/09/29.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NovelListViewController: UIViewController {
    
    @IBOutlet weak var NovelListTable: UITableView!
    @IBOutlet weak var RefreshButton: UIBarButtonItem!
    
    private var viewModel: NovelListViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        NovelListTable.dataSource = self
        NovelListTable.delegate = self
        NovelListTable.register(UINib(nibName: "NovelListTableViewCell", bundle: nil), forCellReuseIdentifier: "NovelListTableViewCell")
        
        // Refresh Button
        viewModel = NovelListViewModel(
            refresh: RefreshButton.rx.tap.asSignal()
        )
    }


}

extension NovelListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // return cell height (px)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // create new cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NovelListTableViewCell", for: indexPath) as! NovelListTableViewCell
        
        // Configure the cell
        cell.NovelTitle.text = "aaa"
        cell.NovelAuthor.text = "Mr. uuu"
        cell.NovelStory.text = "aiueo"
        
        return cell
    }
    
    // cell tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // deselect
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

