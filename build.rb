require "xcodeproj"

# import command variables
command = ARGV[0]
device  = ARGV[1]

# build the app
system "xcodebuild -scheme hanze-ov-ios | xcpretty"

case command
	when "install"
	when "run"
end

system "ios-sim install build/Build/Products/Debug-iphonesimulator/hanze-ov-ios.app/ --devicetype iPhone-6"

system "ios-sim start --devicetype iPhone-6"
puts "iPhone6 simulator started"

system "ios-sim launch com.markuswind.hanze-ov-ios.app --devicetype iPhone-6"
puts "launched application"

def run device
	puts "run called"
end
