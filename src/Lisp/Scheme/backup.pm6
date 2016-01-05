use v6;

unit class Lisp::Scheme::Preprocessor;

#need:
# list[sym(define) sym(identity) list[sym(lambda) list[sym(x)] sym(x)]]
# list[sym(define) sym(identity) list[sym(lambda) list[sym(x)] sym(x)]]
#have:
# list[sym(define) list[sym(identity) sym(x)] sym(x)]

use Lisp::Core::SymTok;
use Lisp::Core::ScalarTok;
use Lisp::Core::ListTok;

# (define (identity x) x)

sub gen_lambda(@params, $exprs) {
    say 'gen lambda!';
    ListTok.new(
	val => [
	    SymTok.new(val => 'lambda'),
	    ListTok.new(val => @params),
	    $exprs
	]
    )
}

sub preprocess_def($name_tok is rw, $val_tok is rw) {
    given $name_tok {
	when ListTok {
	    my ($name, @args) = $name_tok.val;
	    $name_tok = $name;
	    $val_tok = gen_lambda(@args, $val_tok);
	}
    }
    
    # say $name;
    # say $val;
}

sub preprocess_list($elts is rw) {
    if 'define' eq $elts[0].val {
	$elts = preprocess_def($elts[0], $elts[1], $elts[2]);
    }
}

sub preprocess_token($token) {    
    given $token {
	when ListTok { preprocess_list($token.val) }
    }
}

method run(@tokens) {
    # say ~@tokens;
    for @tokens -> $token {
	preprocess_token($token);
    }
    say ~@tokens;
}
