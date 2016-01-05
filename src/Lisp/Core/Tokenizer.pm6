use v6;

unit class Lisp::Core::Tokenizer;

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
    make ('str' => $<chars>.made)
}

method atom:sym<number>($/) {
    make ('num' => +$/.Str)
}

method atom:sym<true>($/) {
    make ('bool' => Bool::True)
}

method atom:sym<false>($/) {
    make ('bool' => Bool::False)
}

method atom:sym<symbol>($/) {
    make ('sym' => ~$/.Str)
}

## List
method make_list($/) {
    make ('list' => $<elts>.made)
}

method list:sym<parens>($/) { self.make_list($/) }

