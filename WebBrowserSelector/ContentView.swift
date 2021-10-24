//
//  ContentView.swift
//  WebBrowserSelector
//
//  Created by Toru Kageyama on 2021/10/24.
//

import SwiftUI

struct ContentView: View {

	// MARK: - Static Properties
	internal static let QIITA_URL = "https://qiita.com/"

	// MARK: - Properties
	@State private var urlInput = ""
	@State private var showingOptions = false
	@State private var browser: String
	@State private var browserIndex = 0
	fileprivate var _webBrowsers = [WebBrowser]()
	fileprivate var _safariAsDefault = true

	init() {
		_safariAsDefault = WebBrowser.addWebBrowsers(&_webBrowsers)
		browser = _webBrowsers[0].title
		print("init: done! browser: \(browser)")
	}

	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				Spacer()
				Button(browser) {
					showingOptions = true
				}.confirmationDialog("Select Browser",
									 isPresented: $showingOptions,
									 titleVisibility: .visible) {
					ForEach(_webBrowsers.indices) { index in
						let webBrowser = _webBrowsers[index]
						let urlString = webBrowser.webBroeswerURL(ContentView.QIITA_URL)
						if let url = URL(string: urlString) {
							let enable = UIApplication.shared.canOpenURL(url)
							if index == 0 || enable {
								Button(webBrowser.title) {
									browser = webBrowser.title
									browserIndex = index
								}
							}
						}
					}
				}
				Spacer()
			}
			HStack(alignment: .center) {
				TextField("Input URL", text: $urlInput)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.keyboardType(.URL)	// URL input keyboard.
					.disableAutocorrection(true)	// no auto correction.
					.autocapitalization(.none)	// no capitalizing.
					.padding()
				Button("Go") {
					let webBrowser = _webBrowsers[browserIndex]
					let urlString = webBrowser.webBroeswerURL(urlInput)
					if urlString.count > 0 {
						if let url = URL(string: urlString) {
							UIApplication.shared.open(url, options: [:], completionHandler: nil)
						}
					}
				}
			}
		}.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
