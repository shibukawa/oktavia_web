Install Oktavia to Website
==========================

This search engine provides a basic web interface and a style sheet based on jQuery. This document describes how to install this interface on your websites.

.. note::

   There are many styles of HTML all over the world. This search engine is a very early version and I have tried to install int in few cases.
   If your HTML files are not matched with its assumptions, you should modify the interface script.

Basic Folder Structure
----------------------

This is a basic structure:

.. code-block:: none

   [document root]
     + index.html
     + search/
     |  + oktavia-search.js or oktavia-*-search.js
     |  + oktavia-jquery-ui.js
     |  + jquery.js
     |  + searchindex.js
     |  + oktavia-jquery-highlight.js (optional)
     + searchstyle.css
     + [other contents]

You can use both a domain root and a directory as a document root:

* Domain Root: ``http://example.com/``
* Sub domain Root: ``http://doc.example.com/``
* Directory: ``http://example.com/doc/``

You should add five files to your folder:

* ``oktavia-search.js`` or ``oktavia-*-search.js``

  One of these is a core component of this search engine. They are in ``lib`` folder of the package. ``oktavia-search.js`` is a standard version. Others includes a stemming library
  in addition to the standard version.  For example ``oktavia-german-search.js`` has a German stemmer.

* ``oktavia-jquery-ui.js``

  This is the web user interface of the search engine. It reads search words from a search form and converts search result into DOM.
  This is a standard browser side JavaScript file. You can customize it easily.

* ``jquery.js``

  ``oktavia-jquery-ui.js`` needs jQuery library to manipulate DOM. It is tested with 1.9.1.

* ``searchstyle.css``

  This is the default style of a search form and search result. You should modify it to match your website.

* ``searchindex.js``

  This is the index file of the document. It is as same as the index described in :doc:`tutorial`.

* ``oktavia-jquery-highlight.js`` (optional)

  This is an option module. This module provides a word highlight feature at landing pages.
  If your website is based on Sphinx or Tinkerer, you don't have to add this.
  Oktavia web interface adds GET parameters compatible with Sphinx.

.. note::

   * From 0.5, Search words highlight feature is added.
   * From 0.5, .js output become default. You don't have to add ``-t js`` explicitly.

Add Files
---------

Add the following lines in your HTML files that you want to show a search form:

.. code-block:: html

   <link rel="stylesheet" href="searchstyle.css" type="text/css" />
   <script src="search/jquery-1.9.1.min.js"></script>
   <script src="search/oktavia-jquery-ui.js"></script>
   <script src="search/oktavia-english-search.js"></script>

If you don't use Sphinx or Tinkerer and you want to add search word highlighting, add the following line:

.. code-block:: html

   <script src="search/oktavia-jquery-highlight.js"></script>

.. note::

   This code sample uses jQuery 1.9.1 minified version. It can also work with the older version of jQuery. jQuery 1.4 was confirmed to work with Oktavia.

Tags to your HTML and Specify an Index File Location
----------------------------------------------------

In the above instruction, there are five (plus one optional file) files needed and four of them are already specified in your HTML files. Only an index file remains.

This search engine supports asynchronously loading to support big index files (for example, the index file of a Python document become more than 6.7MB),
so should specify an index file location.

There are three ways to specify the position to create a search form.

* Using the tag it has a predefined ID.

  ``#oktavia_search_form`` is a special name. If there is a tag it has this ID, jQuery UI code convert it to a search form.

  .. code-block:: html

     <div id="oktavia_search_form"></div>

  This tag can have parameters to specify a, document root, an index file path, a flag to show logo:

  .. code-block:: html

     <div id="oktavia_search_form" data-document-root="." data-index="./scripts/searchindex.js" data-logo="enabled"></div>

* Using the jQuery plug-in.

  ``oktavia-jquery-ui.js`` provides jQuery plug-in too. You can convert any tag into a search form:

  .. code-block:: javascript

     $('#search').oktaviaSearch({
         documentRoot: '..',
         index: '../search/searchindex.js',
         logo: false
     });

* Synchronous loading.

  You can load a search index synchronously. This is the simplest way but not recommended if the index file size is very big.

  .. code-block:: html

     <script src="search/searchindex.js"></script>

Parameters are omitted, following values are used:

.. list-table::
   :header-rows: 1
   :widths: 5 5 15

   - * Parameter
     * Default Value
     * Comment
   - * ``documentRoot``
     * ``"."``
     * It is used for resolving an index file location and search result URLs.
   - * ``index``
     * ``"search/searchindex.js"``
     * An index file path. If it is not started with ``"."`` or ``"/"``, it is searched from a document root.
   - * ``logo``
     * ``true``
     * If it is not ``"false"`` or ``"disabled"`` or falsy value, the search engine name and a home page link are printed on a search result window.

Only ``documentRoot`` has two extra methods to specify the value:

* ``<base>`` tag

  If your website already uses ``<base>`` tag, you don't have to do anything. An index file is searched from this location.

* ``DOCUMENTATION_OPTIONS.URL_ROOT``

  Documentation tool `Sphinx <http://sphinx-doc.org>`_ injects the following tag into generated HTML files.
  If the ``DOCUMENTATION_OPTIONS`` global variable exists, the web interface reads an index file from ``DOCUMENTATION_OPTIONS + 'search/searchindex.js'``.

  .. code-block:: html

     <script type="text/javascript">
     var DOCUMENTATION_OPTIONS = {
         URL_ROOT:    '#',
         VERSION:     '1.0',
         COLLAPSE_MODINDEX: false,
         FILE_SUFFIX: '.html',
         HAS_SOURCE:  true
     };
     </script>

``oktavia-jquery-ui.js`` add following contents into the target tag into following tags.

.. code-block:: html

   <form id="oktavia_form">
       <input class="oktavia_search" type="search" name="search" value="" placeholder="Search" />
   </form>
   <div class="oktavia_searchresult_box">
       <div class="oktavia_close_search_box">&times;</div>
       <div class="oktavia_searchresult_summary"></div>
       <div class="oktavia_searchresult"></div>
       <div class="oktavia_searchresult_nav"></div>
       <span class="pr">Powered by <a href="http://oktavia.info">Oktavia</a></span>
   </div>

