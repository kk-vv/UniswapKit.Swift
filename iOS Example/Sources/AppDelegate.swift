import UIKit
import EvmKit
import UniswapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

//    public static func initCodeHashString(chain: Chain) throws -> String {
//        switch chain {
//        case .ethereum, .ethereumRopsten, .ethereumRinkeby, .ethereumKovan, .ethereumGoerli: return "0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f"
//        case .binanceSmartChain: return "0x00fb7f630766e6a796048ea87d01acd3068e8ff67d078148a3fa3f4a84f69bd5"
//        case .polygon: return "0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f"
//        case .avalanche: return "0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f"
//        default: throw UnsupportedChainError.noInitCodeHash
//        }
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = Manager.shared.evmKit == nil ? UINavigationController(rootViewController: WordsController()) : MainController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = controller

//    case .binanceSmartChain: return "0x00fb7f630766e6a796048ea87d01acd3068e8ff67d078148a3fa3f4a84f69bd5"
//    case .polygon: return "0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f"
//    case .avalanche: return "0x96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f"

        let token0 = Token.eth(wethAddress: try! Address(hex: "0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7"))
        let token1 = Token.erc20(address: try! Address(hex: "0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e"), decimals: 6)
        let pairAddress = Pair.address(token0: token0, token1: token1, factoryAddressString: "0x9Ad6C38BE94206cA50bb0d90783181662f0Cfa10", initCodeHashString: "0x0bbca9af0511ad1a1da383135cf3a8d2ac620e549ef9f6ae3a4c33c2fed0af91")
        print(pairAddress.eip55)

        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}
}
