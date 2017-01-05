//
//  IssueTrackerModel.swift
//  DroidsOnRoidsRxExample#3-networking
//
//  Created by Patrick Bellot on 1/5/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct IssueTrackerModel {
	
	let provider: RxMoyaProvider<Github>
	let repositoryName: Observable<String>
	
	func trackIssues() -> Observable<[Issue]> {
		return repositoryName
			.observeOn(MainScheduler.instance)
			.flatMapLatest { name -> Observable<Repository?> in
				print("Name: \(name)")
				return self
					.findRepository(name: name)
			}
			.flatMapLatest { repository -> Observable<[Issue]?> in
				guard let repository = repository else { return Observable.just(nil) }
				print("Repository: \(repository.fullName)")
				return self.findIssues(repository: repository)
			}
			.replaceNilWith([])
	}
	
	internal func findIssues(repository: Repository) -> Observable<[Issue]?> {
		return self.provider
			.request(Github.issues(repositoryFullName: repository.fullName))
			.debug()
			.mapArrayOptional(type: Issue.self)
	}
	
	internal func findRepository(name: String) -> Observable<Repository?> {
		return self.provider
			.request(Github.repo(fullname: name))
			.debug()
			.mapObjectOptional(type: Repository.self)
	}
}

