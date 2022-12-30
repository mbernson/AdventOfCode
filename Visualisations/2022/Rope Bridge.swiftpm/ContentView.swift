import SwiftUI

enum GridTile {
    case blank
    case tail
    case head
    
    var description: String? {
        switch self {
        case .blank:
            return nil
        case .tail:
            return "T"
        case .head:
            return "H"
        }
    }
}

typealias Point = Day9.Point

struct ContentView: View {
    let day9 = Day9()
    let width = 10
    let height = 10
    
    @State var head: Point = .zero
    @State var tail: Point = .zero
    @State var visitedPoints: Set<Point> = []
    
    var body: some View {
        VStack {
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach((-height + 1)..<height, id: \.self) { y in 
                    GridRow {
                        ForEach((-width + 1)..<width, id: \.self) { x in 
                            Cell(tile: tile(atX: x, y: y))
                        }
                    }
                }
            }.aspectRatio(CGSize(width: width, height: height), contentMode: .fit)
            
            Grid {
                GridRow {
                    Spacer().frame(width: 44, height: 44)
                    Button(action: { up() }, label: { Image(systemName: "arrow.up") })
                }
                GridRow {
                    Button(action: { left() }, label: { Image(systemName: "arrow.left") })
                    Spacer().frame(width: 44, height: 44)
                    Button(action: { right() }, label: { Image(systemName: "arrow.right") })
                }
                GridRow {
                    Spacer().frame(width: 44, height: 44)
                    Button(action: { down() }, label: { Image(systemName: "arrow.down") })
                }
            }
            .buttonStyle(ArrowButtonStyle())
            .aspectRatio(1, contentMode: .fit)
            .padding()
            
            Button("Run commands from file") {
                start()
            }
        }.padding()
    }
    
    func tile(atX x: Int, y: Int) -> GridTile {
        let point = Point(x: x, y: y)
        if point == head {
            return .head
        } else if point == tail {
            return .tail
        } else {
            return .blank
        }
    }
    
    func start() {
        let input = try! String(contentsOf: day9.inputURL)
        let commands = day9.parseInput(input)
        var movements = commands.flatMap { (direction, quantity) in
            Array(repeating: direction, count: quantity)
        }
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in 
            if !movements.isEmpty {
                let move = movements.removeFirst()
                apply(move: move)
            } else {
                timer.invalidate()
            }
        }
    }
    
    func apply(move: Day9.Direction) {
        switch move {
        case .up:
            up()
        case .down:
            down()
        case .left:
            left()
        case .right:
            right()
        }
    }
    
    func up() {
        head.y -= 1
        tail = day9.newPosition(of: tail, toFollow: head)
    }
    func left() {
        head.x -= 1
        tail = day9.newPosition(of: tail, toFollow: head)
    }
    func right() {
        head.x += 1
        tail = day9.newPosition(of: tail, toFollow: head)
    }
    func down() {
        head.y += 1
        tail = day9.newPosition(of: tail, toFollow: head)
    }
}

struct Cell: View {
    let tile: GridTile
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .overlay {
                if let description = tile.description {
                    Text(description)
                        .bold()
                        .font(.title)
                        .padding(4)
                }
            }
            .border(Color.secondary.opacity(0.2), width: 1)
    }
}

struct ArrowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 44, height: 44)
            .padding()
            .background(.quaternary, in: Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
