//
//  RepositoryEntity.swift
//  DroidsOnRoidsRxExample#3-networking
//
//  Created by Patrick Bellot on 1/4/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import Mapper

struct Repository: Mappable {
	
	let identifier: Int
	let language: String
	let name: String
	let fullName: String
	
	init(map: Mapper) throws {
		try identifier = map.from("id")
		try language = map.from("language")
		try name = map.from("name")
		try fullName = map.from("full_name")
	}
}
