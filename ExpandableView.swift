//
//  ExpandableView.swift
//  ToDoList
//
//  Created by Ife Adeyefa on 12/8/23.
//

import SwiftUI

struct ExpandableView: View {
    @Namespace private var namespace
    @State private var showExpanded = false
    
    var thumbnail: ThumbnailView
    var expanded: ExpandedView
    
    @StateObject var tasks = Tasks()
    @StateObject var prioritized = PrioritizedTasks()
    
    var body: some View {
        ZStack {
            if !showExpanded {
                thumbnailView()
            } else {
                expandedView()
            }
        }
        .onTapGesture {
            if !showExpanded {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    showExpanded.toggle()
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func thumbnailView() -> some View {
        ZStack {
            thumbnail
                .matchedGeometryEffect(id: "view", in: namespace)
        }
        .mask {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
    
    @ViewBuilder
    private func expandedView() -> some View {
        ZStack {
            expanded
                .matchedGeometryEffect(id: "view", in: namespace)
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
            
            
            
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    showExpanded.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }
            .padding()
            .background(.secondary)
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
}

