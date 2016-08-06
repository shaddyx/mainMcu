local McuTools = {
    isMcu=function()
        return wifi.ap.setmac==nil
    end
}

