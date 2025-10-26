//
//  TrailerFullScreenVC.swift
//  CinemaVault
//
//  Created by Apple on 26/10/25.
//

import UIKit
import WebKit

class TrailerFullScreenVC: UIViewController {

    var trailerKey: String
    private var webView: WKWebView!

    init(trailerKey: String) {
        self.trailerKey = trailerKey
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupWebView()
        playVideo()
        setupCloseButton()
    }

    private func setupWebView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        if #available(iOS 10.0, *) {
            config.mediaTypesRequiringUserActionForPlayback = []
        } else {
            config.requiresUserActionForMediaPlayback = false
        }

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }


    private func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: 20, y: 50, width: 40, height: 40))
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
    }

    private func playVideo() {
        let embedHTML = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { margin:0; background:black; }
          iframe { position: absolute; top:0; left:0; width:100%; height:100%; }
        </style>
        </head>
        <body>
        <iframe src="https://www.youtube.com/embed/\(trailerKey)?autoplay=1&playsinline=1" frameborder="0" allowfullscreen allow="autoplay"></iframe>
        </body>
        </html>
        """
        webView.loadHTMLString(embedHTML, baseURL: nil)
    }

    @objc func close() {
        dismiss(animated: true)
    }
}

