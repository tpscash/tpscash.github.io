---
title: Search in Jekyll
date: 2016-05-26 22:50:00 +0800
categories: [technologies]
tags: [jekyll,lunr]
author: Kevin
---

An introduction to use lunr.js for full-text searching in Jekyll blog.

Full-text searching is possible with Jekyll. Client side search is a good technique because it’s fast for small data sets, you don’t need to use a third party and you have complete control of how the results are displayed and what data is searched. However, this method is very slow on large data sets.

We’ll look at an implementation using lunr.js which is a full-text search engine. Lunr.js performs search client side so we need to populate the data using JSON.

We need to get our data in JSON format. Create /search_data.json with the following content:

    {
        { % for post in site.posts % }
    
        "{ { post.url | slugify } }": {
          "title": "{ { post.title | xml_escape } }",
          "url": " { { post.url | xml_escape } }",
          "author": "{ { post.author | xml_escape } }",
          "tags": "{ % for tag in post.tags % }{ { tag } }{ % unless forloop.last % }, { % endunless % }{ % endfor % }",
          "categories": "{ % for category in post.categories % }{ { category } }{ % unless forloop.last % }, { % endunless % }{ % endfor % }",
          "date": "{ { post.date | xml_escape } }"
        }
        { % unless forloop.last % },{ % endunless % }
        { % endfor %}
    }



Create search.html. This is the page visitors type their search query into.

You could have the search box in your layout so it’s on every page.

Add this content to search.html:

    <div class="container">
        <form id="site_search" action="/search" method="get" class="search">
            <input type="search" id="search_box" name="q" placeholder="Search..." autocomplete="off">
            <ul class="search-ac" id="search_results">
            <li><a href="#">Type at least 3 characters to search</a></li>
          </ul>
        </form>
    </div>
    
We’ll also create /js/search.js to hold our search Javascript.

Download the minified version from lunr.js.

Include these files and JQuery and lunr to your pages where js files are imported.

/js/search.js will perform three tasks:

* Load search data
* Search
* Display results

The content of /js/search.js:

    jQuery(function() {
      // Initalize lunr with the fields it will be searching on. I've given title
      // a boost of 10 to indicate matches on this field are more important.
      window.idx = lunr(function () {
      	this.field('id');
        this.field('title', { boost: 10 });
        this.field('date');
        this.field('author');
        this.field('categories');
        this.field('tags');
      });
    
      // Download the data from the JSON file we generated
      window.data = $.getJSON('/search_data.json');
    
      // Wait for the data to load and add it to lunr
      window.data.then(function(loaded_data){
        $.each(loaded_data, function(index, value){
          window.idx.add(
            $.extend({ "id": index }, value)
          );
        });
      });
      
      $("#search_box").unbind('keypress keyup')
      	.bind('keypress keyup', function(e) {
      		if ($(this).val().length <=0) {
      			var $search_results = $("#search_results");
      			$search_results.html('<li><a>Type at least 3 characters to search</a></li>');
      		}
      		if ($(this).val().length >= 3 || e.keyCode == 13) {
    	      var query = $("#search_box").val(); // Get the value for the text field
    	      var results = window.idx.search(query); // Get lunr to perform a search
    	      display_search_results(results);
        	}
      	});
    
      // Event when the form is submitted
      $("#site_search").submit(function(event){
          event.preventDefault();
          var query = $("#search_box").val(); // Get the value for the text field
          var results = window.idx.search(query); // Get lunr to perform a search
          display_search_results(results); // Hand the results off to be displayed
      });
    
      function display_search_results(results) {
        var $search_results = $("#search_results");
    
        // Wait for data to load
        window.data.then(function(loaded_data) {
    
          // Are there any results?
          if (results.length) {
            $search_results.empty(); // Clear any old results
    
            // Iterate over the results
            results.forEach(function(result) {
              var item = loaded_data[result.ref];
    
              // Build a snippet of HTML for this result
              var appendString = '<li><a href="' + item.url + '">' + item.title + '</a></li>';
    
              // Add it to the results
              $search_results.append(appendString);
            });
          } else {
            $search_results.html('<li><a>No results found</a></li>');
          }
        });
      }
    });


