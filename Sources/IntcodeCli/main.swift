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

do {
  let machine = try IntcodeMachine(
    program: input,
    inputProvider: InputProviderStdin(),
    outputProvider: OutputProviderStdout()
  )
  let memory = try machine.execute()
  print("Program finished. Result memory:")
  print(memory)
} catch let error {
  print("Intcode machine encountered a runtime error:")
  print(error.localizedDescription)
  exit(1)
}
