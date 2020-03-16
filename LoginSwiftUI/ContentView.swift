//
//  ContentView.swift
//  LoginSwiftUI
//
//  Created by Mike Gopsill on 16/03/2020.
//  Copyright © 2020 Ford. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "person.circle")
                    TextField("Wizard Name", text: $viewModel.wizardName)
                    ActivityIndicator(isAnimating: $viewModel.isFetching, style: .medium)
                }
                HStack {
                    Image(systemName: "lock.circle")
                    TextField("Password", text: $viewModel.password)
                }
                HStack {
                    Image(systemName: "lock.circle.fill")
                    TextField("Repeat Password", text: $viewModel.passwordRepeat)
                }
                
                Button(action: {
                    
                }, label: {
                    HStack {    
                        Spacer()
                        Text("Button").padding([.top, .bottom], 6)
                        Spacer()
                    }
                    .background(Color.orange)
                    .cornerRadius(40.0)
                    .padding([.leading, .trailing], 50)
                    .padding([.top], 10)
                })
                .disabled(!viewModel.buttonIsEnabled)
            }
            .navigationBarTitle("Wizard School Signup")
            .padding()
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
