local ls = require('luasnip')
local parse = ls.parser.parse_snippet

local snips = {
    parse({ trig = 'doctype', dscr = 'HTML - Defines the document type' },
        [[
        <!DOCTYPE>
        $1
        ]]),
    parse({ trig = 'a', dscr = 'HTML - Defines a hyperlink' },
        [[<a href="$1">$2</a>$3]]),
    parse({ trig = 'abbr', dscr = 'HTML - Defines an abbreviation' },
        [[<abbr title="$1">$2</abbr>$3]]),
    parse({ trig = 'address', dscr = 'HTML - Defines an address element' },
        [[
        <address>
        $1
        </address>
        ]]),
    parse({ trig = 'area', dscr = 'HTML - Defines an area inside an image map' },
        [[<area shape="$1" coords="$2" href="$3" alt="$4">$5]]),
    parse({ trig = 'article', dscr = 'HTML - Defines an article' },
        [[
        <article>
            $1
        </article>
        ]]),
    parse({ trig = 'aside', dscr = 'HTML - Defines content aside from the page content' },
        [[
        <aside>
            $1
        </aside>$2
        ]]),
    parse({ trig = 'audio', dscr = 'HTML - Defines sounds content' },
        [[
        <audio controls>
            $1
        </audio>
        ]]),
    parse({ trig = 'b', dscr = 'HTML - Defines bold text' },
        [[<b>$1</b>$2]]),
    parse({ trig = 'base', dscr = 'HTML - Defines a base URL for all the links in a page' },
        [[<base href="$1" target="$2">$3]]),
    parse({ trig = 'bdi', dscr = 'HTML - Used to isolate text that is of unknown directionality' },
        [[<bdi>$1</bdi>$2]]),
    parse({ trig = 'bdo', dscr = 'HTML - Defines the direction of text display' },
        [[
        <bdo dir="$1">
        $2
        </bdo>
        ]]),
    parse({ trig = 'big', dscr = 'HTML - Used to make text bigger' },
        [[<big>$1</big>$2]]),
    parse({ trig = 'blockquote', dscr = 'HTML - Defines a long quotation' },
        [[
        <blockquote cite="$2">
            $1
        </blockquote>
        ]]),
    parse({ trig = 'body', dscr = 'HTML - Defines the body element' },
        [[
        <body>
            $1
        </body>
        ]]),
    parse({ trig = 'br', dscr = 'HTML - Inserts a single line break' },
        [[<br>]]),
    parse({ trig = 'button', dscr = 'HTML - Defines a push button' },
        [[<button type="$1">$2</button>$3]]),
    parse({ trig = 'canvas', dscr = 'HTML - Defines graphics' },
        [[<canvas id="$1">$2</canvas>$3]]),
    parse({ trig = 'caption', dscr = 'HTML - Defines a table caption' },
        [[<caption>$1</caption>$2]]),
    parse({ trig = 'cite', dscr = 'HTML - Defines a citation' },
        [[<cite>$1</cite>$2]]),
    parse({ trig = 'code', dscr = 'HTML - Defines computer code text' },
        [[<code>$1</code>$2]]),
    parse({ trig = 'col', dscr = 'HTML - Defines attributes for table columns' },
        [[<col>$2]]),
    parse({ trig = 'colgroup', dscr = 'HTML - Defines group of table columns' },
        [[
        <colgroup>
            $1
        </colgroup>
        ]]),
    parse({ trig = 'command', dscr = 'HTML - Defines a command button [not supported]' },
        [[<command>$1</command>$2]]),
    parse({ trig = 'datalist', dscr = 'HTML - Defines a dropdown list' },
        [[
        <datalist>
            $1
        </datalist>
        ]]),
    parse({ trig = 'dd', dscr = 'HTML - Defines a definition description' },
        [[<dd>$1</dd>$2]]),
    parse({ trig = 'del', dscr = 'HTML - Defines deleted text' },
        [[<del>$1</del>$2]]),
    parse({ trig = 'details', dscr = 'HTML - Defines details of an element' },
        [[
        <details>
            $1
        </details>
        ]]),
    parse({ trig = 'dialog', dscr = 'HTML - Defines a dialog (conversation)' },
        [[<dialog>$1</dialog>$2]]),
    parse({ trig = 'dfn', dscr = 'HTML - Defines a definition term' },
        [[<dfn>$1</dfn>$2]]),
    parse({ trig = 'div', dscr = 'HTML - Defines a section in a document' },
        [[
        <div class="$1">
            $2
        </div>
        ]]),
    parse({ trig = 'divid', dscr = 'HTML - Defines a section in a document' },
        [[
        <div id="$1">
            $2
        </div>
        ]]),
    parse({ trig = 'dl', dscr = 'HTML - Defines a definition list' },
        [[
        <dl>
            $1
        </dl>
        ]]),
    parse({ trig = 'dt', dscr = 'HTML - Defines a definition term' },
        [[<dt>$1</dt>$2]]),
    parse({ trig = 'em', dscr = 'HTML - Defines emphasized text' },
        [[<em>$1</em>$2]]),
    parse({ trig = 'embed', dscr = 'HTML - Defines external interactive content ot plugin' },
        [[<embed src="$1">$2]]),
    parse({ trig = 'fieldset', dscr = 'HTML - Defines a fieldset' },
        [[
        <fieldset>
            $1
        </fieldset>
        ]]),
    parse({ trig = 'figcaption', dscr = 'HTML - Defines a caption for a figure' },
        [[<figcaption>$1</figcaption>$2]]),
    parse({ trig = 'figure', dscr = 'HTML - Defines a group of media content, and their caption' },
        [[
        <figure>
            $1
        </figure>
        ]]),
    parse({ trig = 'footer', dscr = 'HTML - Defines a footer for a section or page' },
        [[
        <footer>
            $1
        </footer>
        ]]),
    parse({ trig = 'form', dscr = 'HTML - Defines a form' },
        [[
        <form>
            $1
        </form>
        ]]),
    parse({ trig = 'h1', dscr = 'HTML - Defines header 1' },
        [[<h1>$1</h1>$2]]),
    parse({ trig = 'h2', dscr = 'HTML - Defines header 2' },
        [[<h2>$1</h2>$2]]),
    parse({ trig = 'h3', dscr = 'HTML - Defines header 3' },
        [[<h3>$1</h3>$2]]),
    parse({ trig = 'h4', dscr = 'HTML - Defines header 4' },
        [[<h4>$1</h4>$2]]),
    parse({ trig = 'h5', dscr = 'HTML - Defines header 5' },
        [[<h5>$1</h5>$2]]),
    parse({ trig = 'h6', dscr = 'HTML - Defines header 6' },
        [[<h6>$1</h6>$2]]),
    parse({ trig = 'head', dscr = 'HTML - Defines information about the document' },
        [[
        <head>
            $1
        </head>
        ]]),
    parse({ trig = 'header', dscr = 'HTML - Defines a header for a section of page' },
        [[
        <header>
            $1
        </header>
        ]]),
    parse({ trig = 'hgroup', dscr = 'HTML - Defines information about a section in a document' },
        [[
        <hgroup>
            $1
        </hgroup>
        ]]),
    parse({ trig = 'hr', dscr = 'HTML - Defines a horizontal rule' },
        [[<hr>]]),
    parse({ trig = 'html', dscr = 'HTML - Defines an html document' },
        [[
        <html>
            $1
        </html>
        ]]),
    parse({ trig = 'html5', dscr = 'HTML - Defines a template for a html5 document' },
        [[
        <!DOCTYPE html>
        <html lang="$1en">
            <head>
                <title>$2</title>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <link href="$3css/style.css" rel="stylesheet">
            </head>
            <body>
            $4
            </body>
        </html>
        ]]),
    parse({ trig = 'i', dscr = 'HTML - Defines italic text' },
        [[<i>$1</i>$2]]),
    parse({ trig = 'iframe', dscr = 'HTML - Defines an inline sub window' },
        [[<iframe src="$1">$2</iframe>$3]]),
    parse({ trig = 'img', dscr = 'HTML - Defines an image' },
        [[<img src="$1" alt="$2"/>$3]]),
    parse({ trig = 'input', dscr = 'HTML - Defines an input field' },
        [[<input type="$1" name="$2" value="$3">$4]]),
    parse({ trig = 'ins', dscr = 'HTML - Defines inserted text' },
        [[<ins>$1</ins>$2]]),
    parse({ trig = 'keygen', dscr = 'HTML - Defines a generated key in a form' },
        [[<keygen name="$1">$2]]),
    parse({ trig = 'kbd', dscr = 'HTML - Defines keyboard text' },
        [[<kbd>$1</kbd>$2]]),
    parse({ trig = 'label', dscr = 'HTML - Defines an inline window' },
        [[<label for="$1">$2</label>$3]]),
    parse({ trig = 'legend', dscr = 'HTML - Defines a title in a fieldset' },
        [[<legend>$1</legend>$2]]),
    parse({ trig = 'li', dscr = 'HTML - Defines a list item' },
        [[<li>$1</li>$2]]),
    parse({ trig = 'link', dscr = 'HTML - Defines a resource reference' },
        [[<link rel="$1" type="$2" href="$3">$4]]),
    parse({ trig = 'main', dscr = 'HTML - Defines an image map' },
        [[
        <main>
            $1
        </main>
        ]]),
    parse({ trig = 'map', dscr = 'HTML - Defines an image map' },
        [[
        <map name="$1">
            $2
        </map>
        ]]),
    parse({ trig = 'mark', dscr = 'HTML - Defines marked text' },
        [[<mark>$1</mark>$2]]),
    parse({ trig = 'menu', dscr = 'HTML - Defines a menu list' },
        [[
        <menu>
            $1
        </menu>
        ]]),
    parse({ trig = 'menuitem', dscr = 'HTML - Defines a menu item [firefox only]' },
        [[<menuitem>$1</menuitem>$2]]),
    parse({ trig = 'meta', dscr = 'HTML - Defines meta information' },
        [[<meta name="$1" content="$2">$3]]),
    parse({ trig = 'meter', dscr = 'HTML - Defines measurement within a predefined range' },
        [[<meter value="$1">$2</meter>$3]]),
    parse({ trig = 'nav', dscr = 'HTML - Defines navigation links' },
        [[
        <nav>
            $1
        </nav>
        ]]),
    parse({ trig = 'noscript', dscr = 'HTML - Defines a noscript section' },
        [[
        <noscript>
        $1
        </noscript>
        ]]),
    parse({ trig = 'object', dscr = 'HTML - Defines an embedded object' },
        [[<object width="$1" height="$2" data="$3">$4</object>$5]]),
    parse({ trig = 'ol', dscr = 'HTML - Defines an ordered list' },
        [[
        <ol>
            $1
        </ol>
        ]]),
    parse({ trig = 'optgroup', dscr = 'HTML - Defines an option group' },
        [[
        <optgroup>
            $1
        </optgroup>
        ]]),
    parse({ trig = 'option', dscr = 'HTML - Defines an option in a drop-down list' },
        [[<option value="$1">$2</option>$3]]),
    parse({ trig = 'output', dscr = 'HTML - Defines some types of output' },
        [[<output name="$1" for="$2">$3</output>$4]]),
    parse({ trig = 'p', dscr = 'HTML - Defines a paragraph' },
        [[<p>$1</p>$2]]),
    parse({ trig = 'param', dscr = 'HTML - Defines a parameter for an object' },
        [[<param name="$1" value="$2">$3]]),
    parse({ trig = 'pre', dscr = 'HTML - Defines preformatted text' },
        [[<pre>$1</pre>]]),
    parse({ trig = 'progress', dscr = 'HTML - Defines progress of a task of any kind' },
        [[<progress value="$1" max="$2">$3</progress>$4]]),
    parse({ trig = 'q', dscr = 'HTML - Defines a short quotation' },
        [[<q>$1</q>$2]]),
    parse(
        {
            trig = 'rp',
            dscr = 'HTML - Used in ruby annotations to define what to show browsers that do not support the ruby element'
        },
        [[<rp>$1</rp>$2]]),
    parse({ trig = 'rt', dscr = 'HTML - Defines explanation to ruby annotations' },
        [[<rt>$1</rt>$2]]),
    parse({ trig = 'ruby', dscr = 'HTML - Defines ruby annotations' },
        [[
        <ruby>
        $1
        </ruby>
        ]]),
    parse({ trig = 's', dscr = 'HTML - Used to define strikethrough text' },
        [[<s>$1</s>$2]]),
    parse({ trig = 'samp', dscr = 'HTML - Defines sample computer code' },
        [[<samp>$1</samp>$2]]),
    parse({ trig = 'script', dscr = 'HTML - Defines a script' },
        [[
        <script>
            $1
        </script>
        ]]),
    parse({ trig = 'section', dscr = 'HTML - Defines a section' },
        [[
        <section>
            $1
        </section>
        ]]),
    parse({ trig = 'select', dscr = 'HTML - Defines a selectable list' },
        [[
        <select>
            $1
        </select>
        ]]),
    parse({ trig = 'small', dscr = 'HTML - Defines small text' },
        [[<small>$1</small>$2]]),
    parse({ trig = 'source', dscr = 'HTML - Defines media resource' },
        [[<source src="$1" type="$2">$3]]),
    parse({ trig = 'span', dscr = 'HTML - Defines a section in a document' },
        [[<span>$1</span>$2]]),
    parse({ trig = 'strong', dscr = 'HTML - Defines strong text' },
        [[<strong>$1</strong>$2]]),
    parse({ trig = 'style', dscr = 'HTML - Defines a style definition' },
        [[
        <style>
            $1
        </style>
        ]]),
    parse({ trig = 'sub', dscr = 'HTML - Defines sub-scripted text' },
        [[<sub>$1</sub>$2]]),
    parse({ trig = 'sup', dscr = 'HTML - Defines super-scripted text' },
        [[<sup>$1</sup>$2]]),
    parse({ trig = 'summary', dscr = 'HTML - Defines a visible heading for the detail element [limited support]' },
        [[<summary>$1</summary>$2]]),
    parse({ trig = 'table', dscr = 'HTML - Defines a table' },
        [[
        <table>
            $1
        </table>
        ]]),
    parse({ trig = 'tbody', dscr = 'HTML - Defines a table body' },
        [[
        <tbody>
            $1
        </tbody>
        ]]),
    parse({ trig = 'td', dscr = 'HTML - Defines a table cell' },
        [[<td>$1</td>$2]]),
    parse({ trig = 'textarea', dscr = 'HTML - Defines a text area' },
        [[<textarea rows="$1" cols="$2">$3</textarea>$4]]),
    parse({ trig = 'tfoot', dscr = 'HTML - Defines a table footer' },
        [[
        <tfoot>
            $1
        </tfoot>
        ]]),
    parse({ trig = 'thead', dscr = 'HTML - Defines a table head' },
        [[
        <thead>
        $1
        </thead>
        ]]),
    parse({ trig = 'th', dscr = 'HTML - Defines a table header' },
        [[<th>$1</th>$2]]),
    parse({ trig = 'time', dscr = 'HTML - Defines a date/time' },
        [[<time datetime="$1">$2</time>$3]]),
    parse({ trig = 'title', dscr = 'HTML - Defines the document title' },
        [[<title>$1</title>$2]]),
    parse({ trig = 'tr', dscr = 'HTML - Defines a table row' },
        [[<tr>$1</tr>$2]]),
    parse({ trig = 'track', dscr = 'HTML - Defines a table row' },
        [[<track src="$1" kind="$2" srclang="$3" label="$4">$5]]),
    parse({ trig = 'u', dscr = 'HTML - Used to define underlined text' },
        [[<u>$1</u>$2]]),
    parse({ trig = 'ul', dscr = 'HTML - Defines an unordered list' },
        [[
        <ul>
            $1
        </ul>
        ]]),
    parse({ trig = 'var', dscr = 'HTML - Defines a variable' },
        [[<var>$1</var>$2]]),
    parse({ trig = 'video', dscr = 'HTML - Defines a video' },
        [[
        <video width="$1" height="$2" controls>
            $3
        </video>
        ]])
}

for _, v in ipairs(require('snippets.xml')) do
    table.insert(snips, v)
end

return snips
