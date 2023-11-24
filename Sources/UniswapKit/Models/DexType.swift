import EvmKit

extension EvmKit.Chain {
    public var isBaseChain: Bool {
        return self.id == 8453
    }
}

public enum UniswapKitVersionType {
    case kit
    case kitV3
}

public enum FactoryProtocolVersion {
    case v2
    case v3
    
    var useKitV3: Bool {
        self == .v3
    }
    
    var kit: UniswapKitVersionType {
        switch self {
        case .v2:
            return .kit
        case .v3:
            return .kitV3
        }
    }

}

public enum DexType {
    
    // All 7 Chain
    case uniswap
    // Just Polygon
    case quickSwap
    // BSC ETH ARB BASE
    case pancakeSwap
    
    public func validSwapKit(by chain: Chain, version: FactoryProtocolVersion?) -> UniswapKitVersionType? {
        let version = version ?? .v3
        switch self {
        case .uniswap:
            switch chain {
            case .ethereum: // kit & kit3
                return version.kit
            case .optimism:
                return .kitV3
            case .binanceSmartChain:
                return .kitV3
            case .polygon: // kit(Quickswap v2) & kit3(uniswap v3)
                return version.kit
            case .avalanche:
                return .kitV3 // kitV3(uniswap)
            case .arbitrumOne:
                return .kitV3
            default:
                if chain.isBaseChain {
                    return .kitV3
                }
                return nil
            }
        case .quickSwap: // just polygon
            if chain == .polygon {
                return .kit // kit(Quickswap v2)
            }
            return nil
        case .pancakeSwap:
            switch chain {
            case .ethereum:
                return .kitV3
            case .binanceSmartChain: // kit & kit3
                return version.kit
            case .arbitrumOne:
                return .kitV3
            default:
                if chain.isBaseChain {
                    return .kitV3
                }
                return nil
            }
        }
    }

    public var mediumFeeAmount: KitV3.FeeAmount {
        switch self {
        case .uniswap: return .mediumUniswap
        case .pancakeSwap: return .mediumPancakeSwap
        default:
            return .mediumUniswap
        }
    }

    public func factoryAddress(chain: Chain) -> Address {
        switch self {
        case .uniswap:
            switch chain {
            case .binanceSmartChain: return try! Address(hex: "0xdB1d10011AD0Ff90774D0C6Bb92e5C5c8b4461F7")
            case .avalanche:
                return try! Address(hex: "0x740b1c1de25031C31FF4fC9A62f554A55cdC1baD")
            default:
                if chain.isBaseChain {
                    return try! Address(hex: "0x33128a8fC17869897dcE68Ed026d694621f6FDfD")
                } else {
                    return try! Address(hex: "0x1F98431c8aD98523631AE4a59f267346ea31F984")
                }
                
            }
        case .quickSwap:
            return try! Address(hex: "0x1F98431c8aD98523631AE4a59f267346ea31F984")
        case .pancakeSwap:
            return try! Address(hex: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865")
        }
    }

    public func quoterAddress(chain: Chain) -> Address {
        switch self {
        case .uniswap:
            switch chain {
            case .binanceSmartChain: return try! Address(hex: "0x78D78E420Da98ad378D7799bE8f4AF69033EB077")
            case .avalanche: return try! Address(hex: "0xbe0F5544EC67e9B3b2D979aaA43f18Fd87E6257F")
            default:
                if chain.isBaseChain {
                    return try! Address(hex: "0x3d4e44Eb1374240CE5F1B871ab261CD16335B76a")
                } else {
                    return try! Address(hex: "0x61fFE014bA17989E743c5F6cB21bF9697530B21e")
                }
            }
        case .quickSwap:
            return try! Address(hex: "0x61fFE014bA17989E743c5F6cB21bF9697530B21e")
        case .pancakeSwap:
            return try! Address(hex: "0xB048Bbc1Ee6b733FFfCFb9e9CeF7375518e25997")
        }
    }

    public func routerAddress(chain: Chain) -> Address {
        switch self {
        case .uniswap:
            switch chain {
            case .binanceSmartChain: return try! Address(hex: "0xB971eF87ede563556b2ED4b1C0b0019111Dd85d2")
            case .avalanche:
                return try! Address(hex: "0xbb00FF08d01D300023C629E8fFfFcb65A5a578cE")
            default:
                if chain.isBaseChain {
                    return try! Address(hex: "0x2626664c2603336E57B271c5C0b26F421741e481")
                } else {
                    return try! Address(hex: "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45")
                }
            }
        case .quickSwap: // link to uniswap SwapRouter02?
            return try! Address(hex: "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45")
        case .pancakeSwap:
            switch chain {
            case .arbitrumOne:
                return try! Address(hex: "0x32226588378236Fd0c7c4053999F88aC0e5cAc77")
            default:
                if chain.isBaseChain {
                    return try! Address(hex: "0x678Aa4bF4E210cf2166753e054d5b7c31cc7fa86")
                } else {
                    return try! Address(hex: "0x13f4EA83D0bd40E75C8222255bc855a974568Dd4")
                }
            }
            
        }
    }

}
