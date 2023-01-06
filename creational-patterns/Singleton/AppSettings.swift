import Foundation

final class AppSettings {

    // to make it thread safe
    private let concurrentQueue = DispatchQueue(label: "concurrent-queue", attributes: .concurrent)
    private var settings: [Sting: Any] = [:]

    private init()

    public static let shared = AppSettings()

    // with the following implementation there can be only one set or object call at a time. -> Thread safe

    public func set(value: Any, forKey key: String) {
        // barriere flag makes it to an serial queue temporarly.
        // that means no other thread can modify the settings dictionary while a operation is executed
        concurrentQueue.async(flags: .barrier) {
            settings[key] = value       
        } 
    }

    public func object(forKey key: String) -> Any? {
        var result: Any?
        // no need to block for multiple read operations
        concurrentQueue.sync {
            result = settings[key]
        }
        return result
    }

    public func reset() {
        settings.removeAll()
    }
}


/* Solution with serial queue is possible but due to the blocking nature for the read operations not the best solution

final class AppSettings {

    // to make it thread safe
    private let serialQueue = DispatchQueue(label: "serial-queue")
    private var settings: [Sting: Any] = [:]

    private init()

    public static let shared = AppSettings()

    // with the following implementation there can be only one set or object call at a time. -> Thread safe

    public func set(value: Any, forKey key: String) {
        serialQueue.sync {
            settings[key] = value       
        }
    }

    public func object(forKey key: String) -> Any? {
        var result: Any?
        serialQueue.sync {
            result = settings[key]
        }
        return result
    }

    public func reset() {
        settings.removeAll()
    }
}

*/
