# grep and Basic Regular Expressions (BRE) mode
By default, grep uses Basic Regular Expressions (BRE), a standard defined by POSIX. The specific patterns that are valid depend on which flags are used with the command, as grep also supports Extended Regular Expressions (ERE) and Perl-Compatible Regular Expressions (PCRE) with the appropriate flags. 

## Basic Regular Expressions (BRE) - Default
In BRE, several meta-characters lose their special meaning and **must** be escaped with a backslash (\) to be interpreted as special operators. 
Pattern 	Description	Example (unescaped)	Example (BRE grep)
> .	- Matches any single character.	a.b matches acb, a1b.	grep 'a.b'
> ^	- Matches the start of a line.	^start	grep '^start'
> $	- Matches the end of a line.	end$	grep 'end$'
> [abc]	- Matches any single character in the set.	[Tt]est matches Test, test.	grep '[Tt]est'
> [^abc] - Matches any single character not in the set.	[^0-9] matches any non-digit.	grep '[^0-9]'
> *	- Matches the preceding item zero or more times.	a*b matches b, ab, aab.	grep 'a*b'
> \\? - Matches the preceding item zero or one time (optional).	colou?r matches color, colour.	grep 'colou\?r'
> \\+ - Matches the preceding item one or more times.	a+b matches ab, aab (not b).	grep 'a\+b'
> \\{n,m\\} - Matches the preceding item between n and m times.	[0-9]{3} matches exactly three digits.	grep '[0-9]\{3\}'
> \| - Alternation ("OR").	`cat	dog`
> \\(\\) - Grouping subexpressions and back-references.	(a)\1 matches aa, bb.	grep '\(a\)\1'

## Other grep Regex Modes
You can enable other, more extensive, regex syntaxes using command-line flags: 
**Extended Regular Expressions (ERE):** Use the -E flag (or the deprecated egrep command). This syntax is more standard as it removes the need to escape ?, +, {, |, (, and ) for them to be treated as special characters.
**Perl-Compatible Regular Expressions (PCRE):** Use the -P flag. This offers advanced features like lookaheads ((?=...)), lookbehinds ((?<=...)), and non-greedy matching (*?) that are not available in BRE or ERE. Note that -P is a non-standard extension and may not be available in all grep implementations (e.g., BSD grep).