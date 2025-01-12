const std = @import("std");
const jetzig = @import("jetzig");

pub fn index(request: *jetzig.Request) !jetzig.View {
    const query = jetzig.database.Query(.Blog).orderBy(.{.created_at = .desc});
    const blogs = try request.repo.all(query);

    var root = try request.data(.object);
    try root.put("blogs", blogs);

    return request.render(.ok);
}

pub fn get(id: []const u8, request: *jetzig.Request) !jetzig.View {
    const query = jetzig.database.Query(.Blog).find(id);
    const blog = try request.repo.execute(query) orelse return request.fail(.not_found);

    var root = try request.data(.object);
    try root.put("blog", blog);

    return request.render(.ok);
}

pub fn new(request: *jetzig.Request) !jetzig.View {
    return request.render(.ok);
}

pub fn post(request: *jetzig.Request) !jetzig.View {
    const params = try request.params();

    const title = params.getT(.string, "title") orelse {
        return request.fail(.unprocessable_entity);
    };

    const content = params.getT(.string, "content") orelse {
        return request.fail(.unprocessable_entity);
    };

    try request.repo.insert(.Blog, .{ .title = title, .content = content });

    return request.redirect("/blogs", .moved_permanently);
}


test "index" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/blogs", .{});
    try response.expectStatus(.ok);
}

test "get" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/blogs/example-id", .{});
    try response.expectStatus(.ok);
}

test "new" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/blogs/new", .{});
    try response.expectStatus(.ok);
}

test "post" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.POST, "/blogs", .{});
    try response.expectStatus(.created);
}
