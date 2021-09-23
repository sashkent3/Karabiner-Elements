import SwiftUI

struct MainView: View {
    @ObservedObject var eventQueue = EventQueue.shared
    @State private var textInput: String = "Press the key you want to investigate."

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            GroupBox(label: Text("Text input test field")) {
                VStack {
                    TextEditor(
                        text: $textInput
                    )
                    .frame(height: 60)
                    .disableAutocorrection(true)
                }
                .padding(6.0)
            }

            GroupBox(label: Text("Keyboard & pointing events")) {
                VStack(alignment: .leading, spacing: 6.0) {
                    HStack(alignment: .center, spacing: 12.0) {
                        Button(action: {
                            eventQueue.copyToPasteboard()
                        }) {
                            Label("Copy to pasteboard", systemImage: "arrow.right.doc.on.clipboard")
                        }

                        Button(action: {
                            eventQueue.clear()
                        }) {
                            Label("Clear", systemImage: "clear")
                        }

                        Spacer()

                        if eventQueue.simpleModificationJsonString.count > 0 {
                            Button(action: {
                                eventQueue.addSimpleModification()
                            }) {
                                Label(eventQueue.addSimpleModificationButtonText, systemImage: "plus.circle")
                            }
                        }
                    }

                    ScrollViewReader { proxy in
                        // swiftformat:disable:next unusedArguments
                        List($eventQueue.queue) { $entry in
                            HStack(alignment: .center, spacing: 0) {
                                Text(entry.eventType)
                                    .font(.title)
                                    .frame(width: 70, alignment: .leading)

                                VStack(alignment: .leading, spacing: 0) {
                                    Text(entry.name)
                                    Text(entry.misc)
                                        .font(.caption)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 0) {
                                    if entry.usagePage.count > 0 {
                                        HStack(alignment: .bottom, spacing: 0) {
                                            Text("usage page: ")
                                                .font(.caption)
                                            Text(entry.usagePage)
                                        }
                                    }
                                    if entry.usage.count > 0 {
                                        HStack(alignment: .bottom, spacing: 0) {
                                            Text("usage: ")
                                                .font(.caption)
                                            Text(entry.usage)
                                        }
                                    }
                                }
                                .frame(alignment: .leading)
                            }

                            Divider().id("divider \(entry.id)")
                        }
                        .onChange(of: eventQueue.queue) { newQueue in
                            if let last = newQueue.last {
                                proxy.scrollTo("divider \(last.id)", anchor: .bottom)
                            }
                        }
                    }
                }
                .padding(6.0)
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
