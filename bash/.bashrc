previewFileWithSyntaxHighlighting () {
    # This function uses fzf to select a file and bat to preview the contents of the selected file with syntax highlighting.
    fzf --preview-window='60%,wrap' --preview 'bat {} --style=numbers --color=always'
}

previewtldrpages () {
    tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70%,wrap 
}


alias fzfp=previewFileWithSyntaxHighlighting
alias tldrp=previewtldrpages