//
//  HigherOrderFunctions.swift
//  ProductTemplet
//
//  Swift 常用高阶函数扩展（map / filter / reduce 等补充）
//

import Foundation

// MARK: - Sequence

public extension Sequence {

    /// 带下标的 map：`(index, element) -> T`
    func mapIndexed<T>(_ transform: (Int, Element) throws -> T) rethrows -> [T] {
        var index = 0
        var result: [T] = []
        for element in self {
            result.append(try transform(index, element))
            index += 1
        }
        return result
    }

    /// 带下标的 forEach
    func forEachIndexed(_ body: (Int, Element) throws -> Void) rethrows {
        var index = 0
        for element in self {
            try body(index, element)
            index += 1
        }
    }

    /// 带下标的 filter
    func filterIndexed(_ isIncluded: (Int, Element) throws -> Bool) rethrows -> [Element] {
        var index = 0
        var result: [Element] = []
        for element in self {
            if try isIncluded(index, element) {
                result.append(element)
            }
            index += 1
        }
        return result
    }

    /// 是否存在满足条件的元素（`contains(where:)` 别名）
    func any(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        try contains(where: predicate)
    }

    /// 是否全部满足（`allSatisfy` 别名）
    func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        try allSatisfy(predicate)
    }

    /// 是否无一满足
    func none(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        try !contains(where: predicate)
    }

    /// 按 key 分组
    func groupBy<Key: Hashable>(_ keyForValue: (Element) throws -> Key) rethrows -> [Key: [Element]] {
        try reduce(into: [:]) { result, element in
            let key = try keyForValue(element)
            result[key, default: []].append(element)
        }
    }

    /// 统计满足条件的数量
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        try reduce(0) { partial, element in
            try predicate(element) ? partial + 1 : partial
        }
    }
}

public extension Sequence where Element: Hashable {

    /// 去重（保序）
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

public extension Sequence where Element: Equatable {

    /// 按自定义相等去重（保序）
    func uniqued(by areEquivalent: (Element, Element) throws -> Bool) rethrows -> [Element] {
        var result: [Element] = []
        for element in self {
            let exists = try result.contains { try areEquivalent($0, element) }
            if !exists {
                result.append(element)
            }
        }
        return result
    }
}

// MARK: - Collection

public extension Collection {

    /// 安全下标
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// 分块：`[1,2,3,4,5].chunked(into: 2)` -> `[[1,2],[3,4],[5]]`
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        var result: [[Element]] = []
        var start = startIndex
        while start < endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            result.append(Array(self[start..<end]))
            start = end
        }
        return result
    }

    /// 与另一集合按最短长度 zip 后 map
    func zipMap<Other: Collection, T>(_ other: Other, _ transform: (Element, Other.Element) throws -> T) rethrows -> [T] {
        try zip(self, other).map(transform)
    }
}

public extension MutableCollection {

    /// 原地 map（长度不变时）
    mutating func mapInPlace(_ transform: (Element) throws -> Element) rethrows {
        var i = startIndex
        while i < endIndex {
            self[i] = try transform(self[i])
            formIndex(after: &i)
        }
    }
}

// MARK: - Array

public extension Array {

    /// reduce 简写：无初始值时用首元素（空数组返回 nil）
    func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element? {
        guard let first = first else { return nil }
        return try dropFirst().reduce(first, nextPartialResult)
    }

    /// 在 index 处插入并由闭包生成元素
    mutating func insert(at index: Int, build: () throws -> Element) rethrows {
        let i = Swift.max(0, Swift.min(index, count))
        try insert(build(), at: i)
    }
}

// MARK: - Optional

public extension Optional {

    /// 有值且满足条件则保留，否则 nil（类似 filter）
    func filter(_ isIncluded: (Wrapped) throws -> Bool) rethrows -> Wrapped? {
        switch self {
        case .some(let value):
            return try isIncluded(value) ? value : nil
        case .none:
            return nil
        }
    }

    /// 副作用：有值时执行
    @discardableResult
    func ifSome(_ body: (Wrapped) throws -> Void) rethrows -> Optional {
        if let value = self {
            try body(value)
        }
        return self
    }

    /// 副作用：为 nil 时执行
    @discardableResult
    func ifNone(_ body: () throws -> Void) rethrows -> Optional {
        if self == nil {
            try body()
        }
        return self
    }

    /// 为 nil 时用闭包提供默认值
    func or(_ defaultValue: () throws -> Wrapped) rethrows -> Wrapped {
        if let value = self { return value }
        return try defaultValue()
    }
}

// MARK: - Dictionary

public extension Dictionary {

    /// 转换 key，冲突时后者覆盖
    func mapKeys<K: Hashable>(_ transform: (Key) throws -> K) rethrows -> [K: Value] {
        var result: [K: Value] = [:]
        for (key, value) in self {
            result[try transform(key)] = value
        }
        return result
    }

    /// 同时转换 key / value
    func mapPairs<K: Hashable, V>(_ transform: (Key, Value) throws -> (K, V)) rethrows -> [K: V] {
        var result: [K: V] = [:]
        for (key, value) in self {
            let pair = try transform(key, value)
            result[pair.0] = pair.1
        }
        return result
    }

    /// 按条件过滤键值对
    func filterPairs(_ isIncluded: (Key, Value) throws -> Bool) rethrows -> [Key: Value] {
        var result: [Key: Value] = [:]
        for (key, value) in self {
            if try isIncluded(key, value) {
                result[key] = value
            }
        }
        return result
    }
}

// MARK: - Demo samples（供演示页调用）

@objcMembers
public final class HigherOrderDemo: NSObject {

    /// 返回演示条目：`[title, detail, result]`
    public static func samples() -> [[String]] {
        let nums = [1, 2, 3, 4, 5, 6]
        let words = ["Swift", "map", "Filter", "reduce", "swift"]

        let mapped = nums.map { $0 * 2 }
        let filtered = nums.filter { $0 % 2 == 0 }
        let reduced = nums.reduce(0, +)
        let compact = ["a", nil, "b", nil, "c"].compactMap { $0 }
        let flat = [[1, 2], [3], [4, 5]].flatMap { $0 }
        let sorted = words.sorted { $0.lowercased() < $1.lowercased() }
        let grouped = words.groupBy { $0.lowercased().first.map(String.init) ?? "#" }
        let chunked = nums.chunked(into: 2)
        let uniqued = words.map { $0.lowercased() }.uniqued()
        let indexed = nums.mapIndexed { i, v in "\(i):\(v)" }
        let anyOdd = nums.any { $0 % 2 != 0 }
        let allPositive = nums.all { $0 > 0 }
        let opt = Optional("hello").filter { $0.count > 3 }.map { $0.uppercased() } ?? "nil"
        let dict = ["a": 1, "b": 2, "c": 3].mapKeys { $0.uppercased() }

        return [
            ["map", "映射变换", "\(nums) → \(mapped)"],
            ["filter", "条件过滤", "\(nums) → \(filtered)"],
            ["reduce", "归约累计", "\(nums) → \(reduced)"],
            ["compactMap", "映射并去掉 nil", "→ \(compact)"],
            ["flatMap", "展平二维", "→ \(flat)"],
            ["sorted", "排序（忽略大小写）", "\(words) → \(sorted)"],
            ["mapIndexed", "带下标 map", "→ \(indexed)"],
            ["groupBy", "按首字母分组", "→ \(grouped)"],
            ["chunked", "分块", "→ \(chunked)"],
            ["uniqued", "去重保序", "→ \(uniqued)"],
            ["any / all", "存在 / 全部满足", "anyOdd=\(anyOdd), allPositive=\(allPositive)"],
            ["Optional.filter/map", "可选链高阶", "→ \(opt)"],
            ["Dictionary.mapKeys", "字典 key 变换", "→ \(dict)"],
            ["forEach", "遍历副作用", "nums.forEach { print($0) }"],
            ["first(where:)", "首个匹配", "\(String(describing: nums.first { $0 > 3 }))"],
            ["contains(where:)", "是否存在", "\(nums.contains { $0 == 4 })"],
        ]
    }
}
