//
//  SwiftHigherOrderController.swift
//  ProductTemplet
//
//  Swift 常用高阶函数演示
//

import UIKit

@objc(SwiftHigherOrderController)
public final class SwiftHigherOrderController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var allItems: [[String]] = []
    private var filteredItems: [[String]] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        if title?.isEmpty != false {
            title = "Swift 高阶函数"
        }

        allItems = HigherOrderDemo.samples()
        filteredItems = allItems

        searchBar.placeholder = "搜索函数名（忽略大小写）"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.showsCancelButton = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        tableView.keyboardDismissMode = .onDrag
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(searchBar)
        view.addSubview(tableView)
        updateTitleCount()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let searchH: CGFloat = 56
        searchBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: searchH)
        tableView.frame = CGRect(x: 0, y: searchH, width: view.bounds.width, height: view.bounds.height - searchH)
    }

    private func updateTitleCount() {
        title = "Swift 高阶函数 (\(filteredItems.count)/\(allItems.count))"
    }

    private func applyFilter(_ keyword: String?) {
        let key = (keyword ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if key.isEmpty {
            filteredItems = allItems
        } else {
            filteredItems = allItems.filter { item in
                item.prefix(2).joined(separator: " ").lowercased().contains(key)
            }
        }
        updateTitleCount()
        tableView.reloadData()
    }

    // MARK: - UISearchBarDelegate

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applyFilter(searchText)
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        applyFilter(searchBar.text)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        applyFilter("")
    }

    // MARK: - UITableView

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = filteredItems[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = item[safe: 0] ?? ""
        config.secondaryText = [item[safe: 1], item[safe: 2]].compactMap { $0 }.joined(separator: "\n")
        config.textProperties.font = .systemFont(ofSize: 16, weight: .semibold)
        config.textProperties.color = .label
        config.secondaryTextProperties.font = .systemFont(ofSize: 12)
        config.secondaryTextProperties.color = .secondaryLabel
        config.secondaryTextProperties.numberOfLines = 0
        cell.contentConfiguration = config
        cell.selectionStyle = .none
        return cell
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
