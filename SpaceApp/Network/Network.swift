//
//  Network.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation
import Network

enum NetworkStatus {
    case connected
    case disconnected
}

extension NetworkStatus {
    var networkStatusChangeAlertText: String {
        switch self {
        case .connected:
            return "Network Connection Restored"
        case .disconnected:
            return "Network Connection Lost"
        }
    }
}

class NetworkWathcer {
    static let shared = NetworkWathcer()
    
    private let queue = DispatchQueue(label: "NetworkMonitoring")
    private let monitor: NWPathMonitor
    public private (set) var connectionStatus: NetworkStatus = .connected {
        willSet {
            if connectionStatus != newValue {
                DispatchQueue.main.async {
                    let userInfo: [String: NetworkStatus] = ["NetworkStatus": self.connectionStatus]
                    NotificationCenter.default.post(name: .networkStatusUpdated, object: nil, userInfo: userInfo)
                }
            }
        }
    }
    
    private init () {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.connectionStatus = path.status == .satisfied ? .connected : .disconnected
            
        }
    }
}

extension NSNotification.Name {
    static let networkStatusUpdated = NSNotification.Name("networkStatusUpdated")
}
