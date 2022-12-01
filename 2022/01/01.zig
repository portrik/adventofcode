const std = @import("std");

const data = @embedFile("input.txt");
const testData = @embedFile("test.txt");

test "Should Solve 01/01" {
    var iterator = std.mem.split(u8, testData, "\n");

    try std.testing.expect(solve01(&iterator) == 24000);
}

test "Should Solve 01/02" {
    var iterator = std.mem.split(u8, testData, "\n");

    try std.testing.expect(solve02(&iterator) == 45000);
}

fn solve01(iterator: *std.mem.SplitIterator(u8)) i32 {
    var max: i32 = 0;
    var current: i32 = 0;

    while (iterator.next()) |line| {
        if (line.len > 0) {
            current += std.fmt.parseInt(i32, line, 10) catch 0;
            continue;
        }

        if (current > max) {
            max = current;
        }

        current = 0;
    }

    return max;
}

fn cmpByValue(context: void, a: i64, b: i64) bool {
    return std.sort.asc(i64)(context, a, b);
}

fn solve02(iterator: *std.mem.SplitIterator(u8)) i64 {
    const allocator = std.heap.page_allocator;
    var list = std.ArrayList(i64).init(allocator);
    defer list.deinit();

    var current: i64 = 0;

    while (iterator.next()) |line| {
        if (line.len > 0) {
            current += std.fmt.parseInt(i64, line, 10) catch 0;
            continue;
        }

        list.append(current) catch {};
        current = 0;
    }

    std.sort.sort(i64, list.items, {}, cmpByValue);
    return list.items[list.items.len - 1] + list.items[list.items.len - 2] + list.items[list.items.len - 3];
}

pub fn main() !void {
    var lines = std.mem.split(u8, data, "\n");
    std.debug.print("The first solution is {?}\n", .{solve01(&lines)});

    var secondLines = std.mem.split(u8, data, "\n");
    std.debug.print("The second solution is {?}\n", .{solve02(&secondLines)});
}
