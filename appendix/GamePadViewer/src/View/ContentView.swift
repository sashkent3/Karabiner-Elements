import SwiftUI

struct ContentView: View {
  @ObservedObject private var inputMonitoringAlertData = InputMonitoringAlertData.shared

  var body: some View {
    HStack {
      InformationView()
      StickView()
      PointerView()
    }
    .alert(isPresented: inputMonitoringAlertData.showing) {
      InputMonitoringAlertView()
    }
    .frame(
      minWidth: 1100,
      maxWidth: .infinity,
      minHeight: 650,
      maxHeight: .infinity)
  }
}

struct InformationView: View {
  @ObservedObject private var eventObserver = EventObserver.shared
  @ObservedObject private var rightStick = StickManager.shared.rightStick

  var body: some View {
    VStack(alignment: .leading) {
      Group {
        Text("counter: \(eventObserver.counter)")
        Text("horizontal: \(rightStick.horizontal.lastDoubleValue)")
        Text("vertical: \(rightStick.vertical.lastDoubleValue)")
      }
      Divider()
      Group {
        Text("radian: \(rightStick.radian)")
        Text("magnitude: \(rightStick.magnitude)")
        Text(
          "strokeAccelerationTransitionValue: \(rightStick.strokeAccelerationTransitionValue)")
        Text(
          "strokeAccelerationDestinationValue: \(rightStick.strokeAccelerationDestinationValue)"
        )
      }
      Divider()
      Group {
        Text("radianDiff \(rightStick.radianDiff)")
        Text("deltaHorizontal: \(rightStick.deltaHorizontal)")
        Text("deltaVertical: \(rightStick.deltaVertical)")
        Text("deltaRadian: \(rightStick.deltaRadian)")
        Text("deltaMagnitude: \(rightStick.deltaMagnitude)")
      }
      Divider()
      Group {
        Text("pointerX \(rightStick.pointerX)")
        Text("pointerY \(rightStick.pointerY)")
      }
    }
    .frame(width: 350)
  }
}

struct StickView: View {
  @ObservedObject private var rightStick = StickManager.shared.rightStick

  private let circleSize = 100.0
  private let indicatorSize = 10.0

  var body: some View {
    ZStack(alignment: .topLeading) {
      Circle()
        .stroke(Color.gray, lineWidth: 2)
        .frame(width: circleSize, height: circleSize)

      Circle()
        .fill(Color.blue)
        .frame(width: indicatorSize, height: indicatorSize)
        .padding(
          .leading,
          circleSize / 2.0 + cos(rightStick.radian)
            * rightStick.magnitude * circleSize / 2.0 - indicatorSize / 2.0
        )
        .padding(
          .top,
          circleSize / 2.0 - sin(rightStick.radian)
            * rightStick.magnitude * circleSize / 2.0 - indicatorSize / 2.0
        )
    }
    .frame(
      width: circleSize + indicatorSize * 2,
      height: circleSize + indicatorSize * 2)
  }
}

struct PointerView: View {
  @ObservedObject private var rightStick = StickManager.shared.rightStick

  private let boxWidth = 400.0
  private let boxHeight = 225.0
  private let indicatorSize = 10.0

  var body: some View {
    ZStack(alignment: .topLeading) {
      Rectangle()
        .stroke(Color.gray, lineWidth: 2)
        .frame(width: boxWidth, height: boxHeight)

      Circle()
        .fill(Color.blue)
        .frame(width: indicatorSize, height: indicatorSize)
        .padding(.leading, rightStick.pointerX * boxWidth - indicatorSize / 2)
        .padding(.top, rightStick.pointerY * boxHeight - indicatorSize / 2)
    }
    .frame(
      width: boxWidth + indicatorSize * 2,
      height: boxHeight + indicatorSize * 2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
