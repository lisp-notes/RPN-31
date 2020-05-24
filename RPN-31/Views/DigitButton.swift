import SwiftUI

struct DigitButton: View {

    @EnvironmentObject var dataRouter: DataRouter

    @State var width: CGFloat
    @State var height: CGFloat
    @State var calculatorButton: CalculatorButton
    
    @Binding var presentFunctionPage: Bool
    @Binding var presentHelpPage: Bool

    @GestureState var longPress = false
    @GestureState var longDrag = false
    
    var body: some View {
        
        let longPressGestureDelay = DragGesture(minimumDistance: 0)
            .updating($longDrag) { currentstate, gestureState, transaction in
                    gestureState = true
            }
        .onEnded { value in
            // print(value.translation) We can use value.translation to see how far away our finger moved and accordingly cancel the action (code not shown here)
           
            if self.calculatorButton.operatorString == "STORE/RECALL" {
                self.dataRouter.exitStoreRecallMode()
            } else if self.dataRouter.storeRecall {
                if (self.calculatorButton.digitString != "0" && self.calculatorButton.digitString != ".") {
                    self.dataRouter.longPressStoreRecall(self.calculatorButton.digitString)
                }
            } else {
                switch self.calculatorButton.operatorString {
                case "HELP":
                    self.presentHelpPage = true
                case "ADV":
                    self.presentFunctionPage = true
                default:
                    self.dataRouter.calculator.processOperation(self.calculatorButton.operatorString)

                }
            }
            
            self.dataRouter.digitColorArray[Int(self.calculatorButton.digitValue)] = self.dataRouter.digitButtonColor
            
        }
        
        let shortPressGesture = LongPressGesture(minimumDuration: 0)
        .onEnded { _ in
                        
            if self.dataRouter.storeRecall {
                if (self.calculatorButton.digitString != "0" && self.calculatorButton.digitString != ".") {
                    self.dataRouter.processStoreRecall(self.calculatorButton.digitString)
                }
            } else {
                self.dataRouter.calculator.processDigit(self.calculatorButton)
            }
            
        }
        
        let longTapGesture = LongPressGesture(minimumDuration: 0.25)
            .updating($longPress) { currentstate, gestureState, transaction in
                gestureState = true
        }
        .onEnded { _ in
            self.dataRouter.digitColorArray[Int(self.calculatorButton.digitValue)] = self.dataRouter.digitHighlightArray[Int(self.calculatorButton.digitValue)]
            
            if self.calculatorButton.operatorString == "STORE/RECALL" {
                self.dataRouter.startStoreRecallMode()
            }
            
        }
        
        let tapBeforeLongGestures = longTapGesture.sequenced(before:longPressGestureDelay).exclusively(before: shortPressGesture)
        
        return
            
            VStack {
                Text(self.calculatorButton.digitString)
                    .font(self.dataRouter.digitFont)
                    .foregroundColor(self.dataRouter.digitTextColor)
                    .fixedSize()
                    .padding(0)
                Text(self.calculatorButton.operatorString)
                    .font(self.dataRouter.captionFont)
                    .foregroundColor(self.dataRouter.digitTextColor)
                    .fixedSize()
                    .padding(0)
                }
                .frame(width: width, height: height)
                .background(self.longPress ? self.dataRouter.digitHighlightArray[Int(self.calculatorButton.digitValue)] : (self.longDrag ? self.dataRouter.digitBrightArray[Int(self.calculatorButton.digitValue)] : self.dataRouter.digitColorArray[Int(self.calculatorButton.digitValue)]))
                .cornerRadius(15)
                .gesture(tapBeforeLongGestures)

        }
    
        
    }








