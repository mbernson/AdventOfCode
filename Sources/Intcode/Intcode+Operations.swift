//
//  File.swift
//  
//
//  Created by Mathijs on 15/11/2020.
//

import Foundation

public extension IntcodeMachine {
  enum Operation: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case halt = 99
  }
}
