use v6;

unit grammar Lisp::Core::Grammar;

token TOP { \s* [<any>]* % \s* }

proto token any {*}
token any:sym<atom> { <atom> }
token any:sym<list> { <list> }

# Atom (scalar) value
proto token atom {*}
token atom:sym<number> {
    ['-'|'+']? \d+ ['.' \d+]?
}
token atom:sym<string> { '"' ~ '"' <chars> }
token atom:sym<true> { 'true' }
token atom:sym<false> { 'false' }
token atom:sym<symbol> { [<-[\s()\[\]\"]>]+ } 

# List 
proto rule list {*}
rule list:sym<parens> { '(' ~ ')' <elts> }

token elts { 
    [<any>]* % \s*
}

token chars { <-[\"]>* }
