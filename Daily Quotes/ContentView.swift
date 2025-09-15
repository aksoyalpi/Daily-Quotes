//
//  ContentView.swift
//  Daily Quotes
//
//  Created by Alperen Aksoy on 10.08.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.quote?.q ?? "Loading...")
                .bold()
                .font(.title2)
                .padding(.bottom, 50)
            
            Text(viewModel.quote?.a ?? "")
                .font(.callout)
        }
        .onAppear {
            viewModel.fetchQuote()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
