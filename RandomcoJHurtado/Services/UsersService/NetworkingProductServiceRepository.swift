import Foundation

protocol NetworkingUserServiceRepository {
    func loadUsers(numUsers: Int) async throws -> UsersResponse
}
