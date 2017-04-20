local test = require 'u-test'

-- This is how you can crete your first test case 
test.addition = function ()
    test.equal(1 + 1, 2)
    test.not_equal("1 + 1", "2")
end

-- You can enable custom start_up and tear_down actions 
-- Thse actions will be invoked:
-- start_up - before test case
-- tear_down - after test case
local global_state = 0
test.start_up = function () global_state = 1 end
test.tear_down = function () globla_state = 0 end

test.dummy1 = function()
    test.equal(global_state, 1)
    test.is_number(global_state)
end

-- You can separate tests by test suites
test.string.format = function ()
    test.equal(string.format("%d + %d", 1, 1), "1 + 1")
    test.not_equal(string.format("Sparky %s", "bark"), "Fluffy bark")
end

test.string.find = function ()
    test.is_nil(string.find("u-test", "banana"))
    test.is_not_nil(string.find("u-test", "u"))
end

local global_table = {}

-- Each test suite can be customized by start_up and tear_down
test.table.start_up = function ()
    global_table = { 1, 2, "three", 4, "five" }
end
test.table.tear_down = function () 
    global_table = {}
end

test.table.concat = function ()
    test.equal(table.concat(global_table, ", "), "1, 2, three, 4, five")
end

-- you can disabe broken test case like this
test.dummy_case.skip = true
test.broken.bad_case = function ()
    test.equal(1, 2)
    there_is_no_such_function()
end

-- this code prints tests summary and invokes os.exit with 0 or 1
test.summary()