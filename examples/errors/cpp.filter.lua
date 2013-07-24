if NO_FILTER then return end
if CC ~= 'cl' then
    local filter = false
    lake.output_filter(cpp,function(line)
        local msg = line:match('^%S+%s+([^:]+):[^\\]')
        if msg == 'note' then
            filter = true
        elseif filter and msg then
            filter = false
        end
        if filter then return nil end
        return line:gsub('std::',''):
            gsub('basic_string%b<>','string'):
            gsub(',%s+allocator%b<>',''):
            gsub('class ',''):gsub('struct ',''):
            gsub('basic_ostream%b<>','ostream'):
            gsub('basic_streambuf%b<>','streambuf'):
            gsub('basic_ios%b<>','ios'):
            gsub('%[with[^%]]+%]',''):
            gsub('^.-: note: [^c]','')
    end)
else
    local function unstd(s) return (s:gsub('std::','')) end
    local function alone(s) return '^%s+'..s..'%s*$' end
    local errmsg, tp_parms

    local function error_ret()
        local res = errmsg
        errmsg = nil
        return res
    end

    lake.output_filter(cpp,function(line)
        -- initial compiler error line
        if line:match('^[^(]+%(%d+%)%s+:%s+%a+ ') then
            -- remember to pass through warnings!
            errmsg = unstd(line)
        elseif tp_parms then
            if line:match(alone'%[') then return end
            if line:match(alone'%]') then -- finshed!
                for k,v in pairs(tp_parms) do
                    tp_parms[k] = unstd(v)
                end
                errmsg = errmsg:gsub('_%a+',tp_parms)
                -- restore some convenient typedef names --
                errmsg = errmsg:gsub('basic_ostream<char,char_traits<char>>','ostream')
                               :gsub('basic_ostream<wchar_t,char_traits<wchar_t>>','wostream')
                tp_parms = nil
                return error_ret()
            end
            local parm,type = line:match('%s+([^=]+)=(.*)')
            tp_parms[parm]=type:gsub(',$','')
        elseif errmsg then -- next line after error
            if line:match(alone'with') then -- template parms!
                tp_parms = {}
            else
                return error_ret()
            end
        end
    end)
end

