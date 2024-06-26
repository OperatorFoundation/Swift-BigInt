//
//  BInt+varint.swift
//
//
//  Created by Dr. Brandon Wiley on 12/19/23.
//

import Foundation

import Datable

extension BInt
{
    public init?(varint: Data)
    {
        var data = varint
        var limbs: [UInt64] = []

        guard let firstByte = data.first else
        {
            return nil
        }
        data = data.dropFirst()

        let count = Int(firstByte)
        let extraBytes = 8 - (count % 8)

        guard count > 0 else
        {
            self.init(0)
            return
        }

        let padding = Data(repeating: 0, count: extraBytes)
        data = padding + data
        
        let words = data.count / 8

        for _ in 0..<words
        {
            guard data.count >= 8 else
            {
                return nil
            }

            let chunk = Data(data[0..<8])
            data = Data(data[8...])

            guard let limb = chunk.maybeNetworkUint64 else
            {
                return nil
            }

            limbs.append(limb)
        }

        guard data.isEmpty else
        {
            return nil
        }

        self.init(limbs: limbs)
    }

    public var varint: Data
    {
        if self.isZero()
        {
            return Data(array: [0x00])
        }

        var result: Data = Data()

        var count = self.limbs.count * 8

        var limbData: Data = Data()
        for limb in self.limbs
        {
            limbData.append(limb.maybeNetworkData!)
        }

        while true
        {
            if let first = limbData.first, first == 0
            {
                limbData = limbData.dropFirst()
                count -= 1
            }
            else
            {
                break
            }
        }

        let countByte = UInt8(count).maybeNetworkData!
        result.append(countByte)
        result.append(limbData)

        return result
    }
}
