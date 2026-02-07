import AppKit

// Simple, original icon: cycling computer silhouette + horn.
// Intentionally avoids Garmin logos/trademarks.

let size = 1024
let outPath = "EdgeAlertReceiver/Assets.xcassets/AppIcon.appiconset/appicon.png"

func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> NSColor {
    NSColor(calibratedRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

let rep = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: size,
    pixelsHigh: size,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
)!

let ctx = NSGraphicsContext(bitmapImageRep: rep)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = ctx
ctx.shouldAntialias = true

let bounds = NSRect(x: 0, y: 0, width: size, height: size)

// Background
let bgGradient = NSGradient(colors: [
    rgba(245, 248, 250),
    rgba(226, 244, 235),
    rgba(206, 236, 225)
])!
let bgCenter = NSPoint(x: bounds.midX - 120, y: bounds.midY + 180)
bgGradient.draw(
    fromCenter: bgCenter,
    radius: 40,
    toCenter: NSPoint(x: bounds.midX, y: bounds.midY),
    radius: 980,
    options: [.drawsBeforeStartingLocation, .drawsAfterEndingLocation]
)

// Soft vignette
let vignette = NSGradient(colors: [
    NSColor.black.withAlphaComponent(0.00),
    NSColor.black.withAlphaComponent(0.22)
])!
vignette.draw(
    fromCenter: NSPoint(x: bounds.midX, y: bounds.midY),
    radius: 380,
    toCenter: NSPoint(x: bounds.midX, y: bounds.midY),
    radius: 980,
    options: [.drawsAfterEndingLocation]
)

// Cycling computer body
let deviceRect = NSRect(x: 220, y: 150, width: 584, height: 760)
let devicePath = NSBezierPath(roundedRect: deviceRect, xRadius: 120, yRadius: 120)

rgba(20, 22, 28).setFill()
devicePath.fill()

rgba(255, 255, 255, 0.09).setStroke()
devicePath.lineWidth = 10
devicePath.stroke()

// Top bezel highlight
let highlightRect = NSRect(x: deviceRect.minX + 20, y: deviceRect.maxY - 210, width: deviceRect.width - 40, height: 180)
let highlightPath = NSBezierPath(roundedRect: highlightRect, xRadius: 90, yRadius: 90)
rgba(255, 255, 255, 0.06).setFill()
highlightPath.fill()

// Screen
let screenRect = NSRect(x: deviceRect.minX + 70, y: deviceRect.minY + 165, width: deviceRect.width - 140, height: deviceRect.height - 300)
let screenPath = NSBezierPath(roundedRect: screenRect, xRadius: 70, yRadius: 70)

let screenGradient = NSGradient(colors: [
    rgba(10, 34, 28),
    rgba(6, 20, 18)
])!
screenGradient.draw(in: screenPath, angle: 90)

rgba(126, 255, 203, 0.16).setStroke()
screenPath.lineWidth = 8
screenPath.stroke()

// Screen map-ish lines
func strokeLine(_ a: NSPoint, _ b: NSPoint, _ w: CGFloat, _ c: NSColor) {
    c.setStroke()
    let p = NSBezierPath()
    p.move(to: a)
    p.line(to: b)
    p.lineWidth = w
    p.lineCapStyle = .round
    p.stroke()
}

let inset: CGFloat = 44
let left = screenRect.minX + inset
let right = screenRect.maxX - inset
let top = screenRect.maxY - inset
let bottom = screenRect.minY + inset

strokeLine(NSPoint(x: left, y: top - 40), NSPoint(x: right, y: bottom + 120), 18, rgba(64, 208, 160, 0.55))
strokeLine(NSPoint(x: left + 40, y: bottom + 120), NSPoint(x: right - 60, y: top - 90), 10, rgba(255, 255, 255, 0.18))
strokeLine(NSPoint(x: left + 80, y: top - 210), NSPoint(x: right - 120, y: top - 260), 8, rgba(255, 255, 255, 0.14))

// Buttons (simple dots)
for i in 0..<3 {
    let r: CGFloat = 16
    let cx = deviceRect.midX + CGFloat(i - 1) * 56
    let cy = deviceRect.minY + 86
    let dot = NSBezierPath(ovalIn: NSRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
    rgba(255, 255, 255, 0.12).setFill()
    dot.fill()
}

// Horn overlay (bottom-right)
let hornCenter = NSPoint(x: deviceRect.maxX - 70, y: deviceRect.minY + 140)

// Horn base
let hornPath = NSBezierPath()
hornPath.move(to: NSPoint(x: hornCenter.x - 120, y: hornCenter.y - 50))
hornPath.line(to: NSPoint(x: hornCenter.x - 50, y: hornCenter.y - 90))
hornPath.line(to: NSPoint(x: hornCenter.x - 50, y: hornCenter.y + 90))
hornPath.line(to: NSPoint(x: hornCenter.x - 120, y: hornCenter.y + 50))
hornPath.close()

let conePath = NSBezierPath()
conePath.move(to: NSPoint(x: hornCenter.x - 50, y: hornCenter.y - 110))
conePath.line(to: NSPoint(x: hornCenter.x + 130, y: hornCenter.y - 70))
conePath.line(to: NSPoint(x: hornCenter.x + 130, y: hornCenter.y + 70))
conePath.line(to: NSPoint(x: hornCenter.x - 50, y: hornCenter.y + 110))
conePath.close()

let hornColor = rgba(255, 142, 65)
let hornEdge = rgba(255, 232, 210, 0.28)

hornColor.setFill()
hornPath.fill()
conePath.fill()

hornEdge.setStroke()
hornPath.lineWidth = 10
conePath.lineWidth = 10
hornPath.stroke()
conePath.stroke()

// Sound waves
for (idx, radius) in [84, 126, 168].enumerated() {
    let wave = NSBezierPath()
    let r = CGFloat(radius)
    let startAngle: CGFloat = -35
    let endAngle: CGFloat = 35
    wave.appendArc(withCenter: NSPoint(x: hornCenter.x + 150, y: hornCenter.y), radius: r, startAngle: startAngle, endAngle: endAngle)
    rgba(255, 232, 210, 0.20 + CGFloat(idx) * 0.05).setStroke()
    wave.lineWidth = 12 - CGFloat(idx) * 2
    wave.lineCapStyle = .round
    wave.stroke()
}

NSGraphicsContext.restoreGraphicsState()

let data = rep.representation(using: .png, properties: [:])!
let url = URL(fileURLWithPath: outPath)
try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
try data.write(to: url)

print("Wrote: \(outPath)")
