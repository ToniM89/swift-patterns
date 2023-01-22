// Builder protocol

public protocol LaptopBuilder {
    var size: Size { get set }
    var processor: Processor { get set }
    var graphics: Graphics { get set }

    mutating func buildParts(configuration: [String: String])
    func getLaptop() -> Laptop
}

extension LaptopBuilder {
    // default implementation in a protcol extension
    mutating public func buildParts(configuration: [String: String]) {
if let customSize = configuration["size"] {
        switch customSize {
        case "13-inch":
            self.size = Size.thirteenInch
        case "15-inch":
            self.size = Size.fifteenInch
        default:
            print("Invalid value")
        }
    }
    
    if let customProcessor = configuration["processor"] {
        switch customProcessor {
        case "i5":
            self.processor = Processor.i5
        case "i7":
            self.processor = Processor.i7
        case "i9":
            self.processor = Processor.i9
        default:
            print("Invalid value")
        }
    }
    
    if let customGraphics = configuration["graphics"] {
        switch customGraphics {
        case "intel-uhd-graphics-617":
            self.graphics = Graphics.intelUHD617
        case "intel-iris-plus-graphics-645":
            self.graphics = Graphics.intelIrisPlus645
        case "radeon-pro-vega-20":
            self.graphics = Graphics.radeonProVega20
        default:
            print("Invalid value")
        }
    }
    }

    public func getLaptop() -> Laptop {
        return Laptop(size: size, processor: processor, graphics: graphics)
    }
}

// Builder implementation

public class BudgetLaptopBuilder: LaptopBuilder {
    public var size: Size = .thirteenInch
    public var processor: Processor = .i5
    public var graphics: Graphics = .intelUHD617

    public init() {

    }
}

public class OfficeLaptopBuilder: LaptopBuilder {
    public var size: Size = .fifteenInch
    public var processor: Processor = .i7
    public var graphics: Graphics = .intelIrisPlus645

    public init() {
        
    }
}

public class HighEndLaptopBuilder: LaptopBuilder {
    public var size: Size = .fifteenInch
    public var processor: Processor = .i9
    public var graphics: Graphics = .radeonProVega20

    public init() {
        
    }
}

public class Director {
    private var builder: LaptopBuilder?

    public init(builder: LaptopBuilder?) {
        self.builder = builder
    }

    public func constructLaptop(configuration: [String: String]) {
        builder?.buildParts(configuration: configuration)
    }
}


// Using the builder

func createBuilder(configuration: [String: String]) -> LaptopBuilder? {
    guard let model = configuration["base_model"] else {
        return nil
    }
        
    var laptopBuilder: LaptopBuilder?
    switch model {
    case "budget":
        laptopBuilder = BudgetLaptopBuilder()
    case "office":
        laptopBuilder = OfficeLaptopBuilder()
    case "high-end":
        laptopBuilder = HighEndLaptopBuilder()
    default:
        print("Unexpected value.")
    }
    
    return laptopBuilder
}

var configuration: [String : String] = ["base_model": "budget"]
var laptopBuilder: LaptopBuilder? = createBuilder(configuration: configuration)
var director: Director = Director(builder: laptopBuilder)
director.constructLaptop(configuration: configuration)

if let laptop: Laptop = laptopBuilder?.getLaptop() {
    print(laptop)
}

configuration = ["base_model": "office",
                 "size": "13-inch"]
laptopBuilder = createBuilder(configuration: configuration)
director = Director(builder: laptopBuilder)
director.constructLaptop(configuration: configuration)

if let laptop = laptopBuilder?.getLaptop() {
    print(laptop)
}

configuration = ["base_model": "high-end",
                 "size": "13-inch",
                 "graphics": "intel-iris-plus-graphics-645"]
laptopBuilder = createBuilder(configuration: configuration)
director = Director(builder: laptopBuilder)
director.constructLaptop(configuration: configuration)

if let laptop = laptopBuilder?.getLaptop() {
    print(laptop)
}



// Stuff we want to build 

public class Laptop {
    public var size: Size
    public var processor: Processor
    public var graphics: Graphics

    public init(size: Size, processor: Processor, graphics: Graphics) {
        self.size = size
        self.processor = processor
        self.graphics = graphics
    }
}

extension Laptop: CustomStringConvertible {
    public var description: String {
        return "\(size) laptop\n\tProcessor \(processor)\n\tGraphics \(graphics)"
    }
}

public enum Size: String, CustomStringConvertible {
    case thirteenInch = "13-inch"
    case fifteenInch = "15-inch"

    public var description: String {
        return self.rawValue
    }
}

public enum Processor: String, CustomStringConvertible {
    case i5 = "Intel Core i5"
    case i7 = "Intel Core i7"
    case i9 = "Intel Core i9"

    public var description: String {
        return self.rawValue
    }
}

public enum Graphics: String, CustomStringConvertible {
    case intelUHD617 = "Intel UHD Graphics 617"
    case intelIrisPlus645 = "Intel Iris Plus Graphics 645"
    case radeonProVega20 = "Radeon Pro Vega 20"

    public var description: String {
        return self.rawValue
    }
}


