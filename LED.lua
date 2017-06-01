led1 = 4  
led2 = 3  
gpio.mode(led1, gpio.OUTPUT)  
gpio.mode(led2, gpio.OUTPUT)  
srv=net.createServer(net.TCP)  
srv:listen(80,function(conn)  
    conn:on("receive", function(client,request)  
	--print(request);
        --local buf = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";
	local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");  
        if(method == nil)then  
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");  
        end  
        local _GET = {}  
        if (vars ~= nil)then  
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do  
                _GET[k] = v  
            end  
        end  
	
	
        buf = buf.."<center><h1>Jian HomeKit ESP8266 </h1></center>";  
        buf = buf.."<center><p style=\"font-size:25px; coloer:#6B24D8;\">GPIO0 \
			<a href=\"?pin=ON1\"> <button style=\"background:#BDEDFF; color:#aaa;font-size:20px;padding:4px 25px 5px;border-radius:5px;width: 40%; height:300px;\">ON</button></a> \
			<a href=\"?pin=OFF1\"><button style=\"background:#BDEDFF;color:#aaa;font-size:20px;padding:4px 25px 5px;border-radius:5px;width: 40%; height:300px;\">OFF</button></a>\
		   </p></center>";  
        local _on,_off = "",""  
        if(_GET.pin == "ON1")then  
		  gpio.mode(led1,gpio.OUTPUT);
		  gpio.write(led1,gpio.HIGH);
        elseif(_GET.pin == "OFF1")then  
              gpio.mode(led1,gpio.INPUT);
        elseif(_GET.pin == "ON2")then  
              gpio.write(led2, gpio.HIGH);  
        elseif(_GET.pin == "OFF2")then  
              gpio.write(led2, gpio.LOW);  
        end  
	
	client:send('HTTP/1.1 200 OK\n\n')
        client:send('<!DOCTYPE HTML>\n')
        client:send('<html>\n')
        client:send('<head><meta  content="text/html; charset=utf-8">\n')
        client:send('<title>ESP8266 Blinker Thing</title></head>\n')
     
        client:send(buf);  
 	client:send('</body></html>\n')
        --client:close();  
        --collectgarbage();  
	conn:on("sent",function(conn) conn:close() end)
    end)  
	
end)  
