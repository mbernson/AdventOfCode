//
//  File.swift
//  
//
//  Created by Mathijs on 15/11/2020.
//

import Foundation
import Intcode

print("Please enter an intcode program > ", terminator: "")
let input = readLine(strippingNewline: true)
guard let input = input, !input.isEmpty else {
  print("No input given"); exit(1)
}

let program = input
  .components(separatedBy: ",")
  .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
  .map { string -> Int in
    guard let int = Int(string) else {
      print("Encountered instruction value '\(string)' which is not a valid integer"); exit(1)
    }
    return int
  }

let machine = IntcodeMachine(program: program, inputProvider: InputProviderStdin(), outputProvider: OutputProviderStdout())

do {
  let memory = try machine.execute()
  print("Program finished. Result memory:")
  print(memory)
} catch let error {
  print("Intcode machine encountered a runtime error:")
  print(error.localizedDescription)
  exit(1)
}
