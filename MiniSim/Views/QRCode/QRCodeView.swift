//
//  QRCode.swift
//  MiniSim
//
//  Created by Gokulakrishnan Subramaniyan on 16/12/23.
//

import SwiftUI

struct QRCodeView: View {
    let qrCodeGenerator = QRCodeImageGenerator()
    let browser = NetServiceDiscovery()
    var body: some View {
        VStack {
            Text("Scan the below QRCode using android")
            if let qtImage = qrCodeGenerator.generateQRCode() {
                Image(nsImage: qtImage)
                    .resizable()
                    .scaledToFit()
                Button("Start") {
                    browser.startBrowsing()
                }
            } else {
                Text("Failed to generate qrcode")
            }
        }.padding(50)
    }
}

extension View {
    @discardableResult
    func openInWindow(sender: Any?) -> NSWindow {
        let controller = NSHostingController(rootView: self)
        let win = NSWindow(contentViewController: controller)
        win.title = "Connect your android device"
        win.setContentSize(CGSize(width: 400, height: 600))
        win.level = .modalPanel
        win.contentViewController = controller
        win.makeKeyAndOrderFront(sender)
        
        return win
    }
}

#Preview {
    QRCodeView()
}
