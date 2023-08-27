//
//  ContentView.swift
//  quotes
//
//  Created by Ayşıl Simge Karacan on 27.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var quote: Quote?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text(quote?.author ?? "Test Author")
                    .font(.largeTitle)
                Text(quote?.name ?? "Test")
                    .font(.subheadline)
                
            }
            .padding()
            .task {
                do {
                    let quoteResponse = try await getAQuote()
                    quote = quoteResponse.data[0]
                } catch {
                    handleQuoteError(error)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("New quote") {
                        Task {
                            do {
                                let quoteResponse = try await getAQuote()
                                quote = quoteResponse.data[0]
                            } catch {
                                handleQuoteError(error)
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Quotes")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
    
    func getAQuote() async throws -> QuoteResponse {
        
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            throw QuoteError.invalidURL
        }

        let endpoint = "\(apiUrl)?random=1"
        
        print(endpoint)

        guard let url = URL(string: endpoint) else {
            throw QuoteError.invalidURL
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw QuoteError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(QuoteResponse.self, from: data)
        } catch {
            throw QuoteError.invalidData
        }
    }
    
    func handleQuoteError(_ error: Error) {
        switch error {
            case QuoteError.invalidURL:
                print("Invalid URL")
            case QuoteError.invalidResponse:
                print("Invalid Response")
            case QuoteError.invalidData:
                print("Invalid data")
            default:
                print("Unexpected Error")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


