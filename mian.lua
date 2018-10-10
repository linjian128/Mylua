print('Setting up WIFI...')
wifi.setmode(wifi.STATION)
wifi.sta.config('EmployeeHotspot', 'abc123bcd')
wifi.sta.connect()


tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print('IP: ',wifi.sta.getip())
      tmr.stop(0)
   end
end)
