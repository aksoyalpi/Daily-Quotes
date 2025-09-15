//
//  ViewModel.swift
//  Daily Quotes
//
//  Created by Alperen Aksoy on 10.08.25.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var quote: Quote?
    
    func fetchQuote() {
        guard let url = URL(string: "https://zenquotes.io/api/today") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, respone, error in
            // 1. Handle error
            if let error = error {
                self.quote = Quote(q: error.localizedDescription, a: "", h: "")
                return
            }
            
            // 2. Decode JSON
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Quote].self, from: data)
                    DispatchQueue.main.async {
                        self.quote = decodedResponse[0]
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.quote = Quote(q: "Error decoding JSON: \(error.localizedDescription)", a: "", h: "")
                    }
                }
            }
        }.resume()
    }
}
