# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
our $MATCH = Perlito5::Match->new();
package main;
package Perlito5::Grammar::Use;
use Perlito5::Precedence;
use Perlito5::Grammar;
Perlito5::Precedence::add_term(('no' => sub {
    Perlito5::Grammar::Use->term_use($_[0], $_[1])
}));
Perlito5::Precedence::add_term(('use' => sub {
    Perlito5::Grammar::Use->term_use($_[0], $_[1])
}));
((my  $perl5lib) = './src5/lib');
sub Perlito5::Grammar::Use::use_decl {
    ((my  $grammar) = $_[0]);
    ((my  $str) = $_[1]);
    ((my  $pos) = $_[2]);
    ((my  $MATCH) = Perlito5::Match->new(('str' => $str), ('from' => $pos), ('to' => $pos)));
    ((my  $tmp) = (((do {
    ((my  $pos1) = $MATCH->{'to'});
    (((do {
    (('use' eq substr($str, $MATCH->{'to'}, 3)) && (($MATCH->{'to'} = (3 + $MATCH->{'to'}))))
})) || ((do {
    ($MATCH->{'to'} = $pos1);
    (((('no' eq substr($str, $MATCH->{'to'}, 2)) && (($MATCH->{'to'} = (2 + $MATCH->{'to'}))))))
})))
}))));
    ($tmp ? $MATCH : 0)
};
sub Perlito5::Grammar::Use::term_use {
    ((my  $grammar) = $_[0]);
    ((my  $str) = $_[1]);
    ((my  $pos) = $_[2]);
    ((my  $MATCH) = Perlito5::Match->new(('str' => $str), ('from' => $pos), ('to' => $pos)));
    ((my  $tmp) = (((do {
    ((my  $pos1) = $MATCH->{'to'});
    ((do {
    (((((((do {
    ((my  $m2) = $grammar->use_decl($str, $MATCH->{'to'}));
    if ($m2) {
        ($MATCH->{'to'} = $m2->{'to'});
        ($MATCH->{'use_decl'} = $m2);
        1
    }
    else {
        0
    }
})) && ((do {
    ((my  $m2) = Perlito5::Grammar->ws($str, $MATCH->{'to'}));
    if ($m2) {
        ($MATCH->{'to'} = $m2->{'to'});
        1
    }
    else {
        0
    }
}))) && ((do {
    ((my  $m2) = Perlito5::Grammar->full_ident($str, $MATCH->{'to'}));
    if ($m2) {
        ($MATCH->{'to'} = $m2->{'to'});
        ($MATCH->{'Perlito5::Grammar.full_ident'} = $m2);
        1
    }
    else {
        0
    }
}))) && ((do {
    ((my  $m) = $MATCH);
    if (!(((do {
    ((my  $pos1) = $MATCH->{'to'});
    ((do {
    (((('-' eq substr($str, $MATCH->{'to'}, 1)) && (($MATCH->{'to'} = (1 + $MATCH->{'to'}))))) && ((do {
    ((my  $m2) = Perlito5::Grammar->ident($str, $MATCH->{'to'}));
    if ($m2) {
        ($MATCH->{'to'} = $m2->{'to'});
        if (exists($MATCH->{'Perlito5::Grammar.ident'})) {
            push(@{$MATCH->{'Perlito5::Grammar.ident'}}, $m2 )
        }
        else {
            ($MATCH->{'Perlito5::Grammar.ident'} = [$m2])
        };
        1
    }
    else {
        0
    }
})))
}))
})))) {
        ($MATCH = $m)
    };
    1
}))) && ((do {
    ((my  $m2) = Perlito5::Expression->list_parse($str, $MATCH->{'to'}));
    if ($m2) {
        ($MATCH->{'to'} = $m2->{'to'});
        ($MATCH->{'Perlito5::Expression.list_parse'} = $m2);
        1
    }
    else {
        0
    }
}))) && ((do {
    ((my  $ast) = Perlito5::AST::Use->new(('code' => $MATCH->{'use_decl'}->flat()), ('mod' => $MATCH->{'Perlito5::Grammar.full_ident'}->flat())));
    parse_time_eval($ast);
    ($MATCH->{'capture'} = ['term', $ast]);
;
    1
})))
}))
}))));
    ($tmp ? $MATCH : 0)
};
sub Perlito5::Grammar::Use::parse_time_eval {
    ((my  $self) = shift());
    ((my  $module_name) = $self->mod());
    ((my  $use_or_not) = $self->code());
    if ((($module_name eq 'v5') || ($module_name eq 'feature'))) {

    }
    else {
        if (($module_name eq 'strict')) {
            if (($use_or_not eq 'use')) {
                Perlito5::strict->import()
            }
            else {
                if (($use_or_not eq 'no')) {
                    Perlito5::strict->unimport()
                }
            }
        }
    }
};
sub Perlito5::Grammar::Use::emit_time_eval {
    ((my  $self) = shift());
    if (($self->mod() eq 'strict')) {
        if (($self->code() eq 'use')) {
            Perlito5::strict->import()
        }
        else {
            if (($self->code() eq 'no')) {
                Perlito5::strict->unimport()
            }
        }
    }
};
sub Perlito5::Grammar::Use::modulename_to_filename {
    ((my  $s) = shift());
    return ((Perlito5::Runtime::_replace($s, '::', '/') . '.pm'))
};
sub Perlito5::Grammar::Use::expand_use {
    ((my  $comp_units) = shift());
    ((my  $stmt) = shift());
    ((my  $module_name) = $stmt->mod());
    if (((($module_name eq 'v5') || ($module_name eq 'strict')) || ($module_name eq 'feature'))) {
        return ()
    };
    ((my  $filename) = modulename_to_filename($module_name));
    if (!(exists($INC{$filename}))) {
        ((my  $realfilename) = ($perl5lib . '/' . $filename));
        ($INC{$filename} = $realfilename);
        ((my  $source) = Perlito5::IO::slurp($realfilename));
        ((my  $m) = Perlito5::Grammar->exp_stmts($source, 0));
        if (($m->{'to'} != length($source))) {
            die('Syntax Error near ', $m->{'to'})
        };
        push(@{$comp_units}, @{add_comp_unit([Perlito5::AST::CompUnit->new(('name' => 'main'), ('body' => $m->flat()))])} )
    }
};
sub Perlito5::Grammar::Use::add_comp_unit {
    ((my  $parse) = shift());
    ((my  $comp_units) = []);
    for my $comp_unit (@{$parse}) {
        if ($comp_unit->isa('Perlito5::AST::Use')) {
            expand_use($comp_units, $comp_unit)
        }
        else {
            if ($comp_unit->isa('Perlito5::AST::CompUnit')) {
                for my $stmt (@{$comp_unit->body()}) {
                    if ($stmt->isa('Perlito5::AST::Use')) {
                        expand_use($comp_units, $stmt)
                    }
                }
            }
        };
        push(@{$comp_units}, $comp_unit )
    };
    return ($comp_units)
};
sub Perlito5::Grammar::Use::require {
    ((my  $filename) = shift());
    if (exists($INC{$filename})) {
        if ($INC{$filename}) {
            return (1)
        };
        die('Compilation failed in require')
    };
    (my  $realfilename);
    (my  $result);
    (my  $found);
    for my $prefix (@INC) {
        ($realfilename = ($prefix . '/' . $filename));
        if ((!($found) && -f($realfilename))) {
            ($INC{$filename} = $realfilename);
            ($result = (do { my $m = Perlito5::Grammar->exp_stmts("do {" .     Perlito5::IO::slurp($realfilename) . "}", 0);my $source = $m->flat()->[0]->emit_perl5(0, "scalar");eval $source;}));
            ($found = 1)
        }
    };
    if ($found) {

    }
    else {
        die(('Can' . chr(39) . 't find ' . $filename . ' in @INC'))
    };
    if ($@) {
        ($INC{$filename} = undef());
        die($@)
    }
    else {
        if (!($result)) {
            delete($INC{$filename});
            die(($filename . ' did not return true value'))
        }
        else {
            return ($result)
        }
    }
};
1;

1;
