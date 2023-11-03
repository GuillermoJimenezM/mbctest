//
//  SurveyDetailView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct SurveyDetailView: View {
    
    var survey: SurveyDataDto
    let screenWidth = UIScreen.main.bounds.width
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            
            if let url = URL(string: "\(survey.coverImageURL)l") {
                
                AsyncImage(url: url) { phase in
                    
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: screenWidth, maxHeight: .infinity)
                            .clipped()
                            .edgesIgnoringSafeArea(.all)
                        
                    case .failure(_):
                        Image(systemName: "exclamationmark.icloud")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        Image(systemName: "exclamationmark.icloud")
                    }
                }
            }
            
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .onTapGesture {
                        dismiss()
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                Text(survey.title)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Text(survey.description)
                    .font(.body)
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    ButtonView(label: "Start Survey") {
                        
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
