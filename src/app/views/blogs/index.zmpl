<div>
    @for (.blogs) |blog| {
        <a href="/blogs/{{blog.id}}">{{blog.title}}</a>
        {{zmpl.fmt.datetime(blog.get("created_at"), "%Y-%m-%d %H:%M")}}
        <br/>
    }
    <hr/>
    <a href="/blogs/new">New Blog</a>
</div>
