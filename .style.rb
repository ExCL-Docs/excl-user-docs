all
rule 'MD013', :line_length => 500 # Line length
rule 'MD007', :indent => 4 # Unordered list indentation
# exclude_rule 'MD025' # Multiple top level headers in the same document
exclude_rule 'MD032' # Lists should be surrounded by blank lines
# exclude_rule 'MD041' # First line in file should be a top level header
# exclude_rule 'MD022' # Headers should be surrounded by blank lines (Disabled for false positives)
exclude_rule 'MD031' # Fenced code blocks should be surrounded by blank lines
