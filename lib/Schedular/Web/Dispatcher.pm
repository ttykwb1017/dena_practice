package Schedular::Web::Dispatcher;
# $BJ8K!%A%'%C%/(B
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

# my $xx; $B%9%+%iJQ?t$NDj5A(B
# my @xx; $BG[NsJQ?t$NDj5A(B
# $i++ i$B$r%$%s%/%j%a%s%H(B
get '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

get '/user' => sub{
    my ($c) = @_;
    my $namae = "Tetsuya Kawabe";
    my $nenrei = "23";
    my $syozoku = "Mech. Eng. Osaka Univ.";
    my $syumi = "cycling, watching tennis games";

    return $c->render('user.tx', {
        namae => $namae,
        nenrei => $nenrei,
        syozoku => $syozoku,
        syumi => $syumi,
    });
 
 
};

1;
