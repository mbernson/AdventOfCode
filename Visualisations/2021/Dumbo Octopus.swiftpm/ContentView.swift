import SwiftUI

let input: [Int] = """
7232374314
8531113786
3411787828
5482241344
5856827742
7614532764
5311321758
1255116187
5821277714
2623834788
""".map(String.init).compactMap(Int.init)

struct ContentView: View {
    @State var grid = OctopusGrid(width: 10, height: 10, grid: input)
    @State var flashedFish: Set<OctopusGrid.Point> = []
    @State var step = 1
    
    var body: some View {
        VStack {
            Grid {
                ForEach(0..<grid.height, id: \.self) { y in
                    GridRow {
                        ForEach(0..<grid.width, id: \.self) { x in
                            Cell(n: grid[x, y], isFlashing: flashedFish.contains(.init(x: x, y: y)))
                        }
                    }
                }
            }.aspectRatio(1, contentMode: .fit)
            
            Text("Step \(step)")
        }
        .padding()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                flashedFish = Set(grid.flashFish())
                step += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { flashedFish.removeAll() }
            }
        }
    }
}

struct Cell: View {
    let n: Int
    let isFlashing: Bool
    
    var body: some View {
        Rectangle()
            .fill(isFlashing ? Color.yellow : Color.clear)
            .animation(.easeInOut(duration: 0.5), value: isFlashing)
            .cornerRadius(40)
            .overlay {
                Text("\(n)")
                    .bold().font(.largeTitle)
                    .animation(.easeInOut(duration: 0.5), value: isFlashing)
                    .foregroundColor(isFlashing ? .black : nil)
            }
    }
}
