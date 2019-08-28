# dimfocus.vim
Another Vim plugin inspired to extend focusing event. Provide a simple way 
to dim a inactive window.

## Installation
Use your favorite plugin manager, and add to your `.vimrc`: 

### [dein.vim][]
```vim
call dein#add('sinetoami/dimfocus.vim')
```
Run `:so %` and `:call dein#install()`.

### [vim-plug][]
```vim
Plug 'sinetoami/dimfocus.vim'
```
Run `:so %` and `:PlugInstall`.

## Configuration
It's possible define a custom color of `foreground` and `background` to a 
inactive window. And disable the dimming action by filtering `filetype` 
and/or `buffername`.

### `g:dimfocus#fg` [list]
Set a `foreground` color. Default is `['gray', 'gray']`.
#### Example
```vim
"" [guifg, ctermfg]
let g:dimfocus#fg = ['#ffffff', 255] 
```

### `g:dimfocus#bg` [list]
Set a `background` color. Default is `['darkred', 'darkred']`. 
#### Example
```vim
"" [guibg, ctermbg]
let g:dimfocus#bg = ['#2d2a2e', '234'] 
```

### `g:dimfocus#blacklist` [dictionary]
Defines a filtering to disable dimming action by `filetype` and/or `buffername`. 
Default is:
```vim
let s:blacklist = {
\ 'buffername': ['__LanguageClient__'],
\ 'filetype': ['diff', 'fugitiveblame', 'undotree', 'qf', 'quickfix'],
\}
```

It's incremental, so you can define new values:
#### Example
```vim
let g:dimfocus#blacklist = {
\ 'buffername': ['#FZF'],
\ 'filetype': ['nerdtree', 'tagbar'],
\}
```

### `g:loaded_dimfocus`
Set this variable if you want to disable this plugin. Default is `1`.

## Contributing
- To ask about the contents of the configuration, send me a feedback, 
    request features or report bugs, please open a GitHub issue.
- Open a pull-request if you want to improve this plugin. 
    I will glad to see your idea.

## Self-Promotion
Do you like this plugin? Come on:
- Star and follow the repository on [GitHub](https://github.com/sinetoami/dimfocus.vim).
- Follow me on
  - [GitHub](https://github.com/sinetoami)

## Many thanks to
- [Greg][] - who [write this great feature][] which I hack it to make this 
    plugin.

## License
[MIT License](LICENSE)

[dein.vim]: https://github.com/Shougo/dein.vim
[vim-plug]: https://github.com/junegunn/vim-plug
[Greg]: https://github.com/wincent
[write this great feature]: https://github.com/wincent/wincent
