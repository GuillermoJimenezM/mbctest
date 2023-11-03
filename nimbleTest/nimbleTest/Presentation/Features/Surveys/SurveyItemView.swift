//
//  SurveyItemView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct SurveyItemView: View {
    
    var survey: SurveyDataDto
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var showDetail = false
    
    var body: some View {
        
        NavigationStack {
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
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Spacer()
                        
                        Button("logout") {
                            RouterViewModel.shared.logout()
                        }
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    Text(survey.title)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                        .lineLimit(2)
                    
                    HStack {
                        
                        Text(survey.description)
                            .foregroundStyle(.white)
                            .lineLimit(2)
                        
                        Spacer()
                        
                        Button(action: {
                            showDetail.toggle()
                        }, label: {
                            
                            ZStack {
                                Circle().fill(.white)
                                    .frame(width: 56, height: 56)
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.black)
                                    .font(.largeTitle)
                            }
                        })
                    }
                }
                .padding(.bottom, 50)
                .padding(.horizontal)
                .frame(maxWidth: screenWidth, alignment: .leading)
               
            }
            .fullScreenCover(isPresented: $showDetail, content: {
                SurveyDetailView(survey: survey)
            })
        }
    }
}

#Preview {
    
    @State var survey = SurveyDataDto(
        title: "Sample Survey",
        description: "This is a mock survey description.",
        thankEmailAboveThreshold: "above_threshold@example.com",
        thankEmailBelowThreshold: "below_threshold@example.com",
        isActive: true,
        coverImageURL: "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
        createdAt: "2023-11-03T12:00:00",
        activeAt: "2023-11-03T12:00:00",
        inactiveAt: "2023-11-10T12:00:00",
        surveyType: "test type"
    )
    
    return SurveyItemView(survey: survey)
}
