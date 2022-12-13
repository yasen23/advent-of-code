str="<input string>";

for i = 14, #str do
    local substr = str:sub(i-13,i)
    local match = 0
    for a = 1, #substr do
        local astr = substr:sub(a,a)
        for b = a+1, #substr do
            local bstr = substr:sub(b,b)
            if astr == bstr then
                match = 1
            end
        end
    end

    if not match:
        io.write(i)
        break
    end
end
