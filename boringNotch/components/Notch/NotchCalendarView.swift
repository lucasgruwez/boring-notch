//
//  NotchHomeView.swift
//  boringNotch
//
//  Created by Hugo Persson on 2024-08-18.
//  Modified by Harsh Vardhan Goswami & Richard Kunkli & Mustafa Ramadan
//

import Combine
import Defaults
import SwiftUI

// MARK: - Main View

struct NotchCalendarView: View {
    @EnvironmentObject var vm: BoringViewModel
    @ObservedObject var webcamManager = WebcamManager.shared
    @ObservedObject var batteryModel = BatteryStatusViewModel.shared
    @ObservedObject var coordinator = BoringViewCoordinator.shared

    var body: some View {
        Group {
            if !coordinator.firstLaunch {
                mainContent
            }
        }
        .transition(.opacity.combined(with: .blurReplace))
    }
    
    private var mainContent: some View {
        HStack(alignment: .top) {

            CalendarView()
                .padding(.horizontal, 32)
                .onHover { isHovering in
                    vm.isHoveringCalendar = isHovering
                }
                .environmentObject(vm)

        }
        .transition(
            .opacity.animation(.smooth.speed(0.9))
                .combined(with: .blurReplace.animation(.smooth.speed(0.9)))
                .combined(with: .move(edge: .top))
        )
        .blur(radius: vm.notchState == .closed ? 30 : 0)
    }
}
