//
//  WebBrower.swift
//  WebBroserSelect
//
//  Created by Toru Kageyama on 2021/10/24.
//

import SwiftUI

class WebBrowser : NSObject {

	// MARK: - Static Properties
	fileprivate static let HTTP_SCHEME = "http://"
	fileprivate static let HTTPS_SCHEME = "https://"

	// MARK: - Properties
	fileprivate var _title = ""
	internal var title: String {
		return _title
	}
	fileprivate var _httpScheme = HTTP_SCHEME
	internal var httpScheme: String {
		return _httpScheme
	}
	fileprivate var _httpsScheme = HTTPS_SCHEME
	internal var httpsScheme: String {
		return _httpsScheme
	}
	fileprivate var _urlAsParameter = false
	internal var urlAsParameter: Bool {
		return _urlAsParameter
	}

	// MARK: - Constructor
	/**
	 constructor.
	 */
	init(_ title: String, http: String, https: String, asParam: Bool) {
		super.init()
		_title = title
		_httpScheme = http
		_httpsScheme = https
		_urlAsParameter = asParam
	}

	// MARK: - Process URL
	/**
	 get web browser URL.
	 - parameter url: URL string.
	 - returns: URL string for the web browser.
	 */
	func webBroeswerURL(_ url: String) -> String {
		var urlString = ""
		if url.hasPrefix(WebBrowser.HTTPS_SCHEME) {
			urlString = webBroeswerURL(url, isSecure: true)
		}
		else if url.hasPrefix(WebBrowser.HTTP_SCHEME) {
			urlString = webBroeswerURL(url, isSecure: false)
		}

		print("title: \(title), urlString: \(urlString)")
		return urlString
	}

	/**
	 get web browser URL.
	 - parameter url: URL string.
	 - parameter isSecure: true for https, false for http.
	 - returns: URL string for the web browser.
	 */
	private func webBroeswerURL(_ url: String, isSecure: Bool) -> String {
		var urlString = ""
		let myScheme = isSecure ? _httpsScheme : _httpScheme
		let prefix = isSecure ? WebBrowser.HTTPS_SCHEME : WebBrowser.HTTP_SCHEME

		if myScheme.hasPrefix(prefix) {
			urlString = url
		}
		else {
			if _urlAsParameter == false {
				let index = url.index(url.startIndex, offsetBy: prefix.count)
				urlString = myScheme + url[index...]
			}
			else {
				urlString =  myScheme + (url.addingPercentEncoding(withAllowedCharacters: .letters) ?? "")
			}
		}
		return urlString
	}

	/**
	 add web browser definition into the web browser list.
	 - parameter list: web browser list.
	 */
	class func addWebBrowsers(_ list: inout [WebBrowser]) {
		list.append(WebBrowser("Default Browser", http: "http://", https: "https://", asParam: false))
		list.append(WebBrowser("Google Chrome", http: "googlechrome://", https: "googlechromes://", asParam: false))
		list.append(WebBrowser("Firefox", http: "firefox://open-url?url=", https: "firefox://open-url?url=", asParam: true))
		list.append(WebBrowser("Firefox Focus", http: "firefox-focus://open-url?url=", https: "firefox-focus://open-url?url=", asParam: true))
		list.append(WebBrowser("Opera Touch", http: "touch-http://", https: "touch-https://", asParam: false))
		list.append(WebBrowser("Opera Mini", http: "opera-http://", https: "opera-https://", asParam: false))
		list.append(WebBrowser("Microsoft Edge", http: "microsoft-edge-http://", https: "microsoft-edge-https://", asParam: false))
		list.append(WebBrowser("Brave", http: "brave://open-url?url=", https: "brave://open-url?url=", asParam: true))
		list.append(WebBrowser("Kaspersky Browser", http: "kaspersky-safebrowser-http://", https: "kaspersky-safebrowser-https://", asParam: false))
		list.append(WebBrowser("Smooz", http: "smooz://url/", https: "smooz://url/", asParam: true))
		list.append(WebBrowser("Lunascape", http: "ilunascape://", https: "ilunascapes://", asParam: false))
		list.append(WebBrowser("Sleipnir", http: "shttp://", https: "shttps://", asParam: false))
		list.append(WebBrowser("Aloha Browser", http: "alohabrowser://open?link=", https: "alohabrowser://open?link=", asParam: true))
		list.append(WebBrowser("i-FILTER Browser", http: "ifilter://", https: "ifilters://", asParam: false))
		list.append(WebBrowser("Fennec Browser", http: "fennec://open-url?url=", https: "fennec://open-url?url=", asParam: true))
		list.append(WebBrowser("CroPlus", http: "chromtorhttp://", https: "chromtorhttps://", asParam: false))
		list.append(WebBrowser("MobileIron Web@Work", http: "mibrowser://", https: "mibrowsers://", asParam: false))
		list.append(WebBrowser("Ohajiki D Web Browser", http: "oodhttp://", https: "oodhttps://", asParam: false))
	}
}
