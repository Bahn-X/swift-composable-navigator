//
//  ExampleApp.swift
//  Example
//
//  Created by DanielDPeter on 09.11.20.
//
import ComposableRouter
import SwiftUI

@main
struct ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      Root(
        store: routerStore,
        router: router
      )
    }
  }
}
