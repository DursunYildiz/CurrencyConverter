

import Foundation
enum ApiPath: String {
    // MARK: A

    case  endpoint = "latest?access_key=77ca6b8071441dd3f2006422e21e95b2"
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}


enum HTTPStatusCode: Int {
    case ok = 200
    case serverProblem = 404
    case serverDown = 503
    case serviceProblem = 500
}



enum BaseUrls : String {
    case base = "http://data.fixer.io/api/"
}
