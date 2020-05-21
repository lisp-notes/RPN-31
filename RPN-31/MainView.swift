//
//  ContentView.swift
//  TimeTracker
//
//  Created by Ashok Khanna on 8/5/20.
//  Copyright © 2020 Ashok Khanna. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var dataRouter: DataRouter

        var body: some View {

            GeometryReader { geometry in
                
                ZStack {
                    
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(spacing: 0) {
                        
                        Spacer()
                        
                        ButtonGridView()
                           .frame(width: geometry.size.width, height: geometry.size.width * self.dataRouter.heightToWidth)
                        
                        Rectangle()
                            .frame(width: geometry.size.width, height: 10)
                                        
                        
                    }
                }
            }
            
}
}


/*

Dimension Calculator:

1. We will take a full width for buttons
2. We want each button to be a square
3. We want the space between each button to be consistent (both gaps between buttons on a row and between buttons on a column)
4. Grid of butons is 4 (rows) x 5 (columns) and there are 5 gaps for each row and 4 gaps for each column (we count the outer edges for the rows, but not for the columns, the latter only to reduce the number of views in ButtonGridView)
5. Let us set the gap width as 1/8th of a button
6. Therefore each screen width will have 4.625 "button widths" and each screen height will have 5.75 "button widths"
7. Therefore we set height to 5.75 / 4.625 of width
8. However, to allow us to change the gap width, let us set the gap width as a constant g, so that height = (5 + 6g)/(4 + 5g) of width
9. Of course we can also make the number of rows and columns constants, which we do in the above
10. But because Swift had some i


*/
