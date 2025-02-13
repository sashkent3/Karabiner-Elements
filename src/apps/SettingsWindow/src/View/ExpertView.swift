import SwiftUI

struct ExpertView: View {
  @ObservedObject private var settings = LibKrbn.Settings.shared

  var body: some View {
    VStack(alignment: .leading, spacing: 24.0) {
      GroupBox(label: Text("Expert mode")) {
        VStack(alignment: .leading, spacing: 12.0) {
          HStack {
            Toggle(isOn: $settings.unsafeUI) {
              Text("Enable unsafe configuration (Default: off)")
            }
            .switchToggleStyle()

            Spacer()
          }

          VStack(alignment: .leading, spacing: 0.0) {
            Text("Warning:")
            Text("Unsafe configuration disables the foolproof feature on the configuration UI.")
            Text(
              "You should not enable unsafe configuration unless you are ready to stop Karabiner-Elements from remote machine. (e.g., using Screen Sharing)"
            )
            Text("")
            Text("Unsafe configuration allows the following items:")
            Text("- Allow you to enable Apple pointing devices in the Devices tab.")
            Text("- Allow you to change left-click in Simple Modifications tab.")
          }
          .padding()
          .foregroundColor(Color.errorForeground)
          .background(Color.errorBackground)
        }
        .padding()
      }

      GroupBox(label: Text("Options")) {
        VStack(alignment: .leading, spacing: 12.0) {
          HStack {
            Toggle(isOn: $settings.filterUselessEventsFromSpecificDevices) {
              Text("Filter useless events from specific devices (Default: on)")
            }
            .switchToggleStyle()
          }

          VStack(alignment: .leading, spacing: 0.0) {
            Text("If this setting is enabled, the following events will be ignored:")
            Text("")
            Text("- Nintendo's Pro Controller (USB connected):")
            Text(
              "    - Buttons since on/off events are continuously sent at high frequency even when nothing is pressed."
            )
            Text(
              "    - Sticks since tilt events in random directions are continuously sent even when the stick is not moved at all."
            )
          }
          .padding()
          .foregroundColor(Color.infoForeground)
          .background(Color.infoBackground)

          VStack(alignment: .leading, spacing: 4.0) {
            HStack {
              Toggle(isOn: $settings.reorderSameTimestampInputEventsToPrioritizeModifiers) {
                Text("Reorder same timestamp input events to prioritize modifiers (Default: off)")
              }
              .switchToggleStyle()
            }

            Label(
              #"If you feel that modifier keys are sometimes ignored when pressed with regular keys, enable this setting"#,
              systemImage: "lightbulb"
            )
            .foregroundColor(Color(NSColor.textColor))
            .font(.caption)
          }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
      }

      GroupBox(label: Text("Delay to grab device")) {
        VStack(alignment: .leading, spacing: 12.0) {
          HStack {
            IntTextField(
              value: $settings.delayMillisecondsBeforeOpenDevice,
              range: 0...10000,
              step: 100,
              width: 50)

            Text("milliseconds (Default value is 1000)")
            Spacer()
          }

          HStack(alignment: .center, spacing: 12.0) {
            Image(systemName: "exclamationmark.triangle")

            VStack(alignment: .leading, spacing: 0.0) {
              Text(
                "Setting insufficient delay (e.g., 0) will result in a device becoming unusable after Karabiner-Elements is quit."
              )
              Text(
                "(This is a macOS problem and can be solved by unplugging the device and plugging it again.)"
              )
            }
          }
        }
        .padding()
      }

      Spacer()
    }
    .padding()
  }
}

struct ExpertView_Previews: PreviewProvider {
  static var previews: some View {
    ExpertView()
  }
}
