import Foundation

extension Unicode.Scalar: Strideable {
    public func advanced(by n: Int) -> Unicode.Scalar {
        let value = self.value.advanced(by: n)
        guard let scalar = Unicode.Scalar(value) else {
            fatalError("Invalid Unicode.Scalar value:" + String(value, radix: 16))
        }
        return scalar
    }

    public func distance(to other: Unicode.Scalar) -> Int {
        return Int(other.value - value)
    }
}

extension Sequence where Element == Unicode.Scalar {
     var string: String { return String(self) }
     var characters: [Character] { return map(Character.init) }
}

extension String {
    init<S: Sequence>(_ sequence: S) where S.Element == Unicode.Scalar {
        self.init(UnicodeScalarView(sequence))
    }
}
