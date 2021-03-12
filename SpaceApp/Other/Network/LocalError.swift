//
//  LocalError.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

struct LocalError: LocalizedError {
  let error: String
  var errorDescription: String? { return error }
}
