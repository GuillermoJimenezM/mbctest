//
//  SurverListView.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import SwiftUI

struct SurverListView: View {
    @StateObject var surveyViewmodel = SurveyViewModel()
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        
        switch surveyViewmodel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
                ZStack {
                    
                    TabView(selection: $selectedIndex) {
                        ForEach(surveyViewmodel.surveys.indices, id:\.self) { index in
                            SurveyItemView(survey: surveyViewmodel.surveys[index].attributes)
                                .tag(index)
                                .containerRelativeFrame([.horizontal, .vertical])
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 10 ) {
                            
                            ForEach(surveyViewmodel.surveys.indices, id:\.self) { index in
                                
                                Circle()
                                    .fill(selectedIndex == index ? .white : .white.opacity(0.2))
                                    .frame(width: 8)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom, 160)
                        .padding(.horizontal)
                    }
                
            }
        }
    }
}

#Preview {
    SurverListView()
}

