//
//  ClearBackgroundList.swift
//  Weather
//
//  Created by user242921 on 5/20/24.
//

import Foundation
import SwiftUI

struct ClearBackgroundList: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            if let tableView = view.superview?.superview as? UITableView {
                tableView.backgroundColor = .clear
                tableView.backgroundView = nil
                tableView.tableFooterView = UIView()
                tableView.separatorStyle = .none
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
