//
//  NetService.swift
//  MiniSim
//
//  Created by Gokulakrishnan Subramaniyan on 17/12/23.
//

import Foundation
import Network

class NetServiceDiscovery: NSObject {
    private var browser: NWBrowser?

    override init() {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        let serviceType = "_adb-tls-pairing._tcp."
        browser = NWBrowser(for: .bonjour(type: serviceType, domain: "local"), using: parameters)
    }

    func startBrowsing() {
        browser?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("Brwoser ready")
            case .failed(let error):
                print("Something failed \(error)")
            default:
                print("something failed")
            }
        }

        browser?.browseResultsChangedHandler = { _, changes in
            for change in changes {
                switch change {
                case .added(let result):
                    print("found something ", result)
                default:
                    print("default case")
                }
            }
        }

        browser?.start(queue: DispatchQueue.main)
    }

    func stopBrowsing() {
        browser?.cancel()
    }
}

