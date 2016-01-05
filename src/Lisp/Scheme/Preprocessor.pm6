use v6;

unit class Lisp::Scheme::Preprocessor;

sub gen_lambda(Array $params, List $exprs) {
    list => [
	sym => 'lambda',
	list => @$params
    ].append(@$exprs)
}

sub desugar_lambda(Pair $params, List $exprs) {
    list => [
	sym => 'define',
	$params.value[0],
	gen_lambda([$params.value[1..*]], $exprs)
    ]
}

sub desugar_let(Pair $bindings, List $exprs) {
    list => [
    	gen_lambda($bindings.value.map(*.value[0]).Array, preprocess_tokens($exprs))
    ].append($bindings.value.map(*.value[1]))
}

sub preprocess_def($list) {
    if 'list' eq $list.value[1].key {
	desugar_lambda(
	    $list.value[1],
	    $list.value[2..*]
	    # preprocess_token($list.value[2..*])
	);
    } else { list => preprocess_tokens($list.value).Array }
}

sub preprocess_list($list) {
    given $list.value[0].value {
	when 'define' { preprocess_def($list) }
	when 'let' { desugar_let($list.value[1], $list.value[2..*]) }
	default { list => preprocess_tokens($list.value).Array }
    }
}

sub preprocess_token($token) {
    given $token.key {
	when 'list' { preprocess_list($token) }
	default { $token } 
    }
}

sub preprocess_tokens(List $tokens) {
    $tokens.map({ preprocess_token($_) }).List
}

method run(@tokens) {
    preprocess_tokens(@tokens)
}
