use v6;

unit grammar Lisp::Core::Grammar;

token TOP { \s* [<any>]* % \s* }

proto token any {*}
token any:sym<atom> { <atom> }
token any:sym<list> { <list> }

# Atom (scalar) value
proto token atom {*}
token atom:sym<number> {
    ['-'|'+']? # Optional leading sign
    [0 | <[1..9]> <[0..9]>*] # Integer part
    ['.' <[0..9]>+]? # Fractional part
}
token atom:sym<string> { '"' ~ '"' <chars> }
token atom:sym<true> { 'true' }
token atom:sym<false> { 'false' }
token atom:sym<symbol> { [<-[\s()\"]>]+ } 

# List 
rule list { '(' ~ ')' <elts> }
token elts { 
    [<any>]* % \s* 
}

token chars { <-[\"]>* }
