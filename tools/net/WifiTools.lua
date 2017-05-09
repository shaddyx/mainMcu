local WifiTools = {}
    function WifiTools.waitForIp(ok, error)
        -- wait for an IP
        local cnt = 20
        tmr.alarm(0,250,1,function()
            if wifi.sta.getip()==nil then
                cnt = cnt-1
                if cnt<=0 then
                    -- Did not get an IP in time, so quitting
                    tmr.stop(0)
                    error()
                end
            else

                -- Connected to the wifi
                tmr.stop(0)
                ok()
            end
        end)
    end

return WifiTools