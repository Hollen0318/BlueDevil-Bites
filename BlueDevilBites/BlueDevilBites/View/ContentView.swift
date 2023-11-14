//
//  ContentView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var placesDataModel: PlacesDataModel
    @EnvironmentObject var commentsDataModel: CommentsDataModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $dataModel.searchText, isNavigationBarHidden: $isNavigationBarHidden)
                DukePersonList()
                    .frame(maxHeight: .infinity)
            }
            .overlay(
                Group {
                    if shouldDisplayDownloadView {
                        DownloadView(downloadProgress: $dataModel.downloadProgress,
                                     downloadedBytes: .constant(Int64(dataModel.receivedData.count)),
                                     totalBytes: .constant(dataModel.expectedContentLength),
                                     numberOfEntries: .constant(dataModel.database.count),
                                     isNetworkError: $dataModel.isNetworkError)
                            .padding()
                    }
                }
            )
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(isNavigationBarHidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Duke Directory")
                        .font(.system(size: 27))
                        .fontWeight(.bold)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    if !isPreview {
                        showActionSheet = true
                    }
                }) {
                    Image(systemName: "icloud.and.arrow.down")
                }
                .disabled(isPreview || shouldDisplayDownloadView)
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Choose an action"),
                                buttons: [.default(Text("Download and Update"), action: {startDownload(using: dataModel.downloadUpdate)}), .default(Text("Download and Replace"), action: {startDownload(using: dataModel.downloadReplace)}), .cancel()])
                },
                trailing: Button(action: {
                    isPresentingAddEditView = true
                }) {
                    Image(systemName: "person.badge.plus")
                }
                .fullScreenCover(isPresented: $isPresentingAddEditView) {
                    AddEditView(dukePerson: nil)
                        .environmentObject(dataModel)
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
