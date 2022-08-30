//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Marcin Jędrzejak on 09/08/2022.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
//    @Published private(set) var isLoading = false -> Old
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
//    private var page = 1 -> private(set) to access for this property
    private(set) var page = 1
//    private var totalPages: Int? ->  -> private(set) to access for this property
    private(set) var totalPages: Int?
    
    private let networkingManager: NetworkingManagerImpl!
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
//        isLoading = true -> Old
        viewState = .loading
//        defer { isLoading = false } -> Old
        defer { viewState = .finished }
        
        do {
//            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self) -> Old, before Dependency Injection
            let response = try await networkingManager.request(session: .shared,
                                                               .people(page: page),
                                                               type: UsersResponse.self)
            self.totalPages = response.totalPages
            self.users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
//            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self) -> Old, before Dependency Injection
            let response = try await networkingManager.request(session: .shared,
                                                               .people(page: page),
                                                               type: UsersResponse.self)
            self.totalPages = response.totalPages
            self.users += response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
}

extension PeopleViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension PeopleViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
