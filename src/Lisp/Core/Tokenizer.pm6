use v6;

unit class Lisp::Core::Tokenizer;

#use Lisp::Core::ScalarTok;
#use Lisp::Core::SymTok;
#use Lisp::Core::ListTok;

method TOP($/) {
    # Construct all tokens and filter out comments with `grep`
    make [grep *.defined, $/.values.map(*.made)]
}

method any:sym<comment>($/) {}

method any:sym<atom>($/) {
    make $<atom>.made
}

method any:sym<list>($/) {
    make $<list>.made
}

method chars($/) {
    make ~$/.Str
}

method elts($/) {
    make [grep *.defined, $<any>.map(*.made)]
}

## Atom
method atom:sym<string>($/) {
    make (str => $<chars>.made)
    # make ScalarTok.new(val => $<chars>.made)
}

method atom:sym<number>($/) {
    make (num => +$/.Str)
    # make ScalarTok.new(val => +$/.Str)
}

method atom:sym<true>($/) {
    make (bool => True)
    # make ScalarTok.new(val => True)
}

method atom:sym<false>($/) {
    make (bool => False)
    # make ScalarTok.new(val => False)
}

method atom:sym<symbol>($/) {
    make (sym => ~$/.Str)
    # make SymTok.new(val => ~$/.Str)
}

## List
method make_list($/) {
    make (list => $<elts>.made)
    # make ListTok.new(val => $<elts>.made)
}

method list:sym<parens>($/) { self.make_list($/) }

