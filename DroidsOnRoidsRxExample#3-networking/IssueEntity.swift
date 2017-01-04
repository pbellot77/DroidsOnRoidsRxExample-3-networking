//
//  IssueEntity.swift
//  DroidsOnRoidsRxExample#3-networking
//
//  Created by Patrick Bellot on 1/4/17.
//  Copyright © 2017 Bell OS, LLC. All rights reserved.
//

import Mapper

struct Issue: Mappable {
	
	let identifier: Int
	let number: Int
	let title: String
	let body: String
	
	init(map: Mapper) throws {
		try identifier = map.from("id")
		try number = map.from("number")
		try title = map.from("title")
		try body = map.from("body")
	}
}
