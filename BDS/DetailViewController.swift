//
//  HomeDetailViewController.swift
//  BDS
//
//  Created by Trương Thắng on 3/2/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

// MARK: - TableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    }
}