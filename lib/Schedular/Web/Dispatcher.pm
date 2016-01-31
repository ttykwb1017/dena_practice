package Schedular::Web::Dispatcher;
# 文法チェック
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

# my $xx; スカラ変数の定義
# my @xx; 配列変数の定義
# $i++ iをインクリメント
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
