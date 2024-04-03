#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <sqlite_file> '<partial_book_title>' '<author_name>'"
    exit 1
fi

SQLITE_FILE="$1"
BOOK_TITLE="$2"
AUTHOR_NAME="$3"

SQL_QUERY=$(cat <<EOF
SELECT c.BookTitle, REPLACE(REPLACE(c.Title, 'xhtml/', ''), '.xhtml', ''), REPLACE(REPLACE(b.Text, CHAR(10), ' '), CHAR(13), ' ')
  FROM Bookmark b
  LEFT JOIN content c
    ON b.ContentID = c.ContentID
 WHERE c.BookTitle LIKE '%$BOOK_TITLE%'
   AND b.Text is not NULL
 ORDER BY b.DateCreated ASC;
EOF
)

counterFile=$(mktemp)
sqlite3 -separator $'\t' "$SQLITE_FILE" "$SQL_QUERY" | while IFS=$'\t' read -r bookTitle chapterTitle text; do
    bookDir="${bookTitle//[^a-zA-Z0-9]/_}"
    mkdir -p "$bookDir"

    bookFile="$bookDir/${bookTitle}.md"
    if [[ ! -f "$bookFile" ]]; then
      cat <<- EOF > "$bookFile"
			---
			date:
			  - "$(date +'%Y-%m-%d')"
			tags:
			  - "#citation"
			author:
			  - "[[$AUTHOR_NAME]]"
			title:
			  - "$bookTitle"
			medium:
			  - "[[Book]]"
			link:
			  - ""
			---
			# ${bookTitle}
			
			## Notes
			
			\`\`\`dataview
			LIST
			WHERE contains(link, "[[$bookTitle]]") OR contains(link, [[$bookTitle]])
			SORT location ASC
			\`\`\`
			
			## Summary
			
			## Key take-away(s)
			
			## Fun quotes
			EOF
    fi

    chapterFile="$bookDir/${bookTitle} - ${chapterTitle}.md"
    if [[ ! -f "$chapterFile" ]]; then
      cat <<- EOF > "$chapterFile"
			---
			date:
			  - "$(date +'%Y-%m-%d')"
			tags:
			  - "#literature"
			author:
			  - "[[$AUTHOR_NAME]]"
			title:
			  - "$chapterTitle"
			medium:
			  - "[[Book]]"
			link:
			  - "[[$bookTitle]]"
			---
			# $bookTitle - $chapterTitle
			
			EOF
    fi

    echo -e "> $text\n" >> "$chapterFile"
    echo "X" >> "$counterFile"
done

echo "Total highlights exported: $(wc -l < "$counterFile")"
