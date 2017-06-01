require("send_email_smtp")

function sync_time()
	sntp.sync("pool.ntp.org", function() -- success
	  print("INFO: Time Synchronized (via sntp). Current timestamp: "..rtctime.get())
	end)
end

function print_time()
	tm = rtctime.epoch2cal(rtctime.get())
	local hour = tm["hour"]+8
	local day = tm["day"]
	if hour >= 24 then hour = hour - 24  day = day +1 end
	time = string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], day , hour , tm["min"], tm["sec"])
	print(time)
	send_email("ESP time synced: " ..time, time)
	
end

function check_time()
	print("Checking time.")
	tmr.alarm(1, 5000, tmr.ALARM_AUTO, function()
		local a,b=rtctime.get()
		if (a==0) then
			print("Syncing..")
			sync_time()
		else	
			print_time()
			tmr.stop(1)
		end
	end)
end

check_time()

-- *　　*　　*　　*　　*　　command 
-- 分　 时　 日　 月　 周　 命令 
ent = cron.schedule("0 */6 * * *", function(e)
  print("Every 6 hours")
  check_time()
end)

-- ent:unschedule()
