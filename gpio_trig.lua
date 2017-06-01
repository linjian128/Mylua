-- use pin 0 as the input pulse width counter

gpio.mode(2,gpio.INT)
function pin1cb(level)
	local i = gpio.read(2)
	print(i)
end
gpio.trig(2, "both",pin1cb)
