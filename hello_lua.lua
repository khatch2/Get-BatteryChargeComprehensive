-- This is a comment in lua
-- print a greeting
print("Hejsan, Lua!")
-- Define a simple function
function greet(name)
    return "Hejsan, " .. name .. "!"
end
-- Call the function and print the result
local message = greet("Lua Programmer")
print(message)
-- Siple Loop from 1 to 5
print("Looping from 1 to 5:")
for i = 1, 5 do
    print(i)
end
-- Create and use a table(Lua's main data structure)
local fruits = {"apple", "banana", "cherry"}
print("Fruits: ")
for i, fruit in ipairs(fruits) do
    print(i, fruit)
end
