//
//  PlaceAutoCompliteService.swift
//  XWeather
//
//  Created by Evgenii Mikhailov on 17.01.2026.
//

import Foundation
import MapKit
import Combine

@MainActor
final class PlaceAutocompleteService: NSObject, ObservableObject {
    
    @Published private(set) var suggestions: [MKLocalSearchCompletion] = []

    private let completer: MKLocalSearchCompleter
    private var searchTask: Task<Void, Never>?

    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()

        completer.delegate = self
        completer.resultTypes = [.address]
    }

    func updateQuery(_ text: String) {
        searchTask?.cancel()

        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 2 else {
            completer.queryFragment = ""
            suggestions = []
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 250_000_000)
            guard !Task.isCancelled else { return }
            completer.queryFragment = trimmed
        }
    }

    func clear() {
        searchTask?.cancel()
        completer.queryFragment = ""
        suggestions = []
    }
}

extension PlaceAutocompleteService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = Array(completer.results.prefix(5))
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        suggestions = []
    }
}
