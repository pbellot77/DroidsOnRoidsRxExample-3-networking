//
//  IssueListViewController.swift
//  DroidsOnRoidsRxExample#3-networking
//
//  Created by Patrick Bellot on 1/4/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxOptional
import RxCocoa
import RxSwift

class IssueListViewController: UIViewController {

	// MARK: Outlets
	@IBOutlet weak var searchbar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: iVars
	let disposeBag = DisposeBag()
	var provider: RxMoyaProvider<Github>!
	
	var latestRepositoryName: Observable<String> {
		return searchbar.rx.text
			.filterNil()
			.debounce(0.5, scheduler: MainScheduler.instance)
			.distinctUntilChanged()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupRx()
	}

	func setupRx() {
		
		provider = RxMoyaProvider<Github>()
		
		tableView
			.rx.itemSelected
			.subscribe { indexPath in
				if self.searchbar.isFirstResponder == true {
					self.view.endEditing(true)
				}
		}
		.addDisposableTo(disposeBag)
	}
	
	func url(_ route: TargetType) -> String {
		return route.baseURL.appendingPathComponent(route.path).absoluteString
	}
} // end of class
