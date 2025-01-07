@args articles: Zmpl.Array

<html>
  <head>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="/styles.css" />
    <title> {{.title}} </title
  </head>

  <body>
  <div class="mx-auto max-w-3xl mt-sm">
        <h1 class="text-3xl font-bold mb-4">Hello, I like doing things.</h1>
        <p class="text-lg mb-6">I created this website using Jetzig in order to store things I do.</p>

        <div class="mb-8">
            <a href="#" class="text-blue-500 hover:underline">Blog</a>
            <a href="#" class="text-blue-500 hover:underline ml-4">TTRPG</a>
            <a href="#" class="text-blue-500 hover:underline ml-4">Design</a>
            <a href="#" class="text-blue-500 hover:underline ml-4">Writing</a>
        </div>

        @partial root/article_blob(title: "hi test", blob: "owo")    

        <div>
            <h2 class="text-2xl font-semibold mb-2">Hidden Incompetence</h2>
            <p class="text-lg">Lorem ipsum dolor sit amet consectetur. Quis consectetur blandit felis morbi cras scelerisque...</p>
        </div>

       @for (.articles) |article| {
           @partial root/article_blob(title: article.title, blob: article.description)
       }
    </div>
  </body>
</html>
