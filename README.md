# T2SXRay
## XRay + Tun2socks

Add `-lresolv` and `-lbsm` to `OTHER_LDFLAGS` (a.k.a. Other Linker Flags) in project build settings.


## `PacketTunnelProvider` Implementation
I used two `DispatchQueue`s as it worked best. One `xrayQueue` and one `packetQueue`.


```
override func startTunnel(options: [String : NSObject]? = nil, completionHandler: @escaping (Error?) -> Void) {
    .
    .
    .
    setTunnelNetworkSettings(...) { [weak self, config, completionHandler] error in
        if let error {
            completionHandler(error)
            return
        }
        self?.xrayQueue.async { [weak self, config, completionHandler] () in
            self?.setupTunnel(config: config, completionHandler: completionHandler)
        }
    }
}

func setupTunnel(config: Data, completionHandler: @escaping (Error?) -> Void) {
    var error: NSError?
    Tun2socksInitGC(5)
    Tun2socksStartXRay(self, self, self, self, config, nil, &error)
    if let error {
        completionHandler(error)
        return
    }
    completionHandler(nil)
    packetQueue.async { [weak self] () in
        self?.readPacket()
    }
}

override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
    Tun2socksStopV2Ray()
    completionHandler()
    exit(EXIT_SUCCESS)
}
```

## Read and write packets
```
extension PacketTunnelProvider: Tun2socksPacketFlowProtocol {
    func writePacket(_ packet: Data?) {
        guard let packet else { return }
        packetQueue.async { [weak self, packet] () in
            self?.packetFlow.writePackets([packet], withProtocols: [NSNumber(value: AF_INET)])
        }
    }
    
    func readPacket() {
        packetFlow.readPackets { [weak self] datas, _ in
            self?.xrayQueue.async { [datas, weak self] () in
                for data in datas {
                    autoreleasepool {
                        Tun2socksInputPacket(data)
                    }
                }
                self?.packetQueue.async { [weak self] () in
                    self?.readPacket()
                }
            }
        }
    }
}
```

## Log and traffic
```
extension PacketTunnelProvider: Tun2socksVpnServiceProtocol, Tun2socksLogServiceProtocol, Tun2socksQuerySpeedProtocol {
    func updateTraffic(_ up: Int64, down: Int64) {
        // TODO: Send trraffic stats to main app
    }
    
    func writeLog(_ s: String?) throws {
        guard let s else { return }
        // TODO: Log
    }
    
    func protect(_ fd: Int) -> Bool {
        // For android compatibility, return true
        return true
    }
}
```
